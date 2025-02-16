page 83206 "EXM Table Field Detail"
{
    Caption = 'Table Fields', Comment = 'ESP="Campos Tabla"';
    DataCaptionExpression = GetTableDesc();
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "EXM Table Fields";
    ApplicationArea = All;
    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Field ID"; Rec."Field ID")
                {
                    StyleExpr = StyleExp;
                }
                field("Field Name"; Rec."Field Name")
                {
                    StyleExpr = StyleExp;
                }

                field("Field Caption"; Rec."Field Caption")
                {
                    StyleExpr = StyleExp;
                }
                field("Data Type"; Rec."Data Type")
                {
                    StyleExpr = StyleExp;
                }
                field(Lenght; Rec.Lenght)
                {
                    StyleExpr = StyleExp;
                }
                field("Field Class"; Rec."Field Class")
                {
                    StyleExpr = StyleExp;
                }
                field("Option String"; Rec."Option String")
                {
                    StyleExpr = StyleExp;
                }
                field(Obsolete; Rec.Obsolete)
                {
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

    var
        StyleExp: Text;

    local procedure GetTableDesc(): Text
    var
        AllObject: Record AllObj;
    begin
        AllObject.Get(AllObject."Object Type"::Table, Rec."Table ID");
        exit(Format(Rec."Table ID") + ' ' + AllObject."Object Name")
    end;
}