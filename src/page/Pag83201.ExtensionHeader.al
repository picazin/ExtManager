page 83201 "EXM Extension Header"
{
    PageType = Document;
    SourceTable = "EXM Extension Header";

    layout
    {
        area(Content)
        {
            group(Header)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }
                field("Type"; "Type")
                {
                    ApplicationArea = All;
                }

                group(ObjectRange)
                {
                    field("Object Ending Range"; "Object Ending Range")
                    {
                        ApplicationArea = All;
                    }
                    field("Object Starting Range"; "Object Starting Range")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(ExtLines; "EXM Extension Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Extension Code" = field (Code);
            }
        }
    }
}