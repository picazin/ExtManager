table 83201 "Extension Header"
{
    DataClassification = OrganizationIdentifiableInformation;
    Caption = 'Extension', Comment = 'ESP="Extensión"';

    fields
    {
        field(1; Code; Code[20])
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
            OptionMembers = Internal,External,Both;
            OptionCaption = 'Internal,External,Both', Comment = 'ESP="Interna,Externa,Ambas"';
        }
        field(4; "Object Starting Range"; Integer)
        {
            Caption = 'Object Starting Range', Comment = 'ESP="Inicio rango objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
        }
        field(5; "Object Ending Range"; Integer)
        {
            Caption = 'Object Ending Range', Comment = 'ESP="Final rango objetos"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        ExtSetup: Record "Extension Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if Code = '' then begin
            ExtSetup.Get();
            ExtSetup.TestField("Extension Nos.");
            Code := NoSeriesMgt.GetNextNo(ExtSetup."Extension Nos.", 0D, true);
        end;
    end;

    trigger OnDelete()
    begin
        //eliminar linies relacionades  
    end;

    trigger OnRename()
    begin
        //No permetre
    end;
}