page 83213 "EXM Extension FactBox"
{
    Caption = 'Extension objects detail', Comment = 'ESP="Detalle objetos extensión"';
    Editable = false;
    PageType = CardPart;
    SourceTable = "EXM Extension Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                field("No. of Tables"; Rec."No. of Tables")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Table)
                    end;
                }
                field("No. of TableExtensions"; Rec."No. of TableExtensions")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"TableExtension")
                    end;
                }
                field("No. of Page"; Rec."No. of Page")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Page)
                    end;
                }
                field("No. of PageExtensions"; Rec."No. of PageExtensions")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"PageExtension")
                    end;
                }
                field("No. of Codeunits"; Rec."No. of Codeunits")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Codeunit)
                    end;
                }
                field("No. of Reports"; Rec."No. of Reports")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Report)
                    end;
                }
                field("No. of Querys"; Rec."No. of Querys")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Query)
                    end;
                }
                field("No. of XMLports"; Rec."No. of XMLports")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::XMLport)
                    end;
                }
                field("No. of Enums"; Rec."No. of Enums")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Enum)
                    end;
                }
                field("No. of EnumExtensions"; Rec."No. of EnumExtensions")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::EnumExtension)
                    end;
                }
                field("No. of Profiles"; Rec."No. of Profiles")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Profile)
                    end;
                }
                field("No. of ProfileExtensions"; Rec."No. of ProfileExtensions")
                {
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"ProfileExtension")
                    end;
                }
            }
        }
    }

    var
        Objects: Option "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";

    local procedure ViewObjectDetail(ObjType: Integer);
    var
        EXMExtLine: Record "EXM Extension Lines";
        EXMObjectDetail: Page "EXM Object Detail";
    begin
        EXMExtLine.FilterGroup(2);
        EXMExtLine.SetRange("Extension Code", Rec."Code");
        EXMExtLine.SetRange("Object Type", ObjType);
        EXMExtLine.FilterGroup(0);

        EXMObjectDetail.LookupMode(true);
        EXMObjectDetail.Editable(false);
        EXMObjectDetail.SetTableView(EXMExtLine);
        EXMObjectDetail.RunModal();
    end;
}
