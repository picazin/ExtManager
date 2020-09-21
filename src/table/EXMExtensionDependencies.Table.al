table 83208 "EXM Extension Dependencies"
{
    Caption = 'Extension Dependencies', comment = 'ESP="Dependencias extensión"';
    DataClassification = SystemMetadata;
    LookupPageId = "EXM Extension Dependencies";
    DrillDownPageId = "EXM Extension Dependencies";

    fields
    {
        field(1; "Extensión Code"; Code[20])
        {
            Caption = 'Extensión Code';
            DataClassification = SystemMetadata;
            TableRelation = "EXM Extension Header";
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(10; "Dependent Ext. Code"; Code[20])
        {
            Caption = 'Dependent Ext. Code';
            DataClassification = SystemMetadata;
            TableRelation = "EXM Extension Header";
            trigger OnValidate()
            var
                ExtHeader: Record "EXM Extension Header";
            begin
                if xRec."Dependent Ext. Code" <> "Dependent Ext. Code" then
                    if "Dependent Ext. Code" = '' then
                        "Dependent Ext. Name" := ''
                    else begin
                        ExtHeader.Get("Dependent Ext. Code");
                        "Dependent Ext. Name" := ExtHeader.Description;
                    end;
            end;
        }
        field(15; "Dependent Ext. Name"; Text[100])
        {
            Caption = 'Dependent Ext. Name';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Extensión Code", "Line No.")
        {
            Clustered = true;
        }
    }
}