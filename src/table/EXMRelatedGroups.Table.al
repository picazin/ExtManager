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
        field(3; "Related Tables No."; Integer)
        {
            Caption = 'Related Tables No.', comment = 'ESP="Nº tablas relacionadas"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count ("EXM Related Lines" where(Code = field(Code)));
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
