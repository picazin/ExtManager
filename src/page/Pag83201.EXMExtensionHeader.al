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
                    Caption = 'Object Range', Comment = 'ESP="Rango objetos"';
                    field("Object Starting ID"; "Object Starting ID")
                    {
                        Caption = 'Starting No.', Comment = 'ESP="Nº inicial"';
                        ApplicationArea = All;
                    }
                    field("Object Ending ID"; "Object Ending ID")
                    {
                        Caption = 'Ending No.', Comment = 'ESP="Nº final"';
                        ApplicationArea = All;
                    }
                }
            }
            part(ExtLines; "EXM Extension Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Extension Code" = field (Code);
            }
            part(Detail; "EXM Field List")
            {
                ApplicationArea = All;
            }
        }
    }
}