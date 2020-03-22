page 83205 "EXM Extension Manager Setup"
{
    Caption = 'Extension Setup', Comment = 'ESP="Conf. extensiones"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "EXM Extension Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Extension Nos."; "Extension Nos.")
                {
                    ApplicationArea = All;
                }
                field("Default Object Starting ID"; "Default Object Starting ID")
                {
                    ApplicationArea = All;
                }
                field("Default Object Ending ID"; "Default Object Ending ID")
                {
                    ApplicationArea = All;
                }
                field("Object Names"; "Object Names")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}