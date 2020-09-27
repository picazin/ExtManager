table 83205 "EXM Enum Values"
{
    Caption = 'Enums values', Comment = 'ESP="Valores Enum"';
    LookupPageId = "EXM Enum Values";
    DataClassification = OrganizationIdentifiableInformation;

    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "EXM Extension Header";
            trigger OnValidate()
            var
                ExtHeader: Record "EXM Extension Header";
            begin
                ExtHeader.Get("Extension Code");
                "Customer No." := ExtHeader."Customer No.";
            end;
        }
        field(2; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.', Comment = 'ESP="Nº línea origen"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(3; "Source Type"; Option)
        {
            Caption = 'Source Type', Comment = 'ESP="Tipo origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
            OptionCaption = ',,,,,,,,,,,,,,,,Enum,EnumExtension,,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",,,,,,,,,,,,,,,,Enum,EnumExtension,,,,,,,,,,,,,,,,,,,,, "';
        }
        field(4; "Source Enum ID"; Integer)
        {
            Caption = 'Source Enum ID', Comment = 'ESP="Id. Enum origen"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Ordinal ID", SetEnumID("Source Enum ID", "Enum ID", EXMExtHeader."Customer No."))
            end;
        }
        field(5; "Enum ID"; Integer)
        {
            Caption = 'Enum ID', Comment = 'ESP="Id. Enum"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Validate("Ordinal ID", SetEnumID("Source Enum ID", "Enum ID", EXMExtHeader."Customer No."))
            end;
        }
        field(6; "Ordinal ID"; Integer)
        {
            Caption = 'Ordinal ID', Comment = 'ESP="Id. ordinal"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(7; "Enum Value"; Text[250])
        {
            Caption = 'Enum Value', Comment = 'ESP="Valor Enum"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        /*
        field(8; "Enum Caption"; Text[250])
        {
            Caption = 'Enum Caption', Comment = 'ESP="Título campo"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        */
        field(15; "Created by"; Code[50])
        {
            Caption = 'Created by', Comment = 'ESP="Creado por"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(16; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', Comment = 'ESP="Fecha creación"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(17; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
        }
    }

    keys
    {
        key(PK; "Extension Code", "Source Line No.", "Source Type", "Source Enum ID", "Enum ID", "Ordinal ID")
        {
            Clustered = true;
        }
        key(K2; "Source Enum ID", "Enum ID", "Ordinal ID")
        { }
        key(K3; "Source Enum ID", "Enum ID")
        { }
    }

    trigger OnInsert()
    begin
        "Created by" := CopyStr(UserId(), 1, MaxStrLen("Created by"));
        "Creation Date" := CurrentDateTime();

        ValidateData();
    end;

    //TODO Improvement - Look for empty ID
    local procedure SetEnumID(SourceEnumID: Integer; EnumID: Integer; CustNo: Code[20]) EnumValueID: Integer
    var
        EXMSetup: Record "EXM Extension Setup";
        EXMExtHeader: Record "EXM Extension Header";
        EXMEnumValues: Record "EXM Enum Values";
        ExpectedId: Integer;
        IsHandled: Boolean;
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Field ID" then
            exit;

        IsHandled := false;
        OnBeforeCalculateEnumValueID(SourceEnumID, EnumID, CustNo, EnumValueID, IsHandled);
        if IsHandled then
            exit(EnumValueID);

        EXMExtHeader.Get("Extension Code");
        if SourceEnumID = 0 then
            EXMEnumValues.SetCurrentKey("Source Enum ID", "Enum ID", "Ordinal ID")
        else begin
            EXMEnumValues.SetCurrentKey("Source Enum ID", "Enum ID");
            EXMEnumValues.SetFilter("Ordinal ID", '%1..%2', EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
        end;

        EXMEnumValues.SetFilter("Customer No.", CustNo);
        EXMEnumValues.SetRange("Source Enum ID", SourceEnumID);
        if SourceEnumID = 0 then
            EXMEnumValues.SetRange("Enum ID", EnumID);
        if not EXMEnumValues.IsEmpty() then begin
            if EXMSetup."Find Object ID Gaps" then begin
                EXMEnumValues.FindSet();
                ExpectedId := EXMExtHeader."Object Starting ID";
                repeat
                    if ExpectedId <> EXMEnumValues."Ordinal ID" then
                        exit(ExpectedId)
                    else
                        ExpectedId += 1;
                until EXMEnumValues.Next() = 0;
                EnumValueID := ExpectedId;
            end else begin
                EXMEnumValues.FindLast();
                EnumValueID := EXMEnumValues."Ordinal ID" + 1;
            end;
        end else
            if "Source Type" = "Source Type"::Enum then
                EnumValueID := 1
            else
                EnumValueID := EXMExtHeader."Object Starting ID";

        OnAfterAssignEnumID(SourceEnumID, EnumID, CustNo, EnumValueID);

        exit(EnumValueID)
    end;

    local procedure ValidateData()
    var
        EXMExtMgt: Codeunit "EXM Extension Management";
    begin
        case "Source Type" of
            "Source Type"::Enum:
                begin
                    TestField("Source Enum ID", 0);
                    TestField("Enum ID");
                end;
            "Source Type"::"EnumExtension":
                begin
                    TestField("Source Enum ID");
                    TestField("Enum ID");
                end;
        end;

        TestField("Ordinal ID");
        TestField("Enum Value");

        if "Source Type" = "Source Type"::"EnumExtension" then
            EXMExtMgt.ValidateExtensionRangeID("Extension Code", "Enum ID");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateEnumValueID(SourceEnumID: Integer; EnumID: Integer; CustNo: Code[20]; var EnumValueID: Integer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignEnumID(SourceEnumID: Integer; EnumID: Integer; CustNo: Code[20]; var EnumValueID: Integer)
    begin
    end;
}