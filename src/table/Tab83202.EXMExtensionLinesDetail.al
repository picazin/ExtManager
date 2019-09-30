table 83203 "EXM Extension Lines Detail"
{
    DataClassification = OrganizationIdentifiableInformation;
    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ESP="Nº línea"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID', Comment = 'ESP="Id. tabla"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            //Fer Flowfield per obtenir dades?
        }
        field(4; "Field ID"; Integer)
        {
            Caption = 'Field ID', Comment = 'ESP="Id. campo"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            trigger OnValidate()
            begin
                GetFieldData("Table ID", "Field ID");
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
        key(PK; "Extension Code", "Line No.", "Table ID", "Field ID")
        {
            Clustered = true;
        }
    }
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