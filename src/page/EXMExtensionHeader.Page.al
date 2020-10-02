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
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec."Description")
                {
                    ApplicationArea = All;
                }
                field("App Version"; Rec."App Version")
                {
                    ApplicationArea = All;
                }
                field(Dependencies; Rec.Dependencies)
                {
                    ApplicationArea = All;
                }
                group(Target)
                {
                    Caption = 'Target', Comment = 'Destino';
                    field(Type; Rec."Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Customer No."; Rec."Customer No.")
                    {
                        ApplicationArea = All;
                        Editable = (Rec.Type = Rec.Type::External);
                    }
                    field("Customer Name"; Rec."Customer Name")
                    {
                        ApplicationArea = All;
                    }
                }

                group(ObjectRange)
                {
                    Caption = 'Object Range', Comment = 'ESP="Rango objetos"';
                    field("Object Starting ID"; Rec."Object Starting ID")
                    {
                        Caption = 'Starting No.', Comment = 'ESP="Nº inicial"';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if xRec."Object Starting ID" <> Rec."Object Starting ID" then
                                CurrPage.Update(true);
                        end;
                    }
                    field("Object Ending ID"; Rec."Object Ending ID")
                    {
                        Caption = 'Ending No.', Comment = 'ESP="Nº final"';
                        ApplicationArea = All;
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
                ApplicationArea = All;
                SubPageLink = "Extension Code" = field(Code);
            }
            group(GIT)
            {
                field("GIT Repository URL"; Rec."GIT Repository URL")
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
            part(EXMExtDep; "EXM Extension Dep. Factbox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Extensión Code" = field(Code);
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.InitRecord();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Rec.Code <> '' then begin
            Rec.TestField("Object Starting ID");
            Rec.TestField("Object Ending ID");
        end;
    end;
}