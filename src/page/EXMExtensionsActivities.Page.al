page 83209 "EXM Extensions Activities"
{
    Caption = 'Activities', Comment = 'ESP="Actividades"';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "EXM Extension Manager Cue";

    layout
    {
        area(Content)
        {
            cuegroup(ExtInfo)
            {
                Caption = 'Extensions', Comment = 'ESP="Extensiones"';
                CuegroupLayout = Wide;
                field(Extensions; Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                    ToolTip = 'View All Extensions list', Comment = 'ESP="Muestra todas las extensiones"';
                }
            }
            cuegroup(Detail)
            {
                Caption = 'Extensions per type', Comment = 'ESP="Extensiones por tipo"';
                field("Internal Extensions"; "Internal Extensions")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                    ToolTip = 'View Internal Extensions list', Comment = 'ESP="Muestra todas las extensiones internas"';
                }

                field("External Extensions"; "External Extensions")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                    ToolTip = 'View External Extensions list', Comment = 'ESP="Muestra todas las extensiones externas"';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        If not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

    end;
}