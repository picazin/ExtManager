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
            Caption = 'Object Type', Comment = 'ESP="Tipo objecto"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = " ",Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExt,TableExt;
            OptionCaption = ' ,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension', Comment = 'ESP=" ,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension"';

            trigger OnValidate()
            begin
                case "Object Type" of
                    "Object Type"::PageExt:
                        "Source Object Type" := "Source Object Type"::Page;
                    "Object Type"::TableExt:
                        "Source Object Type" := "Source Object Type"::Table;
                    else
                        "Source Object Type" := "Source Object Type"::" "
                end;

                if xRec."Object Type" <> "Object Type" then
                    Name := GetObjectName("Object Type", "Object ID");
            end;
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID', Comment = 'ESP="ID objecto"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            NotBlank = true;
            TableRelation = if ("Object Type" = filter (Codeunit | Page | Query | Report | Table | XMLport)) AllObj."Object ID" where ("Object Type" = field ("Object Type"));
            trigger OnValidate()
            begin
                if xRec."Object ID" <> "Object ID" then
                    Name := GetObjectName("Object Type", "Object ID");
            end;
        }
        field(5; Name; Text[30])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(6; "Source Object Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objecto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = " ",Table,,,,,,,Page;
            OptionCaption = ' ,Table,,,,,,,Page', Comment = 'ESP=" ,Table,,,,,,,Page"';
        }
        field(7; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID', Comment = 'ESP="ID objecto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = AllObjWithCaption."Object ID" where ("Object Type" = field ("Source Object Type"));
            BlankZero = true;

            trigger OnValidate()
            begin

                if xRec."Source Object ID" <> "Source Object ID" then
                    "Source Name" := GetObjectName("Source Object Type", "Source Object ID");
            end;
        }
        field(8; "Source Name"; Text[30])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(10; "Total Fields"; Integer)
        {
            Caption = 'Total fields', Comment = 'ESP="Campos relacionados"';
            DataClassification = OrganizationIdentifiableInformation;
            //CALCFIELD NOVA TAULA EXT LINE DETAIL
        }
    }

    keys
    {
        key(PK; "Extension Code", "Line No.")
        {
            Clustered = true;
        }
        key(PK2; "Extension Code", "Object Type")
        {

        }
    }
    local procedure GetObjectName(ObjectType: Integer; ObjectID: Integer): Text[30]
    var
        AllObj: Record AllObjWithCaption;
    begin
        if not ("Object Type" in ["Object Type"::Table, "Object Type"::TableExt, "Object Type"::Page, "Object Type"::PageExt]) then
            if AllObj.Get(ObjectType, ObjectID) then
                exit(AllObj."Object Caption");
        exit('')
    end;
}