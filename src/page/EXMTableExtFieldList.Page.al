page 83204 "EXM TableExt Field List"
{
    Caption = 'TableExtensions Fields', Comment = 'ESP="Campos TableExtensions"';
    PageType = ListPart;
    SourceTable = "EXM Table Fields";
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
                field("Source Table ID"; Rec."Source Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                }
                field(Lenght; Rec.Lenght)
                {
                    ApplicationArea = All;
                }
                field("Field Class"; Rec."Field Class")
                {
                    ApplicationArea = All;
                }
                field("Option String"; Rec."Option String")
                {
                    ApplicationArea = All;
                }
                field(Obsolete; Rec.Obsolete)
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