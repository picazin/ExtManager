page 83219 "EXM Extension Dependencies"
{
    AutoSplitKey = true;
    Caption = 'EXM Extension Dependencies', comment = 'ESP="Dependencias extensión"';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "EXM Extension Dependencies";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Dependent Ext. Code"; "Dependent Ext. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dependent Ext. Code field', comment = 'ESP="Especifica el valor del campo Cód. extensión dependiente"';
                }
                field("Dependent Ext. Name"; "Dependent Ext. Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dependent Ext. Name field', comment = 'ESP="Especifica el valor del campo Nombre extensión dependiente"';
                }
            }
        }
    }
}