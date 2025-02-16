table 83209 "EXM Tree View"
{
    Caption = 'Extension Objects Tree View', Comment = 'ESP="Vista arbol objetos"';
    DataClassification = OrganizationIdentifiableInformation;
    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "EXM Extension Header";
            ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Cód. extensión"';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ESP="Nº línea"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "Object Type"; Option)
        {
            Caption = 'Object Type', Comment = 'ESP="Tipo objeto"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = " ";
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,ReportExtension,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,ReportExtension,,,,,,,,,,,,,,,,,, "';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","ReportExtension",,,,,,,,,,,,,,,,,," ";
        }
        field(4; "Object ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Object ID', Comment = 'ESP="ID objeto"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Object ID field', Comment = 'ESP="Especifica el valor del campo ID objeto"';
        }
        field(5; "Object Name"; Text[250])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
        }
        field(6; "Field ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Field ID', Comment = 'ESP="Id. campo"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Field Id field', Comment = 'ESP="Especifica el valor del campo ID Campo"';
        }
        field(7; "Field Name"; Text[30])
        {
            Caption = 'Field Name', Comment = 'ESP="Nombre de campo"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Field Name field', Comment = 'ESP="Especifica el valor del campo Nombre Campo"';
        }
        field(8; "Field Data Type"; Text[30])
        {
            Caption = 'Field Data Type', Comment = 'ESP="Tipo datos"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Field Data Type field', Comment = 'ESP="Especifica el valor del campo Tipo Dato Campo"';
        }
        field(9; "Source Object Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = " ";
            OptionCaption = ',Table,,,,,,,Page,,,,,,,,Enum,,Profile,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,,,,,,Page,,,,,,,,Enum,,Profile,,,,,,,,,,,,,,,,,,,, "';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","ReportExtension",,,,,,,,,,,,,,,,,," ";
            ToolTip = 'Specifies the value of the Source Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto origen"';
        }
        field(10; "Source Object ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Object ID', Comment = 'ESP="ID objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Source Object ID field', Comment = 'ESP="Especifica el valor del campo ID objeto origen"';
        }
        field(11; "Source Name"; Text[250])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
        }
        field(12; "Type Description"; Text[250])
        {
            Caption = 'Type', Comment = 'ESP="Tipo"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto"';
        }

        field(100; Indentation; Integer)
        {
            Caption = 'Indentation', Comment = 'ESP="Indentación"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Level field', Comment = 'ESP="Especifica el valor del campo Nivel"';
        }
    }

    keys
    {
        key(PK; "Extension Code", "Line No.")
        {
            Clustered = true;
        }
        key(K2; "Extension Code", "Object Type", "Object ID")
        { }
        key(K3; "Extension Code", "Object Type", "Object ID", "Source Object Type", "Source Object ID")
        { }
    }
}