page 83204 "EXM TableExt Field List"
{
    Caption = 'TableExt Fields', Comment = 'ESP="Campos TableExt"';
    PageType = ListPart;
    SourceTable = "EXM Extension Lines Detail";
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
                field("Field ID"; "Field ID")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = All;
                }
                field("Data Type"; "Data Type")
                {
                    ApplicationArea = All;
                }
                field(Lenght; Lenght)
                {
                    ApplicationArea = All;
                }
                field("Field Class"; "Field Class")
                {
                    ApplicationArea = All;
                }
                field("Option String"; "Option String")
                {
                    ApplicationArea = All;
                }
                field(Obsolete; Obsolete)
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