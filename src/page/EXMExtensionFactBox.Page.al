page 83213 "EXM Extension FactBox"
{
    PageType = CardPart;
    SourceTable = "EXM Extension Header";
    Caption = 'Extension objects detail', Comment = 'ESP="Detalle objetos extensión"';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No. of Tables"; "No. of Tables")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Table)
                    end;
                }
                field("No. of TableExtensions"; "No. of TableExtensions")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"TableExtension")
                    end;
                }
                field("No. of Page"; "No. of Page")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Page)
                    end;
                }
                field("No. of PageExtensions"; "No. of PageExtensions")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"PageExtension")
                    end;
                }
                field("No. of Codeunits"; "No. of Codeunits")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Codeunit)
                    end;
                }
                field("No. of Reports"; "No. of Reports")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Report)
                    end;
                }
                field("No. of Querys"; "No. of Querys")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Query)
                    end;
                }
                field("No. of XMLports"; "No. of XMLports")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::XMLport)
                    end;
                }
                field("No. of Enums"; "No. of Enums")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Enum)
                    end;
                }
                field("No. of EnumExtensions"; "No. of EnumExtensions")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::EnumExtension)
                    end;
                }
                field("No. of Profiles"; "No. of Profiles")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Profile)
                    end;
                }
                field("No. of ProfileExtensions"; "No. of ProfileExtensions")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"ProfileExtension")
                    end;
                }
            }
        }
    }
    local procedure ViewObjectDetail(ObjType: Integer);
    var
        EXMExtLine: Record "EXM Extension Lines";
        EXMObjectDetail: Page "EXM Object Detail";
    begin
        EXMExtLine.FilterGroup(2);
        EXMExtLine.SetRange("Extension Code", Code);
        EXMExtLine.SetRange("Object Type", ObjType);
        EXMExtLine.FilterGroup(0);

        EXMObjectDetail.LookupMode(true);
        EXMObjectDetail.Editable(false);
        EXMObjectDetail.SetTableView(EXMExtLine);
        EXMObjectDetail.RunModal();
    end;

    var
        Objects: Option "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
}
