table 83201 "EXM Extension Header"
{
    Caption = 'Extension', Comment = 'ESP="Extensión"';
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code', Comment = 'ESP="Código"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Code field', Comment = 'ESP="Especifica el valor del campo Código"';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description', Comment = 'ESP="Descripción"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Description field', Comment = 'ESP="Especifica el valor del campo Descripción"';
        }
        field(3; Type; Option)
        {
            Caption = 'Type', Comment = 'ESP="Tipo"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionCaption = 'Internal,External', Comment = 'ESP="Interna,Externa"';
            OptionMembers = Internal,External;
            ToolTip = 'Specifies the value of the Type field', Comment = 'ESP="Especifica el valor del campo Tipo"';
            trigger OnValidate()
            begin
                if (xRec.Type <> Rec.Type) and (Rec.Type = Rec.Type::Internal) then begin
                    Rec."Customer No." := '';
                    Rec."Customer Name" := '';
                    SetRelLines();
                end;
            end;
        }
        field(4; "Object Starting ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Object Starting ID', Comment = 'ESP="Inicio ID objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Starting No. field', Comment = 'ESP="Especifica el valor del campo Nº inicial"';
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                if xRec."Object Starting ID" <> Rec."Object Starting ID" then begin
                    if ((Rec."Object Starting ID" > Rec."Object Ending ID") and (Rec."Object Ending ID" <> 0)) then
                        Rec."Object Ending ID" := Rec."Object Starting ID";

                    if Rec."Object Starting ID" <> 0 then
                        EXMExtMgt.AllowedObjectsID(Rec."Object Starting ID");
                    CheckObjectRange();
                end;
            end;
        }
        field(5; "Object Ending ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Object Ending ID', Comment = 'ESP="Final ID objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Ending No. field', Comment = 'ESP="Especifica el valor del campo Nº final"';
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
                ObjectRangeErr: Label '%1 must be greater then %2.', comment = 'ESP="%1 debe ser superior a %2."';
            begin
                if xRec."Object Ending ID" <> Rec."Object Ending ID" then begin
                    if (Rec."Object Ending ID" < Rec."Object Starting ID") then
                        Error(ObjectRangeErr, Rec.FieldCaption("Object Ending ID"), Rec.FieldCaption("Object Starting ID"));

                    if Rec."Object Ending ID" <> 0 then
                        EXMExtMgt.AllowedObjectsID(Rec."Object Ending ID");
                    CheckObjectRange();
                end;
            end;
        }
        field(6; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
            ToolTip = 'Specifies the value of the Customer No. field', Comment = 'ESP="Especifica el valor del campo Nº Cliente"';
            trigger OnValidate()
            var
                Cust: Record Customer;

            begin
                if xRec."Customer No." <> Rec."Customer No." then begin
                    if Rec."Customer No." = '' then
                        Rec."Customer Name" := ''
                    else
                        if Cust.Get(Rec."Customer No.") then
                            Rec."Customer Name" := Cust."Search Name";

                    SetRelLines();
                end;
            end;
        }
        field(7; "Customer Name"; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
        }
        field(8; "App Version"; Code[20])
        {
            Caption = 'App Version', Comment = 'ESP="Versión App"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the App Version field', Comment = 'ESP="Especifica el valor del campo Versión App"';
        }
        field(9; "App File"; Blob)
        {
            Caption = 'App File', Comment = 'ESP="Fichero App"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(10; Dependencies; Integer)
        {
            CalcFormula = Count("EXM Extension Dependencies" where("Extensión Code" = field(Code)));
            Caption = 'Dependencies', Comment = 'ESP="Dependencias"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the value of the Dependencies field', Comment = 'ESP="Especifica el valor del campo Dependencias"';
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
            DataClassification = OrganizationIdentifiableInformation;
            OptionCaption = ' ,Account,Item', Comment = 'ESP=" ,Cuenta,Producto"';
            OptionMembers = " ",Account,Item;
            trigger OnValidate()
            begin
                if Rec."Sell-Type" = Rec."Sell-Type"::" " then
                    Rec."No." := '';
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
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Table)));
            Caption = 'No. of Tables', Comment = 'ESP="Nº Tablas"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Tables in the extension', Comment = 'ESP="Muestra el Nº Tablas en la extensión"';
        }
        field(26; "No. of Reports"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Report)));
            Caption = 'No. of Reports', Comment = 'ESP="Nº Informes"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Reports in the extension', Comment = 'ESP="Muestra el Nº Informes en la extensión"';
        }
        field(27; "No. of Codeunits"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Codeunit)));
            Caption = 'No. of Codeunits', Comment = 'ESP="Nº Codeunits"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Codeunits in the extension', Comment = 'ESP="Muestra el Nº Codeunits en la extensión"';
        }
        field(28; "No. of XMLports"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(XMLport)));
            Caption = 'No. of XMLports', Comment = 'ESP="Nº XMLports"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of XMLports in the extension', Comment = 'ESP="Muestra el Nº XMLports en la extensión"';
        }
        field(29; "No. of Page"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Page)));
            Caption = 'No. of Pages', Comment = 'ESP="Nº Pages"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Pages in the extension', Comment = 'ESP="Muestra el Nº Pages en la extensión"';
        }
        field(30; "No. of Querys"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Query)));
            Caption = 'No. of Querys', Comment = 'ESP="Nº Querys"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Querys in the extension', Comment = 'ESP="Muestra el Nº Querys en la extensión"';
        }
        field(31; "No. of PageExtensions"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter("PageExtension")));
            Caption = 'No. of PageExtensions', Comment = 'ESP="Nº PageExtensions"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of PageExtensions in the extension', Comment = 'ESP="Muestra el Nº PageExtensions en la extensión"';
        }
        field(32; "No. of TableExtensions"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter("TableExtension")));
            Caption = 'No. of TableExtensions', Comment = 'ESP="Nº TableExtensions"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of TableExtensions in the extension', Comment = 'ESP="Muestra el Nº TableExtensions en la extensión"';
        }
        field(33; "No. of Enums"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Enum)));
            Caption = 'No. of Enums', Comment = 'ESP="Nº Enums"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Enums in the extension', Comment = 'ESP="Muestra el Nº Enums en la extensión"';
        }
        field(34; "No. of EnumExtensions"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(EnumExtension)));
            Caption = 'No. of EnumExtensions', Comment = 'ESP="Nº EnumExtensions"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of EnumExtensions in the extension', Comment = 'ESP="Muestra el Nº EnumExtensions en la extensión"';
        }
        field(35; "No. of Profiles"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter(Profile)));
            Caption = 'No. of Profiles', Comment = 'ESP="Nº Profiles"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of Profiles in the extension', Comment = 'ESP="Muestra el Nº Profiles en la extensión"';
        }
        field(36; "No. of ProfileExtensions"; Integer)
        {
            CalcFormula = count("EXM Extension Lines" where("Extension Code" = field(Code), "Object Type" = filter("ProfileExtension")));
            Caption = 'No. of ProfileExtensions', Comment = 'ESP="Nº ProfileExtensions"';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Shows the No. of ProfileExtensions in the extension', Comment = 'ESP="Muestra el Nº ProfileExtensions en la extensión"';
        }
        field(50; "GIT Repository URL"; Text[2048])
        {
            Caption = 'GIT Repository URL', Comment = 'ESP="URL repositorio GIT"';
            DataClassification = OrganizationIdentifiableInformation;
            ExtendedDatatype = URL;
            ToolTip = 'Specifies the value of the GIT Repository URL field', Comment = 'ESP="Especifica el valor del campo URL repositorio GIT"';
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
        ExtEnum: Record "EXM Enum Values";
        ExtLine: Record "EXM Extension Lines";
        ExtField: Record "EXM Table Fields";
        ShowError: Boolean;
        FieldIDRangeErr: Label 'Already exist field IDs on TableExtensions outside range %1 - %2.', comment = 'ESP="Existen IDs de campo en TableExtension fuera del rango %1 - %2."';
        OrdinalIDRangeErr: Label 'Already exist IDs on EnumExtensions outside range %1 - %2.', comment = 'ESP="Existen IDs en EnumExtension fuera del rango %1 - %2."';
        ObjectIDRangeErr: Label 'Already exist objects outside range %1 - %2.', comment = 'ESP="Existen objetos fuera del rango %1 - %2."';
        ErrorMsg: Text;
    begin
        //Check Objects ID fits current range
        ExtLine.SetRange("Extension Code", Code);
        ExtLine.SetFilter("Object ID", '<%1', "Object Starting ID");
        if not ExtLine.IsEmpty() then begin
            ShowError := true;
            SetErrorMessage(ErrorMsg, StrSubstNo(ObjectIDRangeErr, Rec."Object Starting ID", Rec."Object Ending ID"));
        end else begin
            ExtLine.SetFilter("Object ID", '>%1', Rec."Object Ending ID");
            if not ExtLine.IsEmpty() then begin
                ShowError := true;
                SetErrorMessage(ErrorMsg, StrSubstNo(ObjectIDRangeErr, Rec."Object Starting ID", Rec."Object Ending ID"));
            end;
        end;

        //Check Fields ID for TableExt fits current range.
        ExtField.SetRange("Extension Code", Code);
        ExtField.SetRange("Table Source Type", ExtField."Table Source Type"::"TableExtension");
        ExtField.SetFilter("Field ID", '<%1', Rec."Object Starting ID");
        if not ExtField.IsEmpty() then begin
            ShowError := true;
            SetErrorMessage(ErrorMsg, StrSubstNo(FieldIDRangeErr, Rec."Object Starting ID", Rec."Object Ending ID"));
        end else begin
            ExtField.SetFilter("Field ID", '>%1', Rec."Object Ending ID");
            if not ExtField.IsEmpty() then begin
                ShowError := true;
                SetErrorMessage(ErrorMsg, StrSubstNo(FieldIDRangeErr, Rec."Object Starting ID", Rec."Object Ending ID"));
            end;
        end;

        //Check Ordinals ID for EnumExt fits current range
        ExtEnum.SetRange("Extension Code", Rec."Code");
        ExtEnum.SetRange("Source Type", ExtEnum."Source Type"::EnumExtension);
        ExtEnum.SetFilter("Ordinal ID", '<%1', Rec."Object Starting ID");
        if not ExtEnum.IsEmpty() then begin
            ShowError := true;
            SetErrorMessage(ErrorMsg, StrSubstNo(OrdinalIDRangeErr, Rec."Object Starting ID", Rec."Object Ending ID"));
        end else begin
            ExtEnum.SetFilter("Ordinal ID", '>%1', Rec."Object Ending ID");
            if not ExtEnum.IsEmpty() then begin
                ShowError := true;
                SetErrorMessage(ErrorMsg, StrSubstNo(OrdinalIDRangeErr, Rec."Object Starting ID", Rec."Object Ending ID"));
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
        ExtEnum: Record "EXM Enum Values";
        ExtLine: Record "EXM Extension Lines";
        ExtField: Record "EXM Table Fields";
    begin
        ExtLine.SetRange("Extension Code", Rec."Code");
        ExtLine.ModifyAll("Customer No.", Rec."Customer No.");

        ExtField.SetRange("Extension Code", Rec."Code");
        ExtField.ModifyAll("Customer No.", Rec."Customer No.");

        ExtEnum.SetRange("Extension Code", Rec."Code");
        ExtEnum.ModifyAll("Customer No.", Rec."Customer No.");
    end;

    procedure InitRecord()
    var
        ExtSetup: Record "EXM Extension Setup";
        NoSeriesMgt: Codeunit "No. Series";
    begin
        ExtSetup.Get();
        if Rec."Code" = '' then
            if ExtSetup."Extension Nos." <> '' then
                Rec."Code" := NoSeriesMgt.GetNextNo(ExtSetup."Extension Nos.", 0D, true);

        Rec."Object Starting ID" := ExtSetup."Default Object Starting ID";
        Rec."Object Ending ID" := ExtSetup."Default Object Ending ID";
    end;

    trigger OnDelete()
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMExtLines: Record "EXM Extension Lines";
        EXMFields: Record "EXM Table Fields";
    begin
        EXMExtLines.SetRange("Extension Code", Rec."Code");
        EXMExtLines.DeleteAll();

        EXMFields.SetRange("Extension Code", Rec."Code");
        EXMFields.DeleteAll();

        EXMEnumValues.SetRange("Extension Code", Rec."Code");
        EXMEnumValues.DeleteAll();
    end;

    trigger OnRename()
    var
        RenameErr: Label 'You cannot rename an %1.', Comment = 'ESP="No se puede renombrar una %1"';
    begin
        Error(RenameErr, TableCaption);
    end;
}