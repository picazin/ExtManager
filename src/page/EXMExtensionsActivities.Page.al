page 83209 "EXM Extensions Activities"
{
    Caption = 'Activities', Comment = 'ESP="Actividades"';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "EXM Extension Manager Cue";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup(ExtInfo)
            {
                Caption = 'Extensions', Comment = 'ESP="Extensiones"';
                CuegroupLayout = Wide;
                field(Extensions; Rec.Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                    ToolTip = 'View All Extensions list', Comment = 'ESP="Muestra todas las extensiones"';
                }
            }
            cuegroup(Detail)
            {
                Caption = 'Extensions per type', Comment = 'ESP="Extensiones por tipo"';
                field("Internal Extensions"; Rec."Internal Extensions")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                    ToolTip = 'View Internal Extensions list', Comment = 'ESP="Muestra todas las extensiones internas"';
                }

                field("External Extensions"; Rec."External Extensions")
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