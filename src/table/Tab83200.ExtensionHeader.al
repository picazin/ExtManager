table 83200 "Extension Header"
{
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code', Comment = 'ESP="Código"';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'ESP="Descripción"';
            DataClassification = OrganizationIdentifiableInformation;
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}