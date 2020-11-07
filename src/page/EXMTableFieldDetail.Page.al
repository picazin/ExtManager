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
                    ToolTip = 'Specifies the value of the Field ID field', Comment = 'ESP="Especifica el valor del campo Id. campo"';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Name field', Comment = 'ESP="Especifica el valor del campo Nombre de campo"';
                }

                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Caption field', Comment = 'ESP="Especifica el valor del campo Título campo"';
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Data Type field', Comment = 'ESP="Especifica el valor del campo Tipo datos"';
                }
                field(Lenght; Rec.Lenght)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Lenght field', Comment = 'ESP="Especifica el valor del campo Longitud"';
                }
                field("Field Class"; Rec."Field Class")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Class field', Comment = 'ESP="Especifica el valor del campo Clase campo"';
                }
                field("Option String"; Rec."Option String")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Option String field', Comment = 'ESP="Especifica el valor del campo Texto opciones"';
                }
                field(Obsolete; Rec.Obsolete)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Obsolete field', Comment = 'ESP="Especifica el valor del campo Obsoleto"';
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