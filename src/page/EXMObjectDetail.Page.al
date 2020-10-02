page 83214 "EXM Object Detail"
{
    PageType = List;
    SourceTable = "EXM Extension Lines";
    Caption = 'Objects Detail', Comment = 'ESP="Detalle Objetos"';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Source Object Type"; Rec."Source Object Type")
                {
                    ApplicationArea = All;
                    Visible = SourceVisible;
                }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    ApplicationArea = All;
                    Visible = SourceVisible;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    Visible = SourceVisible;
                }
                field("Total Fields"; Rec."Total Fields")
                {
                    ApplicationArea = All;
                    Visible = FieldsVisible;
                    trigger OnAssistEdit()
                    begin
                        ViewRelatedFields();
                    end;
                }
            }
        }
    }
    local procedure ViewRelatedFields()
    var
        EXMTableFields: Record "EXM Table Fields";
        EXMEnumValues: Record "EXM Enum Values";
        EXMFieldList: Page "EXM Field List";
        EXMEnumVal: Page "EXM Enum Values";
    begin
        case Rec."Object Type" of
            Rec."Object Type"::"Table", Rec."Object Type"::"TableExtension":
                begin
                    EXMTableFields.SetRange("Extension Code", Rec."Extension Code");
                    EXMTableFields.SetRange("Source Line No.", Rec."Line No.");
                    EXMTableFields.SetRange("Table Source Type", Rec."Object Type");
                    EXMTableFields.SetRange("Table ID", Rec."Object ID");
                    EXMTableFields.SetRange("Source Table ID", Rec."Source Object ID");


                    EXMFieldList.SetTableView(EXMTableFields);
                    EXMFieldList.LookupMode(true);
                    if EXMFieldList.RunModal() = Action::LookupOK then begin
                        Rec."Total Fields" := Rec.GetTotalFields();
                        CurrPage.Update(true);
                    end;
                end;

            Rec."Object Type"::Enum, Rec."Object Type"::EnumExtension:
                begin
                    EXMEnumValues.SetRange("Extension Code", Rec."Extension Code");
                    EXMEnumValues.SetRange("Source Line No.", Rec."Line No.");
                    EXMEnumValues.SetRange("Source Type", Rec."Object Type");
                    EXMEnumValues.SetRange("Enum ID", Rec."Object ID");
                    EXMEnumValues.SetRange("Source Enum ID", Rec."Source Object ID");

                    EXMEnumVal.SetTableView(EXMEnumValues);
                    EXMEnumVal.LookupMode(true);
                    if EXMEnumVal.RunModal() = Action::LookupOK then begin
                        Rec."Total Fields" := Rec.GetTotalFields();
                        CurrPage.Update(true);
                    end;
                end;
            else
                exit;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SourceVisible := (Rec."Source Object Type" <> Rec."Source Object Type"::" ");
        FieldsVisible := Rec."Object Type" in [Rec."Object Type"::Table, Rec."Object Type"::"TableExtension", Rec."Object Type"::Enum, Rec."Object Type"::EnumExtension]
    end;

    var
        FieldsVisible: Boolean;
        SourceVisible: Boolean;
}
