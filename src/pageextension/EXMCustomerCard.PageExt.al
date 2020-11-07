pageextension 83201 "EXM Customer Card" extends "Customer Card"
{
    actions
    {
        addlast("&Customer")
        {
            action(EXMALExtensions)
            {
                ApplicationArea = All;
                Caption = 'Extensions', Comment = 'ESP="Extensiones"';
                Image = Design;
                Promoted = true;
                PromotedCategory = Category9;
                RunObject = Page "EXM Extension List";
                RunPageLink = "Customer No." = field("No.");
                ToolTip = 'View Customer Extensions.', Comment = 'ESP="Ver las extensiones del cliente."';
            }
        }
    }
}