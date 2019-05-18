page 83205 "Extension Manager Setup"
{
    Caption = 'Extension Setup', Comment = 'ESP="Conf. extensiones"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Extension Setup";
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