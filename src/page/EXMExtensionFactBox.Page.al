page 83213 "EXM Extension FactBox"
{
    Caption = 'Extension objects detail', Comment = 'ESP="Detalle objetos extensión"';
    Editable = false;
    PageType = CardPart;
    SourceTable = "EXM Extension Header";

    layout
    {
        area(content)
        {
            cuegroup(General)
            {
                field("No. of Tables"; Rec."No. of Tables")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Tables in the extension', Comment = 'ESP="Muestra el Nº Tablas en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Table)
                    end;
                }
                field("No. of TableExtensions"; Rec."No. of TableExtensions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of TableExtensions in the extension', Comment = 'ESP="Muestra el Nº TableExtensions en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"TableExtension")
                    end;
                }
                field("No. of Page"; Rec."No. of Page")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Pages in the extension', Comment = 'ESP="Muestra el Nº Pages en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Page)
                    end;
                }
                field("No. of PageExtensions"; Rec."No. of PageExtensions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of PageExtensions in the extension', Comment = 'ESP="Muestra el Nº PageExtensions en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::"PageExtension")
                    end;
                }
                field("No. of Codeunits"; Rec."No. of Codeunits")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Codeunits in the extension', Comment = 'ESP="Muestra el Nº Codeunits en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Codeunit)
                    end;
                }
                field("No. of Reports"; Rec."No. of Reports")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Reports in the extension', Comment = 'ESP="Muestra el Nº Informes en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Report)
                    end;
                }
                field("No. of Querys"; Rec."No. of Querys")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Querys in the extension', Comment = 'ESP="Muestra el Nº Querys en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Query)
                    end;
                }
                field("No. of XMLports"; Rec."No. of XMLports")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of XMLports in the extension', Comment = 'ESP="Muestra el Nº XMLports en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::XMLport)
                    end;
                }
                field("No. of Enums"; Rec."No. of Enums")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Enums in the extension', Comment = 'ESP="Muestra el Nº Enums en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Enum)
                    end;
                }
                field("No. of EnumExtensions"; Rec."No. of EnumExtensions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of EnumExtensions in the extension', Comment = 'ESP="Muestra el Nº EnumExtensions en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::EnumExtension)
                    end;
                }
                field("No. of Profiles"; Rec."No. of Profiles")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of Profiles in the extension', Comment = 'ESP="Muestra el Nº Profiles en la extensión"';
                    trigger OnDrillDown()
                    begin
                        ViewObjectDetail(Objects::Profile)
                    end;
                }
                field("No. of ProfileExtensions"; Rec."No. of ProfileExtensions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the No. of ProfileExtensions in the extension', Comment = 'ESP="Muestra el Nº ProfileExtensions en la extensión"';
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
