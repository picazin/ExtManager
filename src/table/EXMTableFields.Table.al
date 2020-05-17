table 83203 "EXM Table Fields"
{
    Caption = 'Extension Fields', Comment = 'ESP="Campos extensión"';
    LookupPageId = "EXM Field List";
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.', Comment = 'ESP="Nº línea origen"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "Table Source Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
            OptionCaption = ',Table,,,,,,,,,,,,,,TableExt,,,,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,,,,,,,,,,,,,TableExt,,,,,,,,,,,,,,,,,,,,,,, "';
        }
        field(4; "Source Table ID"; Integer)
        {
            Caption = 'Source Table ID', Comment = 'ESP="Id. tabla origen"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Field ID", SetFieldID("Source Table ID", "Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(5; "Table ID"; Integer)
        {
            Caption = 'Table ID', Comment = 'ESP="Id. tabla"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Field ID", SetFieldID("Source Table ID", "Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(6; "Field ID"; Integer)
        {
            Caption = 'Field ID', Comment = 'ESP="Id. campo"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name', Comment = 'ESP="Nombre de campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(8; "Field Caption"; Text[250])
        {
            Caption = 'Field Caption', Comment = 'ESP="Título campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(9; "Data Type"; Option)
        {
            Caption = 'Data Type', Comment = 'ESP="Tipo datos"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,Code,Binary,BLOB,Boolean,Integer,OemCode,Option,BigInteger,Duration,GUID,DateTime," ";
            InitValue = " ";
        }
        field(10; "Lenght"; Integer)
        {
            Caption = 'Lenght', Comment = 'ESP="Longitud"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
        }
        field(11; "Field Class"; Option)
        {
            Caption = 'Field Class', Comment = 'ESP="Clase campo"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Normal,FlowField,FlowFilter;
        }
        field(12; "Option String"; Text[250])
        {
            Caption = 'Option String', Comment = 'ESP="Texto opciones"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(13; Obsolete; Boolean)
        {
            Caption = 'Obsolete', Comment = 'ESP="Obsoleto"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(14; "Created by"; Code[50])
        {
            Caption = 'Created by', Comment = 'ESP="Creado por"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(15; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', Comment = 'ESP="Fecha creación"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(20; "IsPK"; Boolean)
        {
            Caption = 'Is Part Of Primary Key', Comment = 'ESP="Forma parte clave primária"';
            DataClassification = OrganizationIdentifiableInformation;
        }

    }
    keys
    {
        key(PK; "Extension Code", "Source Line No.", "Table Source Type", "Source Table ID", "Table ID", "Field ID")
        {
            Clustered = true;
        }
        key(K2; "Source Table ID", "Table ID", "Field ID")
        { }
        key(K3; "Source Table ID", "Field ID")
        { }
    }

    trigger OnInsert()
    begin
        "Created by" := CopyStr(UserId(), 1, MaxStrLen("Created by"));
        "Creation Date" := CurrentDateTime();

        ValidateData();
    end;

    //TODO Improvement - Look for empty ID
    local procedure SetFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]) FieldID: Integer
    var
        EXMSetup: Record "EXM Extension Setup";
        EXMExtHeader: Record "EXM Extension Header";
        EXMFields: Record "EXM Table Fields";
        EXMExtMgt: Codeunit "EXM Extension Management";
        IsHandled: Boolean;
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Field ID" then
            exit;

        IsHandled := false;
        OnBeforeCalculateFieldID(SourceTableID, TableID, CustNo, FieldID, IsHandled);
        if IsHandled then
            exit(FieldID);

        EXMExtHeader.Get("Extension Code");
        if SourceTableID = 0 then
            EXMFields.SetCurrentKey("Source Table ID", "Table ID", "Field ID")
        else begin
            EXMFields.SetCurrentKey("Source Table ID", "Field ID");
            EXMFields.SetFilter("Field ID", '%1..%2', EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
        end;

        if CustNo <> '' then
            EXMFields.SetFilter("Extension Code", EXMExtMgt.GetCustomerExtensions(CustNo))
        else
            EXMFields.SetRange("Extension Code", "Extension Code");

        EXMFields.SetRange("Source Table ID", SourceTableID);
        if SourceTableID = 0 then
            EXMFields.SetRange("Table ID", TableID);
        if EXMFields.FindLast() then
            FieldID := EXMFields."Field ID" + 1
        else
            if "Table Source Type" = "Table Source Type"::Table then
                FieldID := 1
            else
                FieldID := EXMExtHeader."Object Starting ID";

        exit(FieldID);
    end;

    local procedure ValidateData()
    var
        EXMExtMgt: Codeunit "EXM Extension Management";
        SelectDataTypeErr: Label 'Must select a data type.', Comment = 'ESP="Debe seleccionar un tipo de datos."';
    begin
        case "Table Source Type" of
            "Table Source Type"::Table:
                begin
                    TestField("Source Table ID", 0);
                    TestField("Table ID");
                end;
            "Table Source Type"::"TableExtension":
                begin
                    TestField("Source Table ID");
                    TestField("Table ID");
                end;
        end;

        TestField("Field ID");
        TestField("Field Name");

        if "Data Type" = "Data Type"::" " then
            Error(SelectDataTypeErr);

        if ("Data Type" in ["Data Type"::Text, "Data Type"::Code]) then
            TestField(Lenght);

        if "Table Source Type" = "Table Source Type"::"TableExtension" then
            EXMExtMgt.ValidateExtensionRangeID("Extension Code", "Field ID");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]; var FieldID: Integer; var IsHandled: Boolean)
    begin
    end;
}