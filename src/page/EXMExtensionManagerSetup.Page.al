page 83205 "EXM Extension Manager Setup"
{
    ApplicationArea = All;
    Caption = 'Extension Manager Setup', Comment = 'ESP="Conf. gestor extensiones"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "EXM Extension Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ESP="General"';
                field("Extension Nos."; Rec."Extension Nos.")
                { }
                field("Object Names"; Rec."Object Names")
                { }
                field("Default Object Starting ID"; Rec."Default Object Starting ID")
                { }
                field("Default Object Ending ID"; Rec."Default Object Ending ID")
                { }
                field("Find Object ID Gaps"; Rec."Find Object ID Gaps")
                { }
            }
            group(Advanced)
            {
                Caption = 'Advanced Options', Comment = 'ESP="Opciones avanzadas"';
                field("Disable Auto. Objects ID"; Rec."Disable Auto. Objects ID")
                { }
                field("Disable Auto. Field ID"; Rec."Disable Auto. Field ID")
                { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Donate)
            {
                ApplicationArea = All;
                Caption = 'Donate', Comment = 'ESP="Donar"';
                Image = Payment;
                ToolTip = 'Thanks developer with an small tip.', Comment = 'ESP="Agradece al desarrollador con una propina."';

                trigger OnAction()
                var
                    DonateQst: Label 'If you are enjoying this extension and want to thank me for my work, please donate.', Comment = 'ESP="Si te ha resultado útil esta extensión y quieres agradecer mi trabajo, por favor, haz un donativo!!"';
                begin
                    if Confirm(DonateQst, true) then
                        Hyperlink('https://paypal.me/picazin');
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(Donate_Promoted; Donate)
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}