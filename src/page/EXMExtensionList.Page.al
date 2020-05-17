page 83200 "EXM Extension List"
{
    Caption = 'Extension Manager', Comment = 'ESP="Gestor Extensiones"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EXM Extension Header";
    Editable = false;
    CardPageId = "EXM Extension Header";
    RefreshOnActivate = true;
    DataCaptionFields = Description;

    layout
    {
        area(Content)
        {
            repeater(General)
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
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Object Starting ID"; "Object Starting ID")
                {
                    ApplicationArea = All;
                }
                field("Object Ending ID"; "Object Ending ID")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(EXMExtDetail; "EXM Extension FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = FIELD(Code);
            }
        }
    }
}