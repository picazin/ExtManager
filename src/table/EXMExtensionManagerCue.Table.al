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
            CalcFormula = Count("EXM Extension Header");
            Caption = 'Extensions', Comment = 'ESP="Extensiones"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Internal Extensions"; Integer)
        {
            CalcFormula = Count("EXM Extension Header" where(Type = filter(Internal)));
            Caption = 'Internal Extensions', Comment = 'ESP="Extensiones internas"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "External Extensions"; Integer)
        {
            CalcFormula = Count("EXM Extension Header" where(Type = filter(External)));
            Caption = 'External Extensions', Comment = 'ESP="Extensiones externas"';
            Editable = false;
            FieldClass = FlowField;
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