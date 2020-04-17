page 83211 "EXM EnumExt Values"
{
    Caption = 'EnumExt Values', Comment = 'ESP="Valores EnumExt"';
    PageType = ListPart;
    SourceTable = "EXM Enum Values";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; "Extension Code")
                {
                    ApplicationArea = All;
                }
                field("Ordinal ID"; "Ordinal ID")
                {
                    ApplicationArea = All;
                }
                field("Enum Value"; "Enum Value")
                {
                    ApplicationArea = All;
                }
                field("Created by"; "Created by")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}