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
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field', Comment = 'ESP="Especifica el valor del campo Código"';
                }
                field(Description; "Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field', Comment = 'ESP="Especifica el valor del campo Descripción"';
                }
                field(Type; "Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type', Comment = 'ESP="Especifica el valor del campo Tipo"';
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field', Comment = 'ESP="Especifica el valor del campo Nº Cliente"';
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
                }
                field("Object Starting ID"; "Object Starting ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Starting ID field', Comment = 'ESP="Especifica el valor del campo Inicio ID objetos"';
                }
                field("Object Ending ID"; "Object Ending ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Ending ID field', Comment = 'ESP="Especifica el valor del campo Final ID objetos"';
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
                ApplicationArea = All;

                Caption = 'Tree view', Comment = 'ESP="Vista arbol"';
                Image = Trendscape;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
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
                            EXMExtTreeView.SetFilters(Type, '', "Customer No.");
                        2:
                            EXMExtTreeView.SetFilters(Type, Code, "Customer No.");
                        else
                            exit;
                    end;

                    EXMExtTreeView.Run();
                end;
            }
        }
    }
}