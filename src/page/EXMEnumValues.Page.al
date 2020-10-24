page 83210 "EXM Enum Values"
{
    Caption = 'Enum', Comment = 'ESP="Enum"';
    DataCaptionExpression = GetDesc();
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "EXM Enum Values";

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; "Extension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Cód. extensión."';
                    Visible = false;
                }
                field("Source Line No."; "Source Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source Line No. field', Comment = 'ESP="Especifica el valor del campo Nº línea origen"';
                    Visible = false;
                }
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source Type field', Comment = 'ESP="Especifica el valor del campo Tipo origen"';
                    Visible = false;
                }
                field("Source Enum ID"; "Source Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Source Enum ID field', Comment = 'ESP="Especifica el valor del campo Id. Enum origen"';
                    Visible = false;
                }
                field("Enum ID"; "Enum ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Enum ID field', Comment = 'ESP="Especifica el valor del campo Id. Enum"';
                    Visible = false;
                }
                field("Ordinal ID"; "Ordinal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ordinal ID field', Comment = 'ESP="Especifica el valor del campo Id. ordinal"';
                }
                field("Enum Value"; "Enum Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enum Value field', Comment = 'ESP="Especifica el valor del campo Valor Enum"';
                }
                field("Created by"; "Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created by field', Comment = 'ESP="Especifica el valor del campo Creado por"';
                    Visible = IsVisible;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field', Comment = 'ESP="Especifica el valor del campo Fecha creación"';
                    Visible = IsVisible;
                }
            }
            part(ExtEnumDetail; "EXM EnumExt Values")
            {
                ApplicationArea = All;
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
                Enabled = ("Source Type" = "Source Type"::"EnumExtension");
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
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
                Enabled = ("Source Type" = "Source Type"::"EnumExtension");
                Image = Table;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'View source Enum values', Comment = 'ESP="Ver valores de Enum origen"';
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
}