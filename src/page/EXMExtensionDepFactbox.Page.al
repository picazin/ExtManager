page 83220 "EXM Extension Dep. Factbox"
{
    PageType = ListPart;
    SourceTable = "EXM Extension Dependencies";
    Caption = 'Extension dependencies', Comment = 'ESP="Dependencias extensión"';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Dependent Ext. Code"; "Dependent Ext. Code")
                {
                    ApplicationArea = All;
                }
                field("Dependent Ext. Name"; "Dependent Ext. Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}