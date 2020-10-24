page 83214 "EXM Object Detail"
{
    Caption = 'Objects Detail', Comment = 'ESP="Detalle Objetos"';
    Editable = false;
    PageType = List;
    SourceTable = "EXM Extension Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto"';
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object ID field', Comment = 'ESP="Especifica el valor del campo ID objeto"';
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
                }
                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto origen"';
                    Visible = SourceVisible;
                }
                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Object ID field', Comment = 'ESP="Especifica el valor del campo ID objeto origen"';
                    Visible = SourceVisible;
                }
                field("Source Name"; "Source Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre Origen" ';
                    Visible = SourceVisible;
                }
                field("Total Fields"; "Total Fields")
                {
                    ApplicationArea = All;
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
        SourceVisible := ("Source Object Type" <> "Source Object Type"::" ");
        FieldsVisible := "Object Type" in ["Object Type"::Table, "Object Type"::"TableExtension", "Object Type"::Enum, "Object Type"::EnumExtension]
    end;

    var
        FieldsVisible: Boolean;
        SourceVisible: Boolean;

    local procedure ViewRelatedFields()
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMTableFields: Record "EXM Table Fields";
        EXMEnumVal: Page "EXM Enum Values";
        EXMFieldList: Page "EXM Field List";
    begin
        case "Object Type" of
            "Object Type"::"Table", "Object Type"::"TableExtension":
                begin
                    EXMTableFields.SetRange("Extension Code", "Extension Code");
                    EXMTableFields.SetRange("Source Line No.", "Line No.");
                    EXMTableFields.SetRange("Table Source Type", "Object Type");
                    EXMTableFields.SetRange("Table ID", "Object ID");
                    EXMTableFields.SetRange("Source Table ID", "Source Object ID");


                    EXMFieldList.SetTableView(EXMTableFields);
                    EXMFieldList.LookupMode(true);
                    if EXMFieldList.RunModal() = Action::LookupOK then begin
                        "Total Fields" := GetTotalFields();
                        CurrPage.Update(true);
                    end;
                end;

            "Object Type"::Enum, "Object Type"::EnumExtension:
                begin
                    EXMEnumValues.SetRange("Extension Code", "Extension Code");
                    EXMEnumValues.SetRange("Source Line No.", "Line No.");
                    EXMEnumValues.SetRange("Source Type", "Object Type");
                    EXMEnumValues.SetRange("Enum ID", "Object ID");
                    EXMEnumValues.SetRange("Source Enum ID", "Source Object ID");

                    EXMEnumVal.SetTableView(EXMEnumValues);
                    EXMEnumVal.LookupMode(true);
                    if EXMEnumVal.RunModal() = Action::LookupOK then begin
                        "Total Fields" := GetTotalFields();
                        CurrPage.Update(true);
                    end;
                end;
            else
                exit;
        end;
    end;
}
