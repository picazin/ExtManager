page 83201 "EXM Extension Header"
{
    Caption = 'Extension Card', Comment = 'ESP="Ficha extensión"';
    DataCaptionFields = Code, Description;
    PageType = Document;
    SourceTable = "EXM Extension Header";

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
                    ToolTip = 'Specifies the value of the Code field', Comment = 'ESP="Especifica el valor del campo Código"';
                }
                field(Description; "Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field', Comment = 'ESP="Especifica el valor del campo Descripción"';
                }
                field("App Version"; "App Version")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the App Version field', Comment = 'ESP="Especifica el valor del campo Versión App"';
                }
                field(Dependencies; Dependencies)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Dependencies field', Comment = 'ESP="Especifica el valor del campo Dependencias"';
                }
                group(Target)
                {
                    Caption = 'Target', Comment = 'Destino';
                    field(Type; "Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Type field', Comment = 'ESP="Especifica el valor del campo Tipo"';
                    }
                    field("Customer No."; "Customer No.")
                    {
                        ApplicationArea = All;
                        Editable = (Type = Type::External);
                        ToolTip = 'Specifies the value of the Customer No. field', Comment = 'ESP="Especifica el valor del campo Nº Cliente"';
                    }
                    field("Customer Name"; "Customer Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
                    }
                }

                group(ObjectRange)
                {
                    Caption = 'Object Range', Comment = 'ESP="Rango objetos"';
                    field("Object Starting ID"; "Object Starting ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Starting No.', Comment = 'ESP="Nº inicial"';
                        ToolTip = 'Specifies the value of the Starting No. field', Comment = 'ESP="Especifica el valor del campo Nº inicial"';
                        trigger OnValidate()
                        begin
                            if xRec."Object Starting ID" <> "Object Starting ID" then
                                CurrPage.Update(true);
                        end;
                    }
                    field("Object Ending ID"; "Object Ending ID")
                    {
                        ApplicationArea = All;
                        Caption = 'Ending No.', Comment = 'ESP="Nº final"';
                        ToolTip = 'Specifies the value of the Ending No. field', Comment = 'ESP="Especifica el valor del campo Nº final"';
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
                    ToolTip = 'Specifies the value of the GIT Repository URL field', Comment = 'ESP="Especifica el valor del campo URL repositorio GIT"';
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