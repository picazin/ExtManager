page 83209 "EXM Extensions Activities"
{
    Caption = 'Activities', Comment = 'ESP="Actividades"';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "EXM Extension Manager Cue";
    ApplicationArea = All;

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
                    DrillDownPageId = "EXM Extension List";
                }
            }
            cuegroup(Detail)
            {
                Caption = 'Extensions per type', Comment = 'ESP="Extensiones por tipo"';
                field("Internal Extensions"; Rec."Internal Extensions")
                {
                    DrillDownPageId = "EXM Extension List";
                }
                field("External Extensions"; Rec."External Extensions")
                {
                    DrillDownPageId = "EXM Extension List";
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