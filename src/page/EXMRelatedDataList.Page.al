page 83216 "EXM Related Data List"
{
    ApplicationArea = All;
    Caption = 'EXM Related tables fields', comment = 'ESP="EXM Campos tablas relacionadas"';
    CardPageId = "EXM Related Data";
    Editable = false;
    PageType = List;
    SourceTable = "EXM Related Groups";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field', comment = 'ESP="Especifica el valor del campo Código"';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field', comment = 'ESP="Especifica el valor del campo Descripción"';
                }
                field("Related Tables No."; "Related Tables No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Related Tables No. field', comment = 'ESP="Muestra el Nº tablas relacionadas"';
                }
            }
        }
    }
}