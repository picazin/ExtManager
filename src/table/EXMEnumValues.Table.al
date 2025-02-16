table 83205 "EXM Enum Values"
{
    Caption = 'Enums values', Comment = 'ESP="Valores Enum"';
    DataClassification = OrganizationIdentifiableInformation;
    LookupPageId = "EXM Enum Values";

    fields
    {
        field(1; "Extension Code"; Code[20])
        {
            Caption = 'Extension Code', Comment = 'ESP="Cód. extensión"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = "EXM Extension Header";
            ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Código Extensión"';
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
        field(3; "Source Type"; Option)
        {
            Caption = 'Source Type', Comment = 'ESP="Tipo origen"';
            DataClassification = OrganizationIdentifiableInformation;
            OptionCaption = ',,,,,,,,,,,,,,,,Enum,EnumExtension,,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",,,,,,,,,,,,,,,,Enum,EnumExtension,,,,,,,,,,,,,,,,,,,,, "';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
            ToolTip = 'Specifies the value of the Source Type field', Comment = 'ESP="Especifica el valor del campo Tipo origen"';
        }
        field(4; "Source Enum ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Enum ID', Comment = 'ESP="Id. Enum origen"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Source Enum ID field', Comment = 'ESP="Especifica el valor del campo Id. Enum origen"';
            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get(Rec."Extension Code");
                Rec.Validate("Ordinal ID", SetEnumID(Rec."Source Enum ID", Rec."Enum ID", EXMExtHeader."Customer No."))
            end;
        }
        field(5; "Enum ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Enum ID', Comment = 'ESP="Id. Enum"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Enum ID field', Comment = 'ESP="Especifica el valor del campo Id. Enum"';
            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                EXMExtHeader.Get("Extension Code");
                Rec.Validate("Ordinal ID", SetEnumID(Rec."Source Enum ID", Rec."Enum ID", EXMExtHeader."Customer No."))
            end;
        }
        field(6; "Ordinal ID"; Integer)
        {
            Caption = 'Ordinal ID', Comment = 'ESP="Id. ordinal"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Ordinal ID field', Comment = 'ESP="Especifica el valor del campo ID Ordinal"';
        }
        field(7; "Enum Value"; Text[250])
        {
            Caption = 'Enum Value', Comment = 'ESP="Valor Enum"';
            DataClassification = OrganizationIdentifiableInformation;
            ToolTip = 'Specifies the value of the Enum Value field', Comment = 'ESP="Especifica el valor del campo valor Enum"';
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
            ToolTip = 'Specifies the value of the Created by field', Comment = 'ESP="Especifica quién creo el registro."';
        }
        field(16; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', Comment = 'ESP="Fecha creación"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            ToolTip = 'Specifies the value of the Creation Date field', Comment = 'ESP="Especifica la fecha de creación del registro."';
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
        Rec."Created by" := CopyStr(UserId(), 1, MaxStrLen(Rec."Created by"));
        Rec."Creation Date" := CurrentDateTime();

        ValidateData();
    end;

    //TODO Improvement - Look for empty ID
    local procedure SetEnumID(SourceEnumID: Integer; EnumID: Integer; CustNo: Code[20]) EnumValueID: Integer
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMExtHeader: Record "EXM Extension Header";
        EXMSetup: Record "EXM Extension Setup";
        IsHandled: Boolean;
        ExpectedId: Integer;
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Field ID" then
            exit;

        IsHandled := false;
        OnBeforeCalculateEnumValueID(SourceEnumID, EnumID, CustNo, EnumValueID, IsHandled);
        if IsHandled then
            exit(EnumValueID);

        EXMExtHeader.Get(Rec."Extension Code");
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
                if Rec."Source Type" = Rec."Source Type"::Enum then
                    ExpectedId := 1
                else
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
            if Rec."Source Type" = Rec."Source Type"::Enum then
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
        case Rec."Source Type" of
            Rec."Source Type"::Enum:
                begin
                    Rec.TestField("Source Enum ID", 0);
                    Rec.TestField("Enum ID");
                end;
            Rec."Source Type"::"EnumExtension":
                begin
                    Rec.TestField("Source Enum ID");
                    Rec.TestField("Enum ID");
                end;
        end;

        Rec.TestField("Ordinal ID");
        Rec.TestField("Enum Value");

        if Rec."Source Type" = Rec."Source Type"::"EnumExtension" then
            EXMExtMgt.ValidateExtensionRangeID(Rec."Extension Code", Rec."Enum ID");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignEnumID(SourceEnumID: Integer; EnumID: Integer; CustNo: Code[20]; var EnumValueID: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateEnumValueID(SourceEnumID: Integer; EnumID: Integer; CustNo: Code[20]; var EnumValueID: Integer; var IsHandled: Boolean)
    begin
    end;
}