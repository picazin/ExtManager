page 83205 "EXM Extension Manager Setup"
{
    Caption = 'Extension Manager Setup', Comment = 'ESP="Conf. gestor extensiones"';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "EXM Extension Setup";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ESP="General"';
                field("Extension Nos."; Rec."Extension Nos.")
                {
                    ApplicationArea = All;
                }
                field("Object Names"; Rec."Object Names")
                {
                    ApplicationArea = All;
                }
                field("Default Object Starting ID"; Rec."Default Object Starting ID")
                {
                    ApplicationArea = All;
                }
                field("Default Object Ending ID"; Rec."Default Object Ending ID")
                {
                    ApplicationArea = All;
                }
                field("Find Object ID Gaps"; Rec."Find Object ID Gaps")
                {
                    ApplicationArea = All;
                    ToolTip = 'Always find for possible gaps between IDs.', comment = 'ESP="Buscar siempre huecos entre los ID."';
                }

            }
            group(Advanced)
            {
                Caption = 'Advanced Options', Comment = 'ESP="Opciones avanzadas"';
                field("Disable Auto. Objects ID"; Rec."Disable Auto. Objects ID")
                {
                    ApplicationArea = All;
                }
                field("Disable Auto. Field ID"; Rec."Disable Auto. Field ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Donate)
            {
                Caption = 'Donate', Comment = 'ESP="Donar"';
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
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