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
                field("Extension Code"; Rec."Extension Code")
                {
                    ApplicationArea = All;
                }
                field("Ordinal ID"; Rec."Ordinal ID")
                {
                    ApplicationArea = All;
                }
                field("Enum Value"; Rec."Enum Value")
                {
                    ApplicationArea = All;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}