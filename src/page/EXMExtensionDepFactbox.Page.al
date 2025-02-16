page 83220 "EXM Extension Dep. Factbox"
{
    Caption = 'Extension dependencies', Comment = 'ESP="Dependencias extensión"';
    Editable = false;
    PageType = ListPart;
    SourceTable = "EXM Extension Dependencies";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Dependent Ext. Code"; Rec."Dependent Ext. Code")
                { }
                field("Dependent Ext. Name"; Rec."Dependent Ext. Name")
                { }
            }
        }
    }
}