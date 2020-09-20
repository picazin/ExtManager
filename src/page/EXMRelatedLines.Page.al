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
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
