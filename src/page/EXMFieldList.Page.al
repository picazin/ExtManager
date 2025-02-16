page 83203 "EXM Field List"
{
    DataCaptionExpression = GetDesc();
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "EXM Table Fields";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; Rec."Extension Code")
                {
                    Editable = false;
                    StyleExpr = StyleExp;
                    Visible = false;
                }
                field("Source Line No."; Rec."Source Line No.")
                {
                    Editable = false;
                    StyleExpr = StyleExp;
                    Visible = false;
                }
                field("Table Source Type"; Rec."Table Source Type")
                {
                    Editable = false;
                    StyleExpr = StyleExp;
                    Visible = false;
                }
                field("Source Table ID"; Rec."Source Table ID")
                {
                    Editable = false;
                    StyleExpr = StyleExp;
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    Editable = false;
                    StyleExpr = StyleExp;
                    Visible = false;
                }
                field(IsPK; Rec.IsPK)
                {
                    Enabled = (Rec."Source Table ID" = 0);
                    StyleExpr = StyleExp;
                    Visible = PKVisible;
                    trigger OnValidate()
                    begin
                        if xRec.IsPK <> Rec.IsPK then
                            CurrPage.Update(true);
                    end;
                }
                field("Field ID"; Rec."Field ID")
                {
                    StyleExpr = StyleExp;
                }
                field("Field Name"; Rec."Field Name")
                {
                    StyleExpr = StyleExp;
                }
                field("Data Type"; Rec."Data Type")
                {
                    StyleExpr = StyleExp;
                }
                field(Lenght; Rec.Lenght)
                {
                    Editable = ((Rec."Data Type" = Rec."Data Type"::Text) or (Rec."Data Type" = Rec."Data Type"::Code));
                    StyleExpr = StyleExp;
                }
                field("Field Class"; Rec."Field Class")
                {
                    StyleExpr = StyleExp;
                }
                field("Option String"; Rec."Option String")
                {
                    Editable = (Rec."Data Type" = Rec."Data Type"::Option) or (Rec."Data Type" = Rec."Data Type"::Enum);
                    StyleExpr = StyleExp;
                }
                field(Obsolete; Rec.Obsolete)
                {
                    StyleExpr = StyleExp;
                }
                field("Created by"; Rec."Created by")
                {
                    StyleExpr = StyleExp;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    StyleExpr = StyleExp;
                }
            }
            part(ExtTableExtDetail; "EXM TableExt Field List")
            {
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
                Caption = 'View / Hide fields', Comment = 'ESP="Ver / ocultar campos"';
                Enabled = (Rec."Table Source Type" = Rec."Table Source Type"::"TableExtension");
                Image = ResetStatus;
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
                Caption = 'View source table', Comment = 'ESP="Ver tabla origen"';
                Enabled = (Rec."Table Source Type" = Rec."Table Source Type"::"TableExtension");
                Image = Table;
                ToolTip = 'View source table fields', Comment = 'ESP="Muestra los campos de la tabla de origen"';

                trigger OnAction()
                var
                    EXMExtMgt: Codeunit "EXM Extension Management";
                begin
                    EXMExtMgt.GetTableFieldData(Rec."Source Table ID");
                end;
            }
            action(AddRelField)
            {
                Caption = 'Add to Related Tables', Comment = 'ESP="Añadir a tablas relacionadas"';
                Image = Add;
                ToolTip = 'Add current field to defined related tables', Comment = 'ESP="Añade campo actual a tablas relacionadas definidas"';
                Visible = (Rec."Table Source Type" = Rec."Table Source Type"::"TableExtension");

                trigger OnAction()
                var
                    ExtMngt: Codeunit "EXM Extension Management";
                begin
                    Rec.TestField("Table Source Type", Rec."Table Source Type"::"TableExtension");
                    ExtMngt.CreateRelatedFields(Rec);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(AllFields_Promoted; AllFields)
                { }
                actionref(ViewSourceTable_Promoted; ViewSourceTable)
                { }
                actionref(AddRelField_Promoted; AddRelField)
                { }
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
            if Rec."Source Table ID" = 0 then begin
                EXMTableFields.SetRange("Extension Code", Rec."Extension Code");
                EXMTableFields.SetRange("Source Line No.", Rec."Source Line No.");
                EXMTableFields.SetRange("Table Source Type", Rec."Table Source Type"::Table);
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
        EXMExtLine.Get(Rec."Extension Code", Rec."Source Line No.");
        if Rec."Table Source Type" = Rec."Table Source Type"::"TableExtension" then begin
            AllObject.Get(AllObject."Object Type"::Table, Rec."Source Table ID");
            exit(Format(Rec."Source Table ID") + ' ' + AllObject."Object Name" + ' - ' + Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
        end else
            exit(Format(EXMExtLine."Object ID") + ' ' + EXMExtLine.Name);
    end;

    local procedure GetPKStyle()
    begin
        PKVisible := (Rec."Source Table ID" = 0);
        StyleExp := 'standard';
        if Rec.IsPK then
            StyleExp := 'strong';
    end;
}