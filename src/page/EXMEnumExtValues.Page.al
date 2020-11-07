page 83211 "EXM EnumExt Values"
{
    Caption = 'EnumExt Values', Comment = 'ESP="Valores EnumExt"';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    ShowFilter = false;
    SourceTable = "EXM Enum Values";

    layout
    {
        area(Content)
        {
            repeater(Fields)
            {
                field("Extension Code"; Rec."Extension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Código Extensión"';
                }
                field("Ordinal ID"; Rec."Ordinal ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ordinal ID field', Comment = 'ESP="Especifica el valor del campo ID Ordinal"';
                }
                field("Enum Value"; Rec."Enum Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Enum Value field', Comment = 'ESP="Especifica el valor del campo valor Enum"';
                }
                field("Created by"; Rec."Created by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created by field', Comment = 'ESP="Especifica quién creo el registro."';
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Creation Date field', Comment = 'ESP="Especifica la fecha de creación del registro."';
                }
            }
        }
    }
}