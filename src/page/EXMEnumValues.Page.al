page 83210 "EXM Enum Values"
{
    Caption = 'Enum', Comment = 'ESP="Enum"';
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
                    Visible = IsVisible;
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
                    Visible = false;
                }
                field("Source Enum ID"; "Source Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Enum ID"; "Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
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
                    Visible = IsVisible;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                    Visible = IsVisible;
                }
            }
            part(ExtEnumDetail; "EXM EnumExt Values")
            {
                ApplicationArea = All;
                SubPageLink = "Source Type" = filter("EnumExtension"), "Source Enum ID" = field("Source Enum ID");
                SubPageView = sorting("Source Enum ID", "Ordinal ID");
                Visible = ViewEnumExtDetail;
                Editable = false;
                ShowFilter = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AllEnumValues)
            {
                Caption = 'View / Hide values', Comment = 'ESP="Ver / ocultar valores"';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ResetStatus;
                Enabled = ("Source Type" = "Source Type"::"EnumExtension");

                trigger OnAction()
                begin
                    if ViewEnumExtDetail then
                        ViewEnumExtDetail := false
                    else
                        ViewEnumExtDetail := true;
                end;
            }
            action(ViewSourceEnum)
            {
                Caption = 'View source Enum', Comment = 'ESP="Ver Enum origen"';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Table;
                Enabled = ("Source Type" = "Source Type"::"EnumExtension");
                Visible = IsVisible;

                trigger OnAction()
                var
                    EXMExtMgt: Codeunit "EXM Extension Management";
                begin
                    EXMExtMgt.GetEnumValues("Source Enum ID");
                end;
            }
        }
    }
    local procedure GetDesc(): Text
    var
        AllObject: Record AllObj;
        EXMExtLine: Record "EXM Extension Lines";
    begin
        if IsTemporary then begin
            AllObject.Get(AllObject."Object Type"::Enum, "Enum ID");
            exit(Format("Enum ID") + ' ' + AllObject."Object Name");
        end;

        EXMExtLine.Get("Extension Code", "Source Line No.");
        if Rec."Source Type" = Rec."Source Type"::"EnumExtension" then begin
            AllObject.Get(AllObject."Object Type"::Enum, "Source Enum ID");
            exit(Format("Source Enum ID") + ' ' + AllObject."Object Name" + ' - ' + Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
        end else
            exit(Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
    end;

    trigger OnOpenPage()
    begin
        IsVisible := not IsTemporary;
        if not IsVisible then
            CurrPage.Editable(false);
    end;

    var
        ViewEnumExtDetail: Boolean;
        [InDataSet]
        IsVisible: Boolean;
}