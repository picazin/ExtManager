page 83218 "EXM Related Lines"
{
    Caption = 'EXM Related Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "EXM Related Lines";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                { }
                field(Name; Rec.Name)
                { }
            }
        }
    }
}