page 83203 "EXM Field List"
{
    PageType = List;
    SourceTable = "EXM Table Fields";
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
                    Visible = false;
                    Editable = false;
                    StyleExpr = StyleExp;
                }
                field("Source Line No."; "Source Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    StyleExpr = StyleExp;
                }
                field("Table Source Type"; "Table Source Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    StyleExpr = StyleExp;
                }
                field("Source Table ID"; "Source Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    StyleExpr = StyleExp;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    StyleExpr = StyleExp;
                }
                field(IsPK; IsPK)
                {
                    ApplicationArea = All;
                    Visible = PKVisible;
                    Enabled = ("Source Table ID" = 0);
                    StyleExpr = StyleExp;
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
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Data Type"; "Data Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field(Lenght; Lenght)
                {
                    ApplicationArea = All;
                    Editable = (("Data Type" = "Data Type"::Text) or ("Data Type" = "Data Type"::Code));
                    StyleExpr = StyleExp;
                }
                field("Field Class"; "Field Class")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Option String"; "Option String")
                {
                    ApplicationArea = All;
                    Editable = ("Data Type" = "Data Type"::Option);
                    StyleExpr = StyleExp;
                }
                field(Obsolete; Obsolete)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Created by"; "Created by")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
            }
            part(ExtTableExtDetail; "EXM TableExt Field List")
            {
                ApplicationArea = All;
                SubPageLink = "Table Source Type" = filter("TableExtension"), "Source Table ID" = field("Source Table ID");
                SubPageView = sorting("Source Table ID", "Field ID");
                Visible = ViewTableExtDetail;
                Editable = false;
                ShowFilter = false;
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
            action(AddRelField)
            {
                Caption = 'Add to Related Tables', Comment = 'ESP="Añadir a tablas relacionadas"';
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
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
        ViewTableExtDetail: Boolean;
        PKVisible: Boolean;
        StyleExp: Text;

}