page 83214 "EXM Object Detail"
{
    Caption = 'Objects Detail', Comment = 'ESP="Detalle Objetos"';
    Editable = false;
    PageType = List;
    SourceTable = "EXM Extension Lines";
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                { }
                field("Object ID"; Rec."Object ID")
                { }
                field(Name; Rec.Name)
                { }
                field("Source Object Type"; Rec."Source Object Type")
                {
                    Visible = SourceVisible;
                }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    Visible = SourceVisible;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre Origen"';
                    Visible = SourceVisible;
                }
                field("Total Fields"; Rec."Total Fields")
                {
                    ToolTip = 'Shows the value of the Total fields field', Comment = 'ESP="Especifica el valor del campo Campos relacionados"';
                    Visible = FieldsVisible;
                    trigger OnAssistEdit()
                    begin
                        ViewRelatedFields();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SourceVisible := (Rec."Source Object Type" <> Rec."Source Object Type"::" ");
        FieldsVisible := Rec."Object Type" in [Rec."Object Type"::Table, Rec."Object Type"::"TableExtension", Rec."Object Type"::Enum, Rec."Object Type"::EnumExtension]
    end;

    var
        FieldsVisible, SourceVisible : Boolean;

    local procedure ViewRelatedFields()
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMTableFields: Record "EXM Table Fields";
        EXMEnumVal: Page "EXM Enum Values";
        EXMFieldList: Page "EXM Field List";
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
}
