page 83220 "EXM Extension Dep. Factbox"
{
    Caption = 'Extension dependencies', Comment = 'ESP="Dependencias extensión"';
    Editable = false;
    PageType = ListPart;
    SourceTable = "EXM Extension Dependencies";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Dependent Ext. Code"; Rec."Dependent Ext. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dependent Ext. Code field', comment = 'ESP="Especifica el valor del campo Cód. extensión dependiente"';
                }
                field("Dependent Ext. Name"; Rec."Dependent Ext. Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dependent Ext. Name field', comment = 'ESP="Especifica el valor del campo Nombre extensión dependiente"';
                }
            }
        }
    }
}