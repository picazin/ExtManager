page 83217 "EXM Related Data"
{
    Caption = 'EXM - Create fields on related tables', comment = 'ESP="EXM - Crear campos en tablas relacionadas"';
    PageType = Document;
    SourceTable = "EXM Related Groups";

    layout
    {
        area(content)
        {
            group(General)
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
            }
            part(Lines; "EXM Related Lines")
            {
                ApplicationArea = All;
                Caption = 'Related tables', comment = 'ESP="Tablas relacionadas"';
                SubPageLink = Code = field(Code);
            }
        }
    }
}