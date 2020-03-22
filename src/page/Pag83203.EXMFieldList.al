page 83203 "EXM Field List"
{
    //Caption = 'Extension Card', Comment = 'ESP="Ficha extensión"';
    PageType = List;
    SourceTable = "EXM Extension Lines Detail";
    DelayedInsert = true;
    Editable = true;

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
                }
                field("Source Line No."; "Source Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Table Source Type"; "Table Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Source Table ID"; "Source Table ID")
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
                    Editable = (("Data Type" = "Data Type"::Text) or ("Data Type" = "Data Type"::Code));
                }
                field("Field Class"; "Field Class")
                {
                    ApplicationArea = All;
                }
                field("Option String"; "Option String")
                {
                    ApplicationArea = All;
                    Editable = ("Data Type" = "Data Type"::Option);
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
            part(ExtTableExtDetail; "EXM TableExt Field List")
            {
                ApplicationArea = All;
                SubPageLink = "Table Source Type" = filter(TableExt), "Source Table ID" = field("Source Table ID");
                SubPageView = sorting("Source Table ID", "Field ID");
                Visible = ViewTableExtDetail;
                Editable = false;
                ShowFilter = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AllFields)
            {
                Caption = 'View / Hide fields', Comment = 'ESP="Ver / ocultar campos"';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ResetStatus;
                Enabled = ("Table Source Type" = "Table Source Type"::TableExt);

                trigger OnAction()
                begin
                    if ViewTableExtDetail then
                        ViewTableExtDetail := false
                    else
                        ViewTableExtDetail := true;
                end;
            }
        }
    }

    var
        ViewTableExtDetail: Boolean;
}