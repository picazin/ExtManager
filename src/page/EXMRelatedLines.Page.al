page 83218 "EXM Related Lines"
{
    Caption = 'EXM Related Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "EXM Related Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Table ID field', comment = 'ESP="Especifica el valor del campo ID Tabla"';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field', comment = 'ESP="Especifica el valor del campo Nombre"';
                }
            }
        }
    }
}