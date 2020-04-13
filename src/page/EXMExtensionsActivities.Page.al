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
                field(Extensions; Extensions)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                }
            }
            cuegroup(Detail)
            {
                Caption = 'Extensions per type', Comment = 'ESP="Extensiones por tipo"';
                field("Internal Extensions"; "Internal Extensions")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                }

                field("External Extensions"; "External Extensions")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "EXM Extension List";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        If not Get() then begin
            Init();
            Insert();
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    local procedure CalculateCueFieldValues()
    begin
        //if FIELDACTIVE("Normal field") then
        //    "Normal field" := 2 + 1 //add some calculation here for normal fields;
    end;
}