page 83219 "EXM Extension Dependencies"
{
    AutoSplitKey = true;
    Caption = 'EXM Extension Dependencies', comment = 'ESP="Dependencias extensión"';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "EXM Extension Dependencies";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Dependent Ext. Code"; Rec."Dependent Ext. Code")
                { }
                field("Dependent Ext. Name"; Rec."Dependent Ext. Name")
                { }
            }
        }
    }
}