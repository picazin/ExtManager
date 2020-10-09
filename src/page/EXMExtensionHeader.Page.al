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
                        trigger OnValidate()
                        begin
                            if xRec."Object Starting ID" <> "Object Starting ID" then
                                CurrPage.Update(true);
                        end;
                    }
                    field("Object Ending ID"; "Object Ending ID")
                    {
                        Caption = 'Ending No.', Comment = 'ESP="Nº final"';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if xRec."Object Ending ID" <> "Object Ending ID" then
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
            part(EXMExtDep; "EXM Extension Dep. Factbox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Extensión Code" = field(Code);
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitRecord();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        EmptyIDMsg: Label '%1 should have value.', comment = 'ESP="%1 deberia tener valor."';
    begin
        if Code <> '' then begin
            if Rec."Object Starting ID" = 0 then
                Message(StrSubstNo(EmptyIDMsg, Rec.FieldCaption("Object Starting ID")));

            if Rec."Object Ending ID" = 0 then
                Message(StrSubstNo(EmptyIDMsg, Rec.FieldCaption("Object Ending ID")));
        end;
    end;
}