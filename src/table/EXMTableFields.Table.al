table 83203 "EXM Table Fields"
{
    Caption = 'Extension Fields', Comment = 'ESP="Campos extensión"';
    DataClassification = OrganizationIdentifiableInformation;
    LookupPageId = "EXM Field List";

    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "EXM Extension Header";
            ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Cód. extensión"';
            trigger OnValidate()
            var
                ExtHeader: Record "EXM Extension Header";
            begin
                ExtHeader.Get(Rec."Extension Code");
                Rec."Customer No." := ExtHeader."Customer No.";
            end;
        }
        field(2; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.', Comment = 'ESP="Nº línea origen"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Source Line No. field', Comment = 'ESP="Especifica el valor del campo Nº línea origen"';
        }
        field(3; "Table Source Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionCaption = ',Table,,,,,,,,,,,,,,TableExt,,,,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,,,,,,,,,,,,,TableExt,,,,,,,,,,,,,,,,,,,,,,, "';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
            ToolTip = 'Specifies the value of the Source Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto origen"';
        }
        field(4; "Source Table ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Table ID', Comment = 'ESP="Id. tabla origen"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Source Table ID field', Comment = 'ESP="Especifica el valor del campo Id. tabla origen"';
            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get(Rec."Extension Code");
                Rec.Validate("Field ID", SetFieldID(Rec."Source Table ID", Rec."Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(5; "Table ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Table ID', Comment = 'ESP="Id. tabla"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Table ID field', Comment = 'ESP="Especifica el valor del campo Id. tabla"';
            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get(Rec."Extension Code");
                Rec.Validate("Field ID", SetFieldID(Rec."Source Table ID", Rec."Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(6; "Field ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Field ID', Comment = 'ESP="Id. campo"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Field ID field', Comment = 'ESP="Especifica el valor del campo Id. campo"';
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name', Comment = 'ESP="Nombre de campo"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Field Name field', Comment = 'ESP="Especifica el valor del campo Nombre de campo"';
        }
        field(8; "Field Caption"; Text[250])
        {
            Caption = 'Field Caption', Comment = 'ESP="Título campo"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Field Caption field', Comment = 'ESP="Especifica el valor del campo Título campo"';
        }
        field(9; "Data Type"; Option)
        {
            Caption = 'Data Type', Comment = 'ESP="Tipo datos"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = " ";
            OptionMembers = TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,Code,Binary,BLOB,Boolean,Integer,OemCode,Option,BigInteger,Duration,GUID,DateTime,Enum," ";
            ToolTip = 'Specifies the value of the Data Type field', Comment = 'ESP="Especifica el valor del campo Tipo datos"';
        }
        field(10; Lenght; Integer)
        {
            BlankZero = true;
            Caption = 'Lenght', Comment = 'ESP="Longitud"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Lenght field', Comment = 'ESP="Especifica el valor del campo Longitud"';
        }
        field(11; "Field Class"; Option)
        {
            Caption = 'Field Class', Comment = 'ESP="Clase campo"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Normal,FlowField,FlowFilter;
            ToolTip = 'Specifies the value of the Field Class field', Comment = 'ESP="Especifica el valor del campo Clase campo"';
        }
        field(12; "Option String"; Text[250])
        {
            Caption = 'Option String', Comment = 'ESP="Texto opciones"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Option String field', Comment = 'ESP="Especifica el valor del campo Texto opciones"';
            trigger OnLookup()
            var
                AllObjects: Record AllObjWithCaption;
                AllObjList: Page "All Objects with Caption";
            begin
                if Rec."Data Type" <> Rec."Data Type"::Enum then
                    exit;

                //if AllObjects.Get(Rec."Source Object Type", Rec."Source Object ID") then
                //    AllObjList.SetRecord(AllObjects);

                AllObjects.FilterGroup(2);
                AllObjects.SetRange("Object Type", AllObjects."Object Type"::Enum);
                AllObjects.FilterGroup(0);
                if AllObjects.FindSet() then
                    AllObjList.SetTableView(AllObjects);

                AllObjList.Editable(false);
                AllObjList.LookupMode(true);
                if AllObjList.RunModal() = Action::LookupOK then begin
                    AllObjList.GetRecord(AllObjects);
                    Rec."Option String" := AllObjects."Object Caption";
                end;
            end;
        }
        field(13; Obsolete; Boolean)
        {
            Caption = 'Obsolete', Comment = 'ESP="Obsoleto"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Obsolete field', Comment = 'ESP="Especifica el valor del campo Obsoleto"';
        }
        field(14; "Created by"; Code[50])
        {
            Caption = 'Created by', Comment = 'ESP="Creado por"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            ToolTip = 'Specifies the value of the Created by field', Comment = 'ESP="Especifica el valor del campo Creado por"';
        }
        field(15; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', Comment = 'ESP="Fecha creación"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            ToolTip = 'Specifies the value of the Creation Date field', Comment = 'ESP="Especifica el valor del campo Fecha creación"';
        }
        field(16; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
        }
        field(20; IsPK; Boolean)
        {
            Caption = 'Is Part Of Primary Key', Comment = 'ESP="Forma parte clave primária"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Is Part Of Primary Key field', Comment = 'ESP="Especifica el valor del campo Forma parte clave primária"';
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
        Rec."Created by" := CopyStr(UserId(), 1, MaxStrLen(Rec."Created by"));
        Rec."Creation Date" := CurrentDateTime();

        ValidateData();
    end;

    local procedure SetFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]) FieldID: Integer
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMSetup: Record "EXM Extension Setup";
        EXMFields: Record "EXM Table Fields";
        IsHandled: Boolean;
        ExpectedId: Integer;
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Field ID" then
            exit;

        IsHandled := false;
        OnBeforeCalculateFieldID(SourceTableID, TableID, CustNo, FieldID, IsHandled);
        if IsHandled then
            exit(FieldID);

        EXMExtHeader.Get(Rec."Extension Code");
        if SourceTableID = 0 then
            EXMFields.SetCurrentKey("Source Table ID", "Table ID", "Field ID")
        else begin
            EXMFields.SetCurrentKey("Source Table ID", "Field ID");
            EXMFields.SetFilter("Field ID", '%1..%2', EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
        end;

        EXMFields.SetFilter("Customer No.", CustNo);
        EXMFields.SetRange("Source Table ID", SourceTableID);
        if SourceTableID = 0 then
            EXMFields.SetRange("Table ID", TableID);
        if not EXMFields.IsEmpty() then begin
            if EXMSetup."Find Object ID Gaps" then begin
                EXMFields.FindSet();
                if Rec."Table Source Type" = Rec."Table Source Type"::Table then
                    ExpectedId := 1
                else
                    ExpectedId := EXMExtHeader."Object Starting ID";
                repeat
                    if ExpectedId <> EXMFields."Field ID" then
                        exit(ExpectedId)
                    else
                        ExpectedId += 1;
                until EXMFields.Next() = 0;
                FieldID := ExpectedId;
            end else begin
                EXMFields.FindLast();
                FieldID := EXMFields."Field ID" + 1;
            end;
        end else
            if Rec."Table Source Type" = Rec."Table Source Type"::Table then
                FieldID := 1
            else
                FieldID := EXMExtHeader."Object Starting ID";

        OnAfterAssignFieldID(SourceTableID, TableID, CustNo, FieldID);

        exit(FieldID);
    end;

    local procedure ValidateData()
    var
        EXMExtMgt: Codeunit "EXM Extension Management";
        SelectDataTypeErr: Label 'Must select a data type.', Comment = 'ESP="Debe seleccionar un tipo de datos."';
    begin
        case Rec."Table Source Type" of
            Rec."Table Source Type"::Table:
                begin
                    Rec.TestField("Source Table ID", 0);
                    Rec.TestField("Table ID");
                end;
            Rec."Table Source Type"::"TableExtension":
                begin
                    Rec.TestField("Source Table ID");
                    Rec.TestField("Table ID");
                end;
        end;

        Rec.TestField("Field ID");
        Rec.TestField("Field Name");

        if Rec."Data Type" = Rec."Data Type"::" " then
            Error(SelectDataTypeErr);

        if (Rec."Data Type" in [Rec."Data Type"::Text, Rec."Data Type"::Code]) then
            Rec.TestField(Lenght);

        if Rec."Table Source Type" = Rec."Table Source Type"::"TableExtension" then
            EXMExtMgt.ValidateExtensionRangeID(Rec."Extension Code", Rec."Field ID");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]; var FieldID: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignFieldID(SourceTableID: Integer; TableID: Integer; CustNo: Code[20]; var FieldID: Integer)
    begin
    end;
}