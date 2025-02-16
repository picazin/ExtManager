page 83204 "EXM TableExt Field List"
{
    Caption = 'TableExtensions Fields', Comment = 'ESP="Campos TableExtensions"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "EXM Table Fields";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; Rec."Extension Code")
                { }
                field("Source Table ID"; Rec."Source Table ID")
                {
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    Visible = false;
                }
                field("Field ID"; Rec."Field ID")
                { }
                field("Field Name"; Rec."Field Name")
                { }
                field("Data Type"; Rec."Data Type")
                { }
                field(Lenght; Rec.Lenght)
                { }
                field("Field Class"; Rec."Field Class")
                { }
                field("Option String"; Rec."Option String")
                { }
                field(Obsolete; Rec.Obsolete)
                { }
                field("Created by"; Rec."Created by")
                { }
                field("Creation Date"; Rec."Creation Date")
                { }
            }
        }
    }
}