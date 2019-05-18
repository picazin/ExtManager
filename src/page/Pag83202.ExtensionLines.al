page 83202 "Extension Lines"
{
    Caption = 'Lines', Comment = 'ESP="Líneas"';
    PageType = ListPart;
    SourceTable = "Extension Lines";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; "Name")
                {
                    ApplicationArea = All;
                }
                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; "Source Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Fields"; "Total Fields")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}