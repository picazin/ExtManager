table 83201 "EXM Extension Header"
{
    DataClassification = OrganizationIdentifiableInformation;
    Caption = 'Extension', Comment = 'ESP="Extensión"';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'ESP="Código"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'ESP="Descripción"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; Type; Option)
        {
            Caption = 'Type', Comment = 'ESP="Tipo"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Internal,External;
            OptionCaption = 'Internal,External', Comment = 'ESP="Interna,Externa"';
            trigger OnValidate()
            begin
                if (xRec.Type <> Rec.Type) and (Rec.Type = Rec.Type::Internal) then begin
                    "Customer No." := '';
                    "Customer Name" := '';
                    SetRelLines();
                end;
            end;
        }
        field(4; "Object Starting ID"; Integer)
        {
            Caption = 'Object Starting ID', Comment = 'ESP="Inicio ID objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                if (("Object Starting ID" > "Object Ending ID") and ("Object Ending ID" <> 0)) then
                    "Object Ending ID" := "Object Starting ID";

                EXMExtMgt.AllowedObjectsID("Object Starting ID");
                CheckObjectRange();
            end;
        }
        field(5; "Object Ending ID"; Integer)
        {
            Caption = 'Object Ending ID', Comment = 'ESP="Final ID objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
                ObjectRangeErr: Label '%1 must be greater then %2.', comment = 'ESP="%1 debe ser superior a %2."';
            begin
                if ("Object Ending ID" < "Object Starting ID") then
                    Error(ObjectRangeErr, FieldCaption("Object Ending ID"), FieldCaption("Object Starting ID"));

                EXMExtMgt.AllowedObjectsID("Object Ending ID");
                CheckObjectRange();
            end;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
            trigger OnValidate()
            var
                Cust: Record Customer;

            begin
                if xRec."Customer No." <> "Customer No." then begin
                    if "Customer No." = '' then
                        "Customer Name" := ''
                    else
                        if Cust.Get("Customer No.") then
                            "Customer Name" := Cust."Search Name";

                    SetRelLines();
                end;
            end;
        }
        field(7; "Customer Name"; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(8; "App Version"; Code[20])
        {
            Caption = 'App Version', Comment = 'ESP="Versión App"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(9; "App File"; Blob)
        {
            Caption = 'App File', Comment = 'ESP="Fichero App"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(10; Dependencies; Integer)
        {
            Caption = 'Dependencies', Comment = 'ESP="Dependencias"';
            FieldClass = FlowField;
            CalcFormula = Count ("EXM Extension Dependencies" where("Extensión Code" = field(Code)));
            Editable = false;
        }

        field(20; Price; Decimal)
        {
            Caption = 'Price', Comment = 'ESP="Precio"';
            DataClassification = OrganizationIdentifiableInformation;
            DecimalPlaces = 0 : 2;
            MinValue = 0;
        }
        field(21; Installations; Integer)
        {
            Caption = 'Installations', Comment = 'ESP="Instalaciones"';
            DataClassification = OrganizationIdentifiableInformation;
            //FieldClass = FlowField;
            //CalcFormula = 
            Editable = false;
        }
        field(22; "Sell-Type"; Option)
        {

            Caption = 'Installations', Comment = 'ESP="Instalaciones"';
            OptionMembers = " ",Account,Item;
            OptionCaption = ' ,Account,Item', Comment = 'ESP=" ,Cuenta,Producto"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            begin
                if "Sell-Type" = "Sell-Type"::" " then
                    "No." := '';
            end;
        }
        field(23; "No."; Code[20])
        {
            Caption = 'No.', Comment = 'ESP="Nº"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = if ("Sell-Type" = filter(Account)) "G/L Account" else
            if ("Sell-Type" = filter(Item)) Item;
        }
        field(25; "No. of Tables"; Integer)
        {
            Caption = 'No. of Tables', Comment = 'ESP="Nº Tablas"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Table)));
            Editable = false;
        }
        field(26; "No. of Reports"; Integer)
        {
            Caption = 'No. of Reports', Comment = 'ESP="Nº Informes"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Report)));
            Editable = false;
        }
        field(27; "No. of Codeunits"; Integer)
        {
            Caption = 'No. of Codeunits', Comment = 'ESP="Nº Codeunits"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Codeunit)));
            Editable = false;
        }
        field(28; "No. of XMLports"; Integer)
        {
            Caption = 'No. of XMLports', Comment = 'ESP="Nº XMLports"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(XMLport)));
            Editable = false;
        }
        field(29; "No. of Page"; Integer)
        {
            Caption = 'No. of Pages', Comment = 'ESP="Nº Pages"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Page)));
            Editable = false;
        }
        field(30; "No. of Querys"; Integer)
        {
            Caption = 'No. of Querys', Comment = 'ESP="Nº Querys"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Query)));
            Editable = false;
        }
        field(31; "No. of PageExtensions"; Integer)
        {
            Caption = 'No. of PageExtensions', Comment = 'ESP="Nº PageExtensions"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter("PageExtension")));
            Editable = false;
        }
        field(32; "No. of TableExtensions"; Integer)
        {
            Caption = 'No. of TableExtensions', Comment = 'ESP="Nº TableExtensions"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter("TableExtension")));
            Editable = false;
        }
        field(33; "No. of Enums"; Integer)
        {
            Caption = 'No. of Enums', Comment = 'ESP="Nº Enums"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Enum)));
            Editable = false;
        }
        field(34; "No. of EnumExtensions"; Integer)
        {
            Caption = 'No. of EnumExtensions', Comment = 'ESP="Nº EnumExtensions"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(EnumExtension)));
            Editable = false;
        }
        field(35; "No. of Profiles"; Integer)
        {
            Caption = 'No. of Profiles', Comment = 'ESP="Nº Profiles"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Profile)));
            Editable = false;
        }
        field(36; "No. of ProfileExtensions"; Integer)
        {
            Caption = 'No. of ProfileExtensions', Comment = 'ESP="Nº ProfileExtensions"';
            FieldClass = FlowField;
            CalcFormula = count ("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter("ProfileExtension")));
            Editable = false;
        }
        field(50; "GIT Repository URL"; Text[2048])
        {
            Caption = 'GIT Repository URL', Comment = 'ESP="URL repositorio GIT"';
            DataClassification = OrganizationIdentifiableInformation;
            ExtendedDatatype = URL;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(P2; Type, "Customer No.")
        { }
    }
    local procedure CheckObjectRange();
    var
        ExtLine: Record "EXM Extension Lines";
        ExtField: Record "EXM Table Fields";
        ExtEnum: Record "EXM Enum Values";
        ErrorMsg: Text;
        ShowError: Boolean;
        ObjectIDRangeErr: Label 'Already exist objects outside range %1 - %2.', comment = 'ESP="Existen objetos fuera del rango %1 - %2."';
        FieldIDRangeErr: Label 'Already exist field IDs on TableExtensions outside range %1 - %2.', comment = 'ESP="Existen IDs de campo en TableExtension fuera del rango %1 - %2."';
        OrdinalIDRangeErr: Label 'Already exist IDs on EnumExtensions outside range %1 - %2.', comment = 'ESP="Existen IDs en EnumExtension fuera del rango %1 - %2."';
    begin
        //Check Objects ID fits current range
        ExtLine.SetRange("Extension Code", Code);
        ExtLine.SetFilter("Object ID", '<%1', "Object Starting ID");
        if not ExtLine.IsEmpty() then begin
            ShowError := true;
            SetErrorMessage(ErrorMsg, StrSubstNo(ObjectIDRangeErr, "Object Starting ID", "Object Ending ID"));
        end else begin
            ExtLine.SetFilter("Object ID", '>%1', "Object Ending ID");
            if not ExtLine.IsEmpty() then begin
                ShowError := true;
                SetErrorMessage(ErrorMsg, StrSubstNo(ObjectIDRangeErr, "Object Starting ID", "Object Ending ID"));
            end;
        end;

        //Check Fields ID for TableExt fits current range.
        ExtField.SetRange("Extension Code", Code);
        ExtField.SetRange("Table Source Type", ExtField."Table Source Type"::"TableExtension");
        ExtField.SetFilter("Field ID", '<%1', "Object Starting ID");
        if not ExtField.IsEmpty() then begin
            ShowError := true;
            SetErrorMessage(ErrorMsg, StrSubstNo(FieldIDRangeErr, "Object Starting ID", "Object Ending ID"));
        end else begin
            ExtField.SetFilter("Field ID", '>%1', "Object Ending ID");
            if not ExtField.IsEmpty() then begin
                ShowError := true;
                SetErrorMessage(ErrorMsg, StrSubstNo(FieldIDRangeErr, "Object Starting ID", "Object Ending ID"));
            end;
        end;

        //Check Ordinals ID for EnumExt fits current range
        ExtEnum.SetRange("Extension Code", Code);
        ExtEnum.SetRange("Source Type", ExtEnum."Source Type"::EnumExtension);
        ExtEnum.SetFilter("Ordinal ID", '<%1', "Object Starting ID");
        if not ExtEnum.IsEmpty() then begin
            ShowError := true;
            SetErrorMessage(ErrorMsg, StrSubstNo(OrdinalIDRangeErr, "Object Starting ID", "Object Ending ID"));
        end else begin
            ExtEnum.SetFilter("Ordinal ID", '>%1', "Object Ending ID");
            if not ExtEnum.IsEmpty() then begin
                ShowError := true;
                SetErrorMessage(ErrorMsg, StrSubstNo(OrdinalIDRangeErr, "Object Starting ID", "Object Ending ID"));
            end;
        end;

        if ShowError then
            Error(ErrorMsg);
    end;

    local procedure SetErrorMessage(var ErrorMsg: Text; ErrorTxt: Text)
    var
        CRLF: Text[2];
    begin

        if ErrorMsg = '' then
            ErrorMsg := ErrorTxt
        else begin
            CRLF[1] := 13;
            CRLF[2] := 10;
            ErrorMsg += CRLF + ErrorTxt;
        end;
    end;

    local procedure SetRelLines()
    var
        ExtLine: Record "EXM Extension Lines";
        ExtField: Record "EXM Table Fields";
        ExtEnum: Record "EXM Enum Values";
    begin
        ExtLine.SetRange("Extension Code", Code);
        ExtLine.ModifyAll("Customer No.", "Customer No.");

        ExtField.SetRange("Extension Code", Code);
        ExtField.ModifyAll("Customer No.", "Customer No.");

        ExtEnum.SetRange("Extension Code", Code);
        ExtEnum.ModifyAll("Customer No.", "Customer No.");
    end;

    procedure InitRecord()
    var
        ExtSetup: Record "EXM Extension Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if Code = '' then begin
            ExtSetup.Get();
            if ExtSetup."Extension Nos." <> '' then
                Code := NoSeriesMgt.GetNextNo(ExtSetup."Extension Nos.", 0D, true);
        end;

        "Object Starting ID" := ExtSetup."Default Object Starting ID";
        "Object Ending ID" := ExtSetup."Default Object Ending ID";
    end;

    trigger OnDelete()
    var
        EXMExtLines: Record "EXM Extension Lines";
        EXMFields: Record "EXM Table Fields";
        EXMEnumValues: Record "EXM Enum Values";
    begin
        EXMExtLines.SetRange("Extension Code", Code);
        EXMExtLines.DeleteAll();

        EXMFields.SetRange("Extension Code", Code);
        EXMFields.DeleteAll();

        EXMEnumValues.SetRange("Extension Code", Code);
        EXMEnumValues.DeleteAll();
    end;

    trigger OnRename()
    var
        RenameErr: Label 'You cannot rename an %1.', Comment = 'ESP="No se puede renombrar una %1"';
    begin
        Error(RenameErr, TableCaption);
    end;
}