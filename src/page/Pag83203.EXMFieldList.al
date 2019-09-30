page 83203 "EXM Field List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "EXM Extension Lines Detail";

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
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }
                field("Table ID"; "Table ID")
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
                    Editable = false;
                }
                field("Field Caption"; "Field Caption")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Data Type"; "Data Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Lenght; Lenght)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Field Class"; "Field Class")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Option String"; "Option String")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}