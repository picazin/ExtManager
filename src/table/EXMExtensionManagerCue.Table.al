table 83204 "EXM Extension Manager Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(10; Extensions; Integer)
        {
            Caption = 'Extensions', Comment = 'ESP="Extensiones"';
            FieldClass = FlowField;
            CalcFormula = Count ("EXM Extension Header");
            Editable = false;
        }
        field(15; "Internal Extensions"; Integer)
        {
            Caption = 'Internal Extensions', Comment = 'ESP="Extensiones internas"';
            FieldClass = FlowField;
            CalcFormula = Count ("EXM Extension Header" where(Type = filter(Internal)));
            Editable = false;
        }
        field(20; "External Extensions"; Integer)
        {
            Caption = 'External Extensions', Comment = 'ESP="Extensiones externas"';
            FieldClass = FlowField;
            CalcFormula = Count ("EXM Extension Header" where(Type = filter(External)));
            Editable = false;
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