table 83206 "EXM Related Groups"
{
    Caption = 'EXM Related Groups';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'ESP="Código"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description', comment = 'ESP="Descripción"';
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

    trigger OnDelete()
    var
        RelLines: Record "EXM Related Lines";
    begin
        RelLines.SetRange(Code, Code);
        RelLines.DeleteAll();
    end;
}
