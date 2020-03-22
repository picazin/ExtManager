table 83201 "EXM Extension Header"
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
            OptionMembers = Internal,External;
            OptionCaption = 'Internal,External', Comment = 'ESP="Interna,Externa"';
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
                EXMExtMgt.AllowedObjectsID("Object Starting ID");
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
            begin
                EXMExtMgt.AllowedObjectsID("Object Ending ID");
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
                if xRec."Customer No." <> "Customer No." then
                    if "Customer No." = '' then
                        "Customer Name" := ''
                    else
                        if Cust.Get("Customer No.") then
                            "Customer Name" := Cust."Search Name";
            end;
        }
        field(7; "Customer Name"; Text[100])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(8; "GIT Repository URL"; Text[2048])
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
    }

    trigger OnInsert()
    var
        ExtSetup: Record "EXM Extension Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if Code = '' then begin
            ExtSetup.Get();
            ExtSetup.TestField("Extension Nos.");
            Code := NoSeriesMgt.GetNextNo(ExtSetup."Extension Nos.", 0D, true);
        end;

        "Object Starting ID" := ExtSetup."Default Object Starting ID";
        "Object Ending ID" := ExtSetup."Default Object Ending ID";
    end;

    trigger OnDelete()
    var
        EXMExtLines: Record "EXM Extension Lines";
        EXMExtDetail: Record "EXM Extension Lines Detail";
    begin
        EXMExtLines.SetRange("Extension Code", Code);
        EXMExtLines.DeleteAll();

        EXMExtDetail.SetRange("Extension Code", Code);
        EXMExtDetail.DeleteAll();
    end;

    trigger OnRename()
    begin
        Error('');
    end;
}