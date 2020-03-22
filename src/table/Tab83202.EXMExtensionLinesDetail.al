table 83203 "EXM Extension Lines Detail"
{
    Caption = 'Extension Fields', Comment = 'ESP="Campos extensión"';
    LookupPageId = "EXM Field List";
    DrillDownPageId = "EXM Field List";
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
        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID', Comment = 'ESP="Id. tabla"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Field ID", SetFieldID("Table ID", EXMExtHeader."Customer No."))
            end;
        }
        field(4; "Field ID"; Integer)
        {
            Caption = 'Field ID', Comment = 'ESP="Id. campo"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                //TODO Validate not used (INTERNAL / External)
                EXMExtMgt.ValidateExtensionRangeID("Extension Code", "Field ID");
            end;
        }
        field(5; "Field Name"; Text[30])
        {
            Caption = 'Field Name', Comment = 'ESP="Nombre de campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(6; "Field Caption"; Text[250])
        {
            Caption = 'Field Caption', Comment = 'ESP="Título campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(7; "Data Type"; Option)
        {
            Caption = 'Data Type', Comment = 'ESP="Tipo datos"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = TableFilter,RecordID,OemText,Date,Time,DateFormula,Decimal,Media,MediaSet,Text,Code,Binary,BLOB,Boolean,Integer,OemCode,Option,BigInteger,Duration,GUID,DateTime;
        }
        field(8; "Lenght"; Integer)
        {
            Caption = 'Lenght', Comment = 'ESP="Longitud"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
        }
        field(9; "Field Class"; Option)
        {
            Caption = 'Field Class', Comment = 'ESP="Clase campo"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Normal,FlowField,FlowFilter;
        }
        field(10; "Option String"; Text[250])
        {
            Caption = 'Option String', Comment = 'ESP="Texto opciones"';
            DataClassification = OrganizationIdentifiableInformation;
        }
    }
    keys
    {
        key(PK; "Extension Code", "Source Line No.", "Table ID", "Field ID")
        {
            Clustered = true;
        }
    }

    local procedure SetFieldID(TableID: Integer; CustNo: Code[20]): Integer
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMExtLineDetail: Record "EXM Extension Lines Detail";
        EXMExtMgt: Codeunit "EXM Extension Management";
    begin
        //TODO Posar valor inicial o seguent segons extensió disponible (check)
        //TODO Diferenciar per INTERNAL / EXTERNAL
        //TODO Millora - Buscar espai buit dins d'extensió!! 50000, 50004 ha de proposar 50001
        if CustNo <> '' then
            EXMExtLineDetail.SetFilter("Extension Code", EXMExtMgt.GetCustomerExtensions(CustNo))
        else
            EXMExtLineDetail.SetRange("Extension Code", "Extension Code");

        EXMExtLineDetail.SetRange("Table ID", TableID);
        if EXMExtLineDetail.FindLast() then
            exit(EXMExtLineDetail."Field ID" + 1)
        else begin
            EXMExtHeader.Get("Extension Code");
            exit(EXMExtHeader."Object Starting ID");
        end;
    end;

    trigger OnInsert()
    begin
        ValidateData();
    end;

    local procedure ValidateData()
    begin
        TestField("Field ID");
        TestField("Field Name");
    end;

    //TODO validar camps per inserir dades

    //TODO Funció per mostrar tots els camps de la taula - Funció a petició dades en ExtLines si tipus taula
    //GetFieldData("Table ID", "Field ID");
    local procedure GetFieldData(TableNo: Integer; FieldId: Integer)
    var
        FieldData: Record Field;
        intType: Integer;
    begin
        if not FieldData.Get(TableNo, FieldId) then begin
            "Field Name" := '';
            "Field Caption" := '';
            "Data Type" := 0;
            Lenght := FieldData.Len;
            "Field Class" := 0;
            "Option String" := '';
        end else begin
            "Field Name" := FieldData.FieldName;
            "Field Caption" := FieldData."Field Caption";
            intType := FieldData.Type;
            "Data Type" := intType;
            Lenght := FieldData.Len;
            "Field Class" := FieldData.Class;
            "Option String" := FieldData.OptionString
        end;
    end;
}