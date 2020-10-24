page 83203 "EXM Field List"
{
    DataCaptionExpression = GetDesc();
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "EXM Table Fields";

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
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Cód. extensión"';
                    Visible = false;
                }
                field("Source Line No."; "Source Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Source Line No. field', Comment = 'ESP="Especifica el valor del campo Nº línea origen"';
                    Visible = false;
                }
                field("Table Source Type"; "Table Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Source Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto origen"';
                    Visible = false;
                }
                field("Source Table ID"; "Source Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Source Table ID field', Comment = 'ESP="Especifica el valor del campo Id. tabla origen"';
                    Visible = false;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Table ID field', Comment = 'ESP="Especifica el valor del campo Id. tabla"';
                    Visible = false;
                }
                field(IsPK; IsPK)
                {
                    ApplicationArea = All;
                    Enabled = ("Source Table ID" = 0);
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Is Part Of Primary Key field', Comment = 'ESP="Especifica el valor del campo Forma parte clave primária"';
                    Visible = PKVisible;
                    trigger OnValidate()
                    begin
                        if xRec.IsPK <> IsPK then
                            CurrPage.Update(true);
                    end;
                }
                field("Field ID"; "Field ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field ID field', Comment = 'ESP="Especifica el valor del campo Id. campo"';
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Name field', Comment = 'ESP="Especifica el valor del campo Nombre de campo"';
                }
                field("Data Type"; "Data Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Data Type field', Comment = 'ESP="Especifica el valor del campo Tipo datos"';
                }
                field(Lenght; Lenght)
                {
                    ApplicationArea = All;
                    Editable = (("Data Type" = "Data Type"::Text) or ("Data Type" = "Data Type"::Code));
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Lenght field', Comment = 'ESP="Especifica el valor del campo Longitud"';
                }
                field("Field Class"; "Field Class")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Class field', Comment = 'ESP="Especifica el valor del campo Clase campo"';
                }
                field("Option String"; "Option String")
                {
                    ApplicationArea = All;
                    Editable = ("Data Type" = "Data Type"::Option);
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Option String field', Comment = 'ESP="Especifica el valor del campo Texto opciones"';
                }
                field(Obsolete; Obsolete)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Obsolete field', Comment = 'ESP="Especifica el valor del campo Obsoleto"';
                }
                field("Created by"; "Created by")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Created by field', Comment = 'ESP="Especifica el valor del campo Creado por"';
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Creation Date field', Comment = 'ESP="Especifica el valor del campo Fecha creación"';
                }
            }
            part(ExtTableExtDetail; "EXM TableExt Field List")
            {
                ApplicationArea = All;
                Editable = false;
                ShowFilter = false;
                SubPageLink = "Table Source Type" = filter("TableExtension"), "Source Table ID" = field("Source Table ID");
                SubPageView = sorting("Source Table ID", "Field ID");
                Visible = ViewTableExtDetail;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(AllFields)
            {
                ApplicationArea = All;
                Caption = 'View / Hide fields', Comment = 'ESP="Ver / ocultar campos"';
                Enabled = ("Table Source Type" = "Table Source Type"::"TableExtension");
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'View / Hide fields of selected table for other extensions', Comment = 'ESP="Ver / ocultar campos de tabla en otras extensiones"';

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
                ApplicationArea = All;
                Caption = 'View source table', Comment = 'ESP="Ver tabla origen"';
                Enabled = ("Table Source Type" = "Table Source Type"::"TableExtension");
                Image = Table;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'View source table fields', Comment = 'ESP="Muestra los campos de la tabla de origen"';

                trigger OnAction()
                var
                    EXMExtMgt: Codeunit "EXM Extension Management";
                begin
                    EXMExtMgt.GetTableFieldData("Source Table ID");
                end;
            }
            action(AddRelField)
            {
                ApplicationArea = All;
                Caption = 'Add to Related Tables', Comment = 'ESP="Añadir a tablas relacionadas"';
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add current field to defined related tables', Comment = 'ESP="Añade campo actual a tablas relacionadas definidas"';
                Visible = ("Table Source Type" = "Table Source Type"::"TableExtension");

                trigger OnAction()
                var
                    ExtMngt: Codeunit "EXM Extension Management";
                begin
                    TestField("Table Source Type", "Table Source Type"::"TableExtension");
                    ExtMngt.CreateRelatedFields(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetPKStyle();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        GetPKStyle();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetPKStyle();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        EXMTableFields: Record "EXM Table Fields";
        PKErr: Label 'Primary key must be set.', Comment = 'ESP="Se debe indicar clave primária"';
    begin
        if CloseAction = CloseAction::LookupOK then
            if "Source Table ID" = 0 then begin
                EXMTableFields.SetRange("Extension Code", "Extension Code");
                EXMTableFields.SetRange("Source Line No.", "Source Line No.");
                EXMTableFields.SetRange("Table Source Type", "Table Source Type"::Table);
                EXMTableFields.SetRange(IsPK, true);
                if EXMTableFields.IsEmpty then
                    Error(PKErr);
            end;
    end;

    var
        PKVisible: Boolean;
        ViewTableExtDetail: Boolean;
        StyleExp: Text;

    local procedure GetDesc(): Text
    var
        AllObject: Record AllObj;
        EXMExtLine: Record "EXM Extension Lines";
    begin
        EXMExtLine.Get("Extension Code", "Source Line No.");
        if Rec."Table Source Type" = Rec."Table Source Type"::"TableExtension" then begin
            AllObject.Get(AllObject."Object Type"::Table, "Source Table ID");
            exit(Format("Source Table ID") + ' ' + AllObject."Object Name" + ' - ' + Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
        end else
            exit(Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
    end;

    local procedure GetPKStyle()
    begin
        PKVisible := ("Source Table ID" = 0);
        StyleExp := 'standard';
        if IsPK then
            StyleExp := 'strong';
    end;
}