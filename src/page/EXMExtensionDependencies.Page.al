page 83219 "EXM Extension Dependencies"
{
    Caption = 'EXM Extension Dependencies', comment = 'ESP="Dependencias extensión"';
    PageType = List;
    SourceTable = "EXM Extension Dependencies";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Dependent Ext. Code"; Rec."Dependent Ext. Code")
                {
                    ApplicationArea = All;
                }
                field("Dependent Ext. Name"; Rec."Dependent Ext. Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}