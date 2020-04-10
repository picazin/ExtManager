page 83206 "EXM Table Field Detail"
{
    Caption = 'Table Fields', Comment = 'ESP="Campos Tabla"';
    PageType = List;
    SourceTable = "EXM Extension Table Fields";
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
                field("Field Caption"; "Field Caption")
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
                    StyleExpr = StyleExp;
                }
                field(Obsolete; Obsolete)
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
        if IsPK then
            StyleExp := 'strong';
    end;

    local procedure GetTableDesc(): Text
    var
        AllObject: Record AllObj;
    begin
        AllObject.Get(AllObject."Object Type"::Table, "Table ID");
        exit(Format("Table ID") + ' ' + AllObject."Object Name")
    end;

    var
        StyleExp: Text;
}