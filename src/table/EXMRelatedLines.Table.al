table 83207 "EXM Related Lines"
{
    Caption = 'EXM Related Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'ESP="Código"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "EXM Related Groups";
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID', comment = 'ESP="ID Tabla"';
            DataClassification = OrganizationIdentifiableInformation;
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));

            trigger OnValidate()
            var
                ExtMngt: Codeunit "EXM Extension Management";
            begin
                if xRec."Table ID" <> "Table ID" then
                    Name := ExtMngt.GetObjectName(1, "Table ID");
            end;
        }
        field(3; Name; Text[250])
        {
            Caption = 'Name', comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
    }
    keys
    {
        key(PK; Code, "Table ID")
        {
            Clustered = true;
        }
    }
}
