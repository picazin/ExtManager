pageextension 83200 "EXM Customer List" extends "Customer List"
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
                RunObject = Page "EXM Extension List";
                RunPageLink = "Customer No." = field("No.");
                ToolTip = 'View Customer Extensions.', Comment = 'ESP="Ver las extensiones del cliente."';
            }
        }
        addlast(Category_Category7)
        {
            actionref(EXMALExtensions_Promoted; EXMALExtensions)
            { }
        }
    }
}