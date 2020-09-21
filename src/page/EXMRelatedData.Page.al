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
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
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