page 83214 "EXM Object Detail"
{
    PageType = List;
    SourceTable = "EXM Extension Lines";
    Caption = 'Objects Detail', Comment = 'ESP="Detalle Objetos"';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                }
                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; "Source Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
