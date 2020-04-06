table 83205 "EXM Extension Setup"
{
    Caption = 'Extension Setup', Comment = 'ESP="Configuración extensión"';
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', Comment = 'ESP="Clave primária"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(2; "Extension Nos."; Code[20])
        {
            Caption = 'Extension Nos.', Comment = 'ESP="Nº série extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "No. Series";
        }
        field(3; "Default Object Starting ID"; Integer)
        {
            Caption = 'Default Starting Range', Comment = 'ESP="Rango inicial por defecto"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                EXMExtMgt.AllowedObjectsID("Default Object Starting ID");
            end;
        }
        field(4; "Default Object Ending ID"; Integer)
        {
            Caption = 'Default Ending Range', Comment = 'ESP="Rango final por defecto"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            var
                EXMExtMgt: Codeunit "EXM Extension Management";
            begin
                EXMExtMgt.AllowedObjectsID("Default Object Ending ID");
            end;
        }
        field(5; "Object Names"; Option)
        {
            Caption = 'Object Names', Comment = 'ESP="Nombre objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = Caption,Name;
            OptionCaption = 'Caption,Name', Comment = 'ESP="Traducción,Original"';
        }
        field(6; "Disable Auto. Objects ID"; Boolean)
        {
            Caption = 'Disable Auto Objects ID', Comment = 'ESP="Deshabilitar asignación ID objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            var
                DisableQst: Label 'Enable this option will disable all objects ID validations and may cause extensions errors. Continue?', Comment = 'ESP="Habilitar esta opción implica que no se validaran los ID de los objetos y puede llevar a errores. Continuar?"';
            begin
                if "Disable Auto. Objects ID" then
                    if not Confirm(DisableQst, false) then
                        Error('');
            end;
        }
        field(7; "Disable Auto. Field ID"; Boolean)
        {
            Caption = 'Disable Auto Field ID', Comment = 'ESP="Deshabilitar asignación ID campos"';
            DataClassification = OrganizationIdentifiableInformation;
            trigger OnValidate()
            var
                DisableQst: Label 'Enable this option will disable all fields ID validations and may cause extensions errors. Continue?', Comment = 'ESP="Habilitar esta opción implica que no se validaran los ID de los campos y puede llevar a errores. Continuar?"';
            begin
                if "Disable Auto. Field ID" then
                    if not Confirm(DisableQst, false) then
                        Error('');
            end;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}