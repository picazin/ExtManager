page 83210 "EXM Enum Values"
{
    Caption = 'Enum', Comment = 'ESP="Enum"';
    DataCaptionExpression = GetDesc();
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "EXM Enum Values";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; Rec."Extension Code")
                {
                    Visible = false;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Source Enum ID"; Rec."Source Enum ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Enum ID"; Rec."Enum ID")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Ordinal ID"; Rec."Ordinal ID")
                { }
                field("Enum Value"; Rec."Enum Value")
                { }
                field("Created by"; Rec."Created by")
                {
                    Visible = IsVisible;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    Visible = IsVisible;
                }
            }
            part(ExtEnumDetail; "EXM EnumExt Values")
            {
                Editable = false;
                ShowFilter = false;
                SubPageLink = "Source Type" = filter("EnumExtension"), "Source Enum ID" = field("Source Enum ID");
                SubPageView = sorting("Source Enum ID", "Ordinal ID");
                Visible = ViewEnumExtDetail;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AllEnumValues)
            {
                ApplicationArea = All;
                Caption = 'View / Hide values', Comment = 'ESP="Ver / ocultar valores"';
                Enabled = (Rec."Source Type" = Rec."Source Type"::"EnumExtension");
                Image = ResetStatus;
                ToolTip = 'Executes the View / Hide values action to view other values for same table on other extensions.', Comment = 'ESP="Ver / ocultar valores del resto de extensiones para la misma tabla."';

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
                ApplicationArea = All;
                Caption = 'View source Enum', Comment = 'ESP="Ver Enum origen"';
                Enabled = (Rec."Source Type" = Rec."Source Type"::"EnumExtension");
                Image = Table;
                ToolTip = 'View source Enum values', Comment = 'ESP="Ver valores de Enum origen"';
                Visible = IsVisible;

                trigger OnAction()
                var
                    EXMExtMgt: Codeunit "EXM Extension Management";
                begin
                    EXMExtMgt.GetEnumValues(Rec."Source Enum ID");
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(AllEnumValues_Promoted; AllEnumValues)
                { }
                actionref(ViewSourceEnum_Promoted; ViewSourceEnum)
                { }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IsVisible := not Rec.IsTemporary;
        if not IsVisible then
            CurrPage.Editable(false);
    end;

    var
        ViewEnumExtDetail: Boolean;
        IsVisible: Boolean;

    local procedure GetDesc(): Text
    var
        AllObject: Record AllObj;
        EXMExtLine: Record "EXM Extension Lines";
    begin
        if Rec.IsTemporary then begin
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
}