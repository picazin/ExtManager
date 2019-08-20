page 83202 "EXM Extension Lines"
{
    Caption = ' Objects', Comment = 'ESP="Objetos"';
    PageType = ListPart;
    SourceTable = "EXM Extension Lines";
    SourceTableView = sorting ("Extension Code", "Object Type");
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
                    Editable = (("Object Type" = "Object Type"::TableExt) or ("Object Type" = "Object Type"::PageExt));
                }
                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                    Editable = ("Source Object Type" <> "Source Object Type"::" ");
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