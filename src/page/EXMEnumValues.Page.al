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
                field("Extension Code"; Rec."Extension Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Source Enum ID"; Rec."Source Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Enum ID"; Rec."Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Ordinal ID"; Rec."Ordinal ID")
                {
                    ApplicationArea = All;
                }
                field("Enum Value"; Rec."Enum Value")
                {
                    ApplicationArea = All;
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    Visible = IsVisible;
                }
                field("Creation Date"; Rec."Creation Date")
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
                Enabled = (Rec."Source Type" = Rec."Source Type"::"EnumExtension");

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
                Enabled = (Rec."Source Type" = Rec."Source Type"::"EnumExtension");
                Visible = IsVisible;

                trigger OnAction()
                var
                    EXMExtMgt: Codeunit "EXM Extension Management";
                begin
                    EXMExtMgt.GetEnumValues(Rec."Source Enum ID");
                end;
            }
        }
    }
    local procedure GetDesc(): Text
    var
        AllObject: Record AllObj;
        EXMExtLine: Record "EXM Extension Lines";
    begin
        if Rec.IsTemporary() then begin
            AllObject.Get(AllObject."Object Type"::Enum, Rec."Enum ID");
            exit(Format(Rec."Enum ID") + ' ' + AllObject."Object Name");
        end;

        EXMExtLine.Get(Rec."Extension Code", Rec."Source Line No.");
        if Rec."Source Type" = Rec."Source Type"::"EnumExtension" then begin
            AllObject.Get(AllObject."Object Type"::Enum, Rec."Source Enum ID");
            exit(Format(Rec."Source Enum ID") + ' ' + AllObject."Object Name" + ' - ' + Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
        end else
            exit(Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
    end;

    trigger OnOpenPage()
    begin
        IsVisible := not Rec.IsTemporary();
        if not IsVisible then
            CurrPage.Editable(false);
    end;

    var
        ViewEnumExtDetail: Boolean;
        [InDataSet]
        IsVisible: Boolean;
}