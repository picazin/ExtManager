table 83203 "EXM Table Fields"
{
    Caption = 'Extension Fields', Comment = 'ESP="Campos extensión"';
    DataClassification = OrganizationIdentifiableInformation;
    LookupPageId = "EXM Field List";

    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "EXM Extension Header";
            trigger OnValidate()
            var
                ExtHeader: Record "EXM Extension Header";
            begin
                ExtHeader.Get("Extension Code");
                "Customer No." := ExtHeader."Customer No.";
            end;
        }
        field(2; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.', Comment = 'ESP="Nº línea origen"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "Table Source Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionCaption = ',Table,,,,,,,,,,,,,,TableExt,,,,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,,,,,,,,,,,,,TableExt,,,,,,,,,,,,,,,,,,,,,,, "';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
        }
        field(4; "Source Table ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Table ID', Comment = 'ESP="Id. tabla origen"';
            DataClassification = OrganizationIdentifiableInformation;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Field ID", SetFieldID("Source Table ID", "Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(5; "Table ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Table ID', Comment = 'ESP="Id. tabla"';
            DataClassification = OrganizationIdentifiableInformation;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Field ID", SetFieldID("Source Table ID", "Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(6; "Field ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Field ID', Comment = 'ESP="Id. campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name', Comment = 'ESP="Nombre de campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(8; "Field Caption"; Text[250])
        {
            Caption = 'Field Caption', Comment = 'ESP="Título campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(9; "Data Type"; Option)
        {
            Caption = 'Data Type', Comment = 'ESP="Tipo datos"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = " ";
            OptionMembers = TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,Code,Binary,BLOB,Boolean,Integer,OemCode,Option,BigInteger,Duration,GUID,DateTime," ";
        }
        field(10; Lenght; Integer)
        {
            BlankZero = true;
            Caption = 'Lenght', Comment = 'ESP="Longitud"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(11; "Field Class"; Option)
        {
            Caption = 'Field Class', Comment = 'ESP="Clase campo"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Normal,FlowField,FlowFilter;
        }
        field(12; "Option String"; Text[250])
        {
            Caption = 'Option String', Comment = 'ESP="Texto opciones"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(13; Obsolete; Boolean)
        {
            Caption = 'Obsolete', Comment = 'ESP="Obsoleto"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(14; "Created by"; Code[50])
        {
            Caption = 'Created by', Comment = 'ESP="Creado por"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(15; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', Comment = 'ESP="Fecha creación"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(16; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
        }
        field(20; IsPK; Boolean)
        {
            Caption = 'Is Part Of Primary Key', Comment = 'ESP="Forma parte clave primária"';
            DataClassification = OrganizationIdentifiableInformation;
        }

    }
    keys
    {
        key(PK; "Extension Code", "Source Line No.", "Table Source Type", "Source Table ID", "Table ID", "Field ID")
        {
            Clustered = true;
        }
        key(K2; "Source Table ID", "Table ID", "Field ID")
        { }
        key(K3; "Source Table ID", "Field ID")
        { }
    }

    trigger OnInsert()
    begin
        "Created by" := CopyStr(UserId(), 1, MaxStrLen("Created by"));
        "Creation Date" := CurrentDateTime();

        ValidateData();
    end;

    local procedure SetFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]) FieldID: Integer
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMSetup: Record "EXM Extension Setup";
        EXMFields: Record "EXM Table Fields";
        IsHandled: Boolean;
        ExpectedId: Integer;
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Field ID" then
            exit;

        IsHandled := false;
        OnBeforeCalculateFieldID(SourceTableID, TableID, CustNo, FieldID, IsHandled);
        if IsHandled then
            exit(FieldID);

        EXMExtHeader.Get("Extension Code");
        if SourceTableID = 0 then
            EXMFields.SetCurrentKey("Source Table ID", "Table ID", "Field ID")
        else begin
            EXMFields.SetCurrentKey("Source Table ID", "Field ID");
            EXMFields.SetFilter("Field ID", '%1..%2', EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
        end;

        EXMFields.SetFilter("Customer No.", CustNo);
        EXMFields.SetRange("Source Table ID", SourceTableID);
        if SourceTableID = 0 then
            EXMFields.SetRange("Table ID", TableID);
        if not EXMFields.IsEmpty() then begin
            if EXMSetup."Find Object ID Gaps" then begin
                EXMFields.FindSet();
                if "Table Source Type" = "Table Source Type"::Table then
                    ExpectedId := 1
                else
                    ExpectedId := EXMExtHeader."Object Starting ID";
                repeat
                    if ExpectedId <> EXMFields."Field ID" then
                        exit(ExpectedId)
                    else
                        ExpectedId += 1;
                until EXMFields.Next() = 0;
                FieldID := ExpectedId;
            end else begin
                EXMFields.FindLast();
                FieldID := EXMFields."Field ID" + 1;
            end;
        end else
            if "Table Source Type" = "Table Source Type"::Table then
                FieldID := 1
            else
                FieldID := EXMExtHeader."Object Starting ID";

        OnAfterAssignFieldID(SourceTableID, TableID, CustNo, FieldID);

        exit(FieldID);
    end;

    local procedure ValidateData()
    var
        EXMExtMgt: Codeunit "EXM Extension Management";
        SelectDataTypeErr: Label 'Must select a data type.', Comment = 'ESP="Debe seleccionar un tipo de datos."';
    begin
        case "Table Source Type" of
            "Table Source Type"::Table:
                begin
                    TestField("Source Table ID", 0);
                    TestField("Table ID");
                end;
            "Table Source Type"::"TableExtension":
                begin
                    TestField("Source Table ID");
                    TestField("Table ID");
                end;
        end;

        TestField("Field ID");
        TestField("Field Name");

        if "Data Type" = "Data Type"::" " then
            Error(SelectDataTypeErr);

        if ("Data Type" in ["Data Type"::Text, "Data Type"::Code]) then
            TestField(Lenght);

        if "Table Source Type" = "Table Source Type"::"TableExtension" then
            EXMExtMgt.ValidateExtensionRangeID("Extension Code", "Field ID");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]; var FieldID: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]; var FieldID: Integer)
    begin
    end;
}