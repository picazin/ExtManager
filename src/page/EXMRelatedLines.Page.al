page 83218 "EXM Related Lines"
{

    Caption = 'EXM Related Lines';
    PageType = ListPart;
    SourceTable = "EXM Related Lines";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}