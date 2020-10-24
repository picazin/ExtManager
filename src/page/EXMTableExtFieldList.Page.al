page 83204 "EXM TableExt Field List"
{
    Caption = 'TableExtensions Fields', Comment = 'ESP="Campos TableExtensions"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
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
                    ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Cód. extensión"';
                }
                field("Source Table ID"; "Source Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Table ID field', Comment = 'ESP="Especifica el valor del campo Id. tabla origen"';
                    Visible = false;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Table ID field', Comment = 'ESP="Especifica el valor del campo Id. tabla"';
                    Visible = false;
                }
                field("Field ID"; "Field ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field ID field', Comment = 'ESP="Especifica el valor del campo Id. campo"';
                }
                field("Field Name"; "Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field Name field', Comment = 'ESP="Especifica el valor del campo Nombre de campo"';
                }
                field("Data Type"; "Data Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Data Type field', Comment = 'ESP="Especifica el valor del campo Tipo datos"';
                }
                field(Lenght; Lenght)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lenght field', Comment = 'ESP="Especifica el valor del campo Longitud"';
                }
                field("Field Class"; "Field Class")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Field Class field', Comment = 'ESP="Especifica el valor del campo Clase campo"';
                }
                field("Option String"; "Option String")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Option String field', Comment = 'ESP="Especifica el valor del campo Texto opciones"';
                }
                field(Obsolete; Obsolete)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Obsolete field', Comment = 'ESP="Especifica el valor del campo Obsoleto"';
                }
                field("Created by"; "Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created by field', Comment = 'ESP="Especifica el valor del campo Creado por"';
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field', Comment = 'ESP="Especifica el valor del campo Fecha creación"';
                }
            }
        }
    }
}