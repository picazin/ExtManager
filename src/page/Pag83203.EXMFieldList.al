page 83203 "EXM Field List"
{
    PageType = List;
    SourceTable = "EXM Extension Lines Detail";
    DelayedInsert = true;
    Editable = true;

    //TODO Mostrar ID + nom taula

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; "Extension Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Source Line No."; "Source Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
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
            }
        }
    }
}