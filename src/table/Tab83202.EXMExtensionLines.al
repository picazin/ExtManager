table 83202 "EXM Extension Lines"
{
    DataClassification = OrganizationIdentifiableInformation;
    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ESP="Nº línea"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type', Comment = 'ESP="Tipo objeto"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = " ",Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExt,TableExt;
            OptionCaption = ' ,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension', Comment = 'ESP=" ,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension"';

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                case "Object Type" of
                    "Object Type"::PageExt:
                        "Source Object Type" := "Source Object Type"::Page;
                    "Object Type"::TableExt:
                        "Source Object Type" := "Source Object Type"::Table;
                    else
                        "Source Object Type" := "Source Object Type"::" "
                end;

                EXMExtHeader.Get("Extension Code");
                Validate("Object ID", SetObjectID("Object Type", EXMExtHeader."Customer No."))
            end;
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID', Comment = 'ESP="ID objeto"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            NotBlank = true;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                //TODO Validate not used (INTERNAL / External)
                EXMExtMgt.ValidateExtensionRangeID("Extension Code", "Object ID");
            end;
        }
        field(5; Name; Text[250])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(6; "Source Object Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = " ",Table,,,,,,,Page;
            OptionCaption = ' ,Table,,,,,,,Page', Comment = 'ESP=" ,Table,,,,,,,Page"';
            trigger OnValidate()
            var
                NotAllowedValueErr: Label 'Source value not allowed.', Comment = 'ESP="Valor no permitido"';
            begin
                case "Object Type" of
                    "Object Type"::Page:
                        TestField("Object Type", "Object Type"::PageExt);
                    "Object Type"::Table:
                        TestField("Object Type", "Object Type"::TableExt);
                    else
                        Error(NotAllowedValueErr);
                end;
            end;
        }
        field(7; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID', Comment = 'ESP="ID objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = field("Source Object Type"));
            BlankZero = true;

            trigger OnValidate()
            begin
                if xRec."Source Object ID" <> "Source Object ID" then
                    "Source Name" := GetObjectName("Source Object Type", "Source Object ID");
            end;
        }
        field(8; "Source Name"; Text[250])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(10; "Total Fields"; Integer)
        {
            Caption = 'Total fields', Comment = 'ESP="Campos relacionados"';
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines Detail" where("Extension Code" = field("Extension Code"), "Source Line No." = field("Line No."), "Table ID" = field("Source Object ID")));
        }
    }

    keys
    {
        key(PK; "Extension Code", "Line No.")
        {
            Clustered = true;
        }
        key(K2; "Extension Code", "Object Type", "Object ID")
        { }
        key(K3; "Extension Code", "Object Type", "Object ID", "Source Object Type", "Source Object ID")
        { }
    }

    trigger OnDelete()
    var
        EXMExtDetail: Record "EXM Extension Lines Detail";
    begin
        EXMExtDetail.SetRange("Extension Code", "Extension Code");
        EXMExtDetail.SetRange("Source Line No.", "Line No.");
        EXMExtDetail.DeleteAll();
    end;

    local procedure SetObjectID(ObjectType: Integer; CustNo: Code[20]): Integer
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMExtLine: Record "EXM Extension Lines";
        EXMExtMgt: Codeunit "EXM Extension Management";
    begin
        //TODO Posar valor inicial o seguent segons extensió disponible (check)
        //TODO Diferenciar per INTERNAL / EXTERNAL
        //TODO Millora - Buscar espai buit dins d'extensió!! 50000, 50004 ha de proposar 50001
        if CustNo <> '' then
            EXMExtLine.SetFilter("Extension Code", EXMExtMgt.GetCustomerExtensions(CustNo))
        else
            EXMExtLine.SetRange("Extension Code", "Extension Code");

        EXMExtLine.SetRange("Object Type", ObjectType);
        if EXMExtLine.FindLast() then
            exit(EXMExtLine."Object ID" + 1)
        else begin
            EXMExtHeader.Get("Extension Code");
            exit(EXMExtHeader."Object Starting ID");
        end;
    end;

    local procedure GetObjectName(ObjectType: Integer; ObjectID: Integer): Text[249]
    var
        AllObj: Record AllObjWithCaption;
        EXMExtSetup: Record "EXM Extension Setup";
    begin
        EXMExtSetup.Get();

        if AllObj.Get(ObjectType, ObjectID) then
            case EXMExtSetup."Object Names" of
                EXMExtSetup."Object Names"::Caption:
                    exit(AllObj."Object Caption");
                EXMExtSetup."Object Names"::Name:
                    exit(AllObj."Object Name");
            end;
    end;
}