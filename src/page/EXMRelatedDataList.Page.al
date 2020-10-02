page 83216 "EXM Related Data List"
{

    ApplicationArea = All;
    Caption = 'EXM Related tables fields', comment = 'ESP="EXM Campos tablas relacionadas"';
    PageType = List;
    SourceTable = "EXM Related Groups";
    UsageCategory = Administration;
    Editable = false;
    CardPageId = "EXM Related Data";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Related Tables No."; Rec."Related Tables No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}