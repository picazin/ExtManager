page 83206 "EXM Table Field Detail"
{
    Caption = 'Table Fields', Comment = 'ESP="Campos Tabla"';
    PageType = List;
    SourceTable = "EXM Table Fields";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    ShowFilter = false;
    Editable = false;
    DataCaptionExpression = GetTableDesc();

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }

                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field(Lenght; Rec.Lenght)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Field Class"; Rec."Field Class")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Option String"; Rec."Option String")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field(Obsolete; Rec.Obsolete)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleExp := 'standard';
        if Rec.IsPK then
            StyleExp := 'strong';
    end;

    local procedure GetTableDesc(): Text
    var
        AllObject: Record AllObj;
    begin
        AllObject.Get(AllObject."Object Type"::Table, Rec."Table ID");
        exit(Format(Rec."Table ID") + ' ' + AllObject."Object Name")
    end;

    var
        StyleExp: Text;
}