page 83201 "EXM Extension Header"
{
    Caption = 'Extension Card', Comment = 'ESP="Ficha extensión"';
    DataCaptionFields = Code, Description;
    PageType = Document;
    SourceTable = "EXM Extension Header";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(Header)
            {
                Caption = 'Information', Comment = 'ESP="Información"';
                field("Code"; Rec."Code")
                { }
                field(Description; Rec."Description")
                { }
                field("App Version"; Rec."App Version")
                { }
                field(Dependencies; Rec.Dependencies)
                { }
                group(Target)
                {
                    Caption = 'Target', Comment = 'Destino';
                    field(Type; Rec."Type")
                    { }
                    field("Customer No."; Rec."Customer No.")
                    {
                        Editable = (Rec.Type = Rec.Type::External);
                    }
                    field("Customer Name"; Rec."Customer Name")
                    { }
                }

                group(ObjectRange)
                {
                    Caption = 'Object Range', Comment = 'ESP="Rango objetos"';
                    field("Object Starting ID"; Rec."Object Starting ID")
                    {
                        Caption = 'Starting No.', Comment = 'ESP="Nº inicial"';
                        trigger OnValidate()
                        begin
                            if xRec."Object Starting ID" <> Rec."Object Starting ID" then
                                CurrPage.Update(true);
                        end;
                    }
                    field("Object Ending ID"; Rec."Object Ending ID")
                    {
                        Caption = 'Ending No.', Comment = 'ESP="Nº final"';
                        trigger OnValidate()
                        begin
                            if xRec."Object Ending ID" <> Rec."Object Ending ID" then
                                CurrPage.Update(true);
                        end;
                    }
                }
            }
            part(ExtLines; "EXM Extension Lines")
            {
                SubPageLink = "Extension Code" = field("Code");
            }
            group(GIT)
            {
                field("GIT Repository URL"; Rec."GIT Repository URL")
                {
                    ExtendedDatatype = URL;
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
                Caption = 'Tree view', Comment = 'ESP="Vista arbol"';
                Image = Trendscape;
                ToolTip = 'Executes the Tree view action', Comment = 'ESP="Ver objectos en Vista arbol"';
                trigger OnAction()
                var
                    EXMExtTreeView: Page "EXM Extension TreeView";
                begin
                    EXMExtTreeView.SetFilters(Rec."Type", Rec."Code", Rec."Customer No.");
                    EXMExtTreeView.Run();
                end;
            }
            action(ViewDependencies)
            {
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitRecord();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        EmptyIDMsg: Label '%1 should have value.', comment = 'ESP="%1 deberia tener valor."';
    begin
        if Rec.Code <> '' then begin
            if Rec."Object Starting ID" = 0 then
                Message(StrSubstNo(EmptyIDMsg, Rec.FieldCaption("Object Starting ID")));

            if Rec."Object Ending ID" = 0 then
                Message(StrSubstNo(EmptyIDMsg, Rec.FieldCaption("Object Ending ID")));
        end;
    end;
}