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
                field("Extension Nos."; "Extension Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extension Nos. field', Comment = 'ESP="Especifica el valor del campo Nº série extensión"';
                }
                field("Object Names"; "Object Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Names field', Comment = 'ESP="Especifica el valor del campo Nombre objetos"';
                }
                field("Default Object Starting ID"; "Default Object Starting ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Starting Range field', Comment = 'ESP="Especifica el valor del campo Rango inicial por defecto."';
                }
                field("Default Object Ending ID"; "Default Object Ending ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Ending Range field', Comment = 'ESP="Especifica el valor del campo Rango final por defecto"';
                }
                field("Find Object ID Gaps"; "Find Object ID Gaps")
                {
                    ApplicationArea = All;
                    ToolTip = 'Always find for possible gaps between IDs.', comment = 'ESP="Buscar siempre huecos entre los ID."';
                }

            }
            group(Advanced)
            {
                Caption = 'Advanced Options', Comment = 'ESP="Opciones avanzadas"';
                field("Disable Auto. Objects ID"; "Disable Auto. Objects ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow to disable automatic ID assginment for Objects', Comment = 'ESP="Permite deshabilitar la asignación de ID a los objetos"';
                }
                field("Disable Auto. Field ID"; "Disable Auto. Field ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Allow to disable automatic ID assginment for Fields', Comment = 'ESP="Permite deshabilitar la asignación del ID  a los campos"';
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
                ApplicationArea = All;
                Caption = 'Donate', Comment = 'ESP="Donar"';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
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
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;
}