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
                field("Code"; Rec."Code")
                { }
                field(Description; Rec.Description)
                { }
                field("Related Tables No."; Rec."Related Tables No.")
                { }
            }
        }
    }
}