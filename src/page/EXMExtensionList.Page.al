page 83200 "EXM Extension List"
{
    Caption = 'Extension Manager', Comment = 'ESP="Gestor Extensiones"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EXM Extension Header";
    Editable = false;
    CardPageId = "EXM Extension Header";
    RefreshOnActivate = true;
    DataCaptionFields = Description;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec."Type")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Object Starting ID"; Rec."Object Starting ID")
                {
                    ApplicationArea = All;
                }
                field("Object Ending ID"; Rec."Object Ending ID")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(EXMExtDetail; "EXM Extension FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = Code = field(Code);
            }
            part(EXMExtDep; "EXM Extension Dep. Factbox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Extensión Code" = field(Code);
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(TreeView)
            {

                Caption = 'Tree view', Comment = 'ESP="Vista arbol"';
                ApplicationArea = All;
                Image = Trendscape;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    EXMExtTreeView: Page "EXM Extension TreeView";
                    OptionsQst: Label 'All,Selected', Comment = 'ESP="Todos,Seleccionado"';
                    SelOption: Integer;
                begin
                    SelOption := StrMenu(OptionsQst);

                    case SelOption of
                        1:
                            EXMExtTreeView.SetFilters(Rec.Type, '', Rec."Customer No.");
                        2:
                            EXMExtTreeView.SetFilters(Rec.Type, Rec.Code, Rec."Customer No.");
                        else
                            exit;
                    end;

                    EXMExtTreeView.Run();
                end;
            }
        }
    }
}