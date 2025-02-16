page 83200 "EXM Extension List"
{
    ApplicationArea = All;
    Caption = 'Extension Manager', Comment = 'ESP="Gestor Extensiones"';
    CardPageId = "EXM Extension Header";
    DataCaptionFields = Description;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "EXM Extension Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                { }
                field(Description; Rec."Description")
                { }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type', Comment = 'ESP="Especifica el valor del campo Tipo"';
                }
                field("Customer No."; Rec."Customer No.")
                { }
                field("Customer Name"; Rec."Customer Name")
                { }
                field("Object Starting ID"; Rec."Object Starting ID")
                {
                    ToolTip = 'Specifies the value of the Object Starting ID field', Comment = 'ESP="Especifica el valor del campo Inicio ID objetos"';
                }
                field("Object Ending ID"; Rec."Object Ending ID")
                {
                    ToolTip = 'Specifies the value of the Object Ending ID field', Comment = 'ESP="Especifica el valor del campo Final ID objetos"';
                }
            }
        }
        area(factboxes)
        {
            part(EXMExtDetail; "EXM Extension FactBox")
            {
                SubPageLink = Code = field("Code");
            }
            part(EXMExtDep; "EXM Extension Dep. Factbox")
            {
                SubPageLink = "Extensión Code" = field("Code");
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(TreeView)
            {
                ApplicationArea = All;

                Caption = 'Tree view', Comment = 'ESP="Vista arbol"';
                Image = Trendscape;
                ToolTip = 'Executes the Tree view action', Comment = 'ESP="Ver objectos en Vista arbol"';
                trigger OnAction()
                var
                    EXMExtTreeView: Page "EXM Extension TreeView";
                    SelOption: Integer;
                    OptionsQst: Label 'All,Selected', Comment = 'ESP="Todos,Seleccionado"';
                begin
                    SelOption := StrMenu(OptionsQst);

                    case SelOption of
                        1:
                            EXMExtTreeView.SetFilters(Rec."Type", '', Rec."Customer No.");
                        2:
                            EXMExtTreeView.SetFilters(Rec."Type", Rec."Code", Rec."Customer No.");
                        else
                            exit;
                    end;

                    EXMExtTreeView.Run();
                end;
            }
            action(ViewDependencies)
            {
                ApplicationArea = All;

                Caption = 'Dependencies', Comment = 'ESP="Dependencias"';
                Image = AssemblyBOM;
                RunObject = Page "EXM Extension Dependencies";
                RunPageLink = "Extensión Code" = field("Code");
                ToolTip = 'View extension dependencies', Comment = 'ESP="Ver dependencias extensión"';
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                actionref(TreeView_Promoted; TreeView)
                { }
                actionref(ViewDependencies_Promoted; ViewDependencies)
                { }
            }
        }
    }
}