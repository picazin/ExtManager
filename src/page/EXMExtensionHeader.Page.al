page 83201 "EXM Extension Header"
{
    Caption = 'Extension Card', Comment = 'ESP="Ficha extensión"';
    PageType = Document;
    SourceTable = "EXM Extension Header";
    DataCaptionFields = Code, Description;


    layout
    {
        area(Content)
        {
            group(Header)
            {
                Caption = 'Information', Comment = 'ESP="Información"';
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                }
                field(Description; "Description")
                {
                    ApplicationArea = All;
                }
                field("App Version"; "App Version")
                {
                    ApplicationArea = All;
                }
                field(Dependencies; Dependencies)
                {
                    ApplicationArea = All;
                }
                group(Target)
                {
                    Caption = 'Target', Comment = 'Destino';
                    field(Type; "Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Customer No."; "Customer No.")
                    {
                        ApplicationArea = All;
                        Editable = (Type = Type::External);
                    }
                    field("Customer Name"; "Customer Name")
                    {
                        ApplicationArea = All;
                    }
                }

                group(ObjectRange)
                {
                    Caption = 'Object Range', Comment = 'ESP="Rango objetos"';
                    field("Object Starting ID"; "Object Starting ID")
                    {
                        Caption = 'Starting No.', Comment = 'ESP="Nº inicial"';
                        ApplicationArea = All;
                    }
                    field("Object Ending ID"; "Object Ending ID")
                    {
                        Caption = 'Ending No.', Comment = 'ESP="Nº final"';
                        ApplicationArea = All;
                    }
                }
            }
            part(ExtLines; "EXM Extension Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Extension Code" = field(Code);
            }
            group(GIT)
            {
                field("GIT Repository URL"; "GIT Repository URL")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
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
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Code <> '' then begin
            TestField("Object Starting ID");
            TestField("Object Ending ID");
        end;
    end;
}