page 83211 "EXM EnumExt Values"
{
    Caption = 'EnumExt Values', Comment = 'ESP="Valores EnumExt"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "EXM Enum Values";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; Rec."Extension Code")
                { }
                field("Ordinal ID"; Rec."Ordinal ID")
                { }
                field("Enum Value"; Rec."Enum Value")
                { }
                field("Created by"; Rec."Created by")
                { }
                field("Creation Date"; Rec."Creation Date")
                { }
            }
        }
    }
}