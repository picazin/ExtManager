table 83208 "EXM Extension Dependencies"
{
    Caption = 'Extension Dependencies', comment = 'ESP="Dependencias extensión"';
    DataClassification = SystemMetadata;
    DrillDownPageId = "EXM Extension Dependencies";
    LookupPageId = "EXM Extension Dependencies";

    fields
    {
        field(1; "Extensión Code"; Code[20])
        {
            Caption = 'Extensión Code', comment = 'ESP="Cód. extensión"';
            DataClassification = SystemMetadata;
            TableRelation = "EXM Extension Header";
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = Customer;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.', comment = 'ESP="Nº línea"';
            DataClassification = SystemMetadata;
        }
        field(10; "Dependent Ext. Code"; Code[20])
        {
            Caption = 'Dependent Ext. Code', comment = 'ESP="Cód. extensión dependiente"';
            DataClassification = SystemMetadata;
            TableRelation = "EXM Extension Header";

            trigger OnValidate()
            var
                ExtHeader: Record "EXM Extension Header";
            begin
                if xRec."Dependent Ext. Code" <> Rec."Dependent Ext. Code" then
                    if Rec."Dependent Ext. Code" = '' then
                        Rec."Dependent Ext. Name" := ''
                    else begin
                        ExtHeader.Get(Rec."Dependent Ext. Code");
                        Rec."Dependent Ext. Name" := ExtHeader.Description;
                    end;
            end;

            trigger OnLookup()
            var
                AvailableExt: Record "EXM Extension Header";
                ExtHeader: Record "EXM Extension Header";
                ExtHeaderList: Page "EXM Extension List";
            begin
                ExtHeader.Get("Extensión Code");

                AvailableExt.SetFilter(Code, '<>%1', Rec."Extensión Code");
                if ExtHeader.Type = ExtHeader.Type::Internal then
                    AvailableExt.SetRange(Type, AvailableExt.Type::Internal)
                else
                    AvailableExt.SetFilter("Customer No.", '%1|%2', '', ExtHeader."Customer No.");

                ExtHeaderList.LookupMode(true);
                ExtHeaderList.SetTableView(AvailableExt);
                if ExtHeaderList.RunModal() = Action::LookupOK then begin
                    ExtHeaderList.GetRecord(AvailableExt);
                    Rec.Validate("Dependent Ext. Code", AvailableExt.Code);
                end;
            end;

        }
        field(15; "Dependent Ext. Name"; Text[100])
        {
            Caption = 'Dependent Ext. Name', comment = 'ESP="Nombre extensión dependiente"';
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