page 83205 "EXM Extension Manager Setup"
{
    Caption = 'Extension Management Setup', Comment = 'ESP="Conf. gestor extensiones"';
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
            group(Advanced)
            {
                Caption = 'Advanced Options', Comment = 'ESP="Opciones avanzadas"';
                field("Disable Auto. Objects ID"; "Disable Auto. Objects ID")
                {
                    ApplicationArea = All;
                }
                field("Disable Auto. Field ID"; "Disable Auto. Field ID")
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
                PromotedIsBig = true;

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
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}