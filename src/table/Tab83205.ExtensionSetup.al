table 83205 "Extension Setup"
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
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}