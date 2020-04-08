pageextension 83200 "EXM Customer List" extends "Customer List"
{
    actions
    {
        addlast("&Customer")
        {
            action(EXMALExtensions)
            {
                Caption = 'Extensions', Comment = 'ESP="Extensiones"';
                ApplicationArea = All;
                Image = Design;
                Promoted = true;
                PromotedCategory = Category7;
                RunObject = Page "EXM Extension List";
                RunPageLink = "Customer No." = field("No.");
            }
        }
    }
}