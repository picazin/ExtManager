page 83210 "EXM Enum Values"
{
    PageType = List;
    SourceTable = "EXM Enum Values";
    DelayedInsert = true;
    Editable = true;
    DataCaptionExpression = GetDesc();

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
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Visible = false;
                }
                field("Source Enum ID"; "Source Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Visible = false;
                }
                field("Enum ID"; "Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //Visible = false;
                }
                field("Ordinal ID"; "Ordinal ID")
                {
                    ApplicationArea = All;
                }
                field("Enum Value"; "Enum Value")
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
            /*
            part(ExtTableExtDetail; "EXM TableExt Field List")
            {
                ApplicationArea = All;
                SubPageLink = "Table Source Type" = filter("TableExtension"), "Source Table ID" = field("Source Table ID");
                SubPageView = sorting("Source Table ID", "Field ID");
                Visible = ViewTableExtDetail;
                Editable = false;
                ShowFilter = false;
            }
            */
        }
    }
    actions
    {
        /*
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
                Enabled = ("Table Source Type" = "Table Source Type"::"TableExtension");

                trigger OnAction()
                begin
                    if ViewTableExtDetail then
                        ViewTableExtDetail := false
                    else
                        ViewTableExtDetail := true;
                end;
            }
            action(ViewSourceTable)
            {
                Caption = 'View source table', Comment = 'ESP="Ver tabla origen"';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Table;
                Enabled = ("Table Source Type" = "Table Source Type"::"TableExtension");

                trigger OnAction()
                var
                    EXMExtMgt: Codeunit "EXM Extension Management";
                begin
                    EXMExtMgt.GetTableFieldData("Source Table ID");
                end;
            }
        }
        */
    }

    local procedure GetDesc(): Text
    var
        AllObject: Record AllObj;
        EXMExtLine: Record "EXM Extension Lines";
    begin
        EXMExtLine.Get("Extension Code", "Source Line No.");
        if Rec."Source Type" = Rec."Source Type"::"EnumExtension" then begin
            AllObject.Get(AllObject."Object Type"::Enum, "Source Enum ID");
            exit(Format("Source Enum ID") + ' ' + AllObject."Object Name" + ' - ' + Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
        end else
            exit(Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
    end;

    var
        ViewTableExtDetail: Boolean;
}