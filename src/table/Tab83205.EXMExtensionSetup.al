table 83205 "EXM Extension Setup"
{
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', Comment = 'ESP=""';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; "Extension Nos."; Code[20])
        {
            Caption = 'Extension Nos.', Comment = 'ESP="Nº série extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "No. Series";
        }
        field(3; "Default Object Starting ID"; Integer)
        {
            Caption = 'Default Starting Range', Comment = 'ESP="Rango inicial por defecto"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                EXMExtMgt.AllowedObjectsID("Default Object Starting ID");
            end;
        }
        field(4; "Default Object Ending ID"; Integer)
        {
            Caption = 'Default Ending Range', Comment = 'ESP="Rango final por defecto"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                EXMExtMgt.AllowedObjectsID("Default Object Ending ID");
            end;
        }
        field(5; "Object Names"; Option)
        {
            Caption = 'Object Names', Comment = 'ESP="Nombre objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Caption,Name;
            OptionCaption = 'Caption,Name', Comment = 'ESP="Traducción,Original"';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}