table 83202 "EXM Extension Lines"
{
    Caption = 'Extension Objects', Comment = 'ESP="Objetos extensión"';
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
                Rec."Customer No." := ExtHeader."Customer No.";
            end;
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

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                case Rec."Object Type" of
                    Rec."Object Type"::"PageExtension":
                        Rec."Source Object Type" := Rec."Source Object Type"::"Page";
                    Rec."Object Type"::"TableExtension":
                        Rec."Source Object Type" := Rec."Source Object Type"::"Table";
                    Rec."Object Type"::"EnumExtension":
                        Rec."Source Object Type" := Rec."Source Object Type"::"Enum";
                    Rec."Object Type"::"ProfileExtension":
                        Rec."Source Object Type" := Rec."Source Object Type"::"Profile";
                    Rec."Object Type"::"ReportExtension":
                        Rec."Source Object Type" := Rec."Source Object Type"::"Report";
                    else
                        Rec."Source Object Type" := Rec."Source Object Type"::" "
                end;

                EXMExtHeader.Get(Rec."Extension Code");
                Rec.Validate("Object ID", SetObjectID(Rec."Object Type", EXMExtHeader."Customer No."));
            end;
        }
        field(4; "Object ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Object ID', Comment = 'ESP="ID objeto"';
            DataClassification = OrganizationIdentifiableInformation;
            NotBlank = true;

            trigger OnValidate()
            begin
                if (xRec."Object ID" <> Rec."Object ID") then
                    UpdateRelated()
            end;
        }
        field(5; Name; Text[250])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(6; "Source Object Type"; Option)
        {
            Caption = 'Source Object Type', Comment = 'ESP="Tipo objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            InitValue = " ";
            OptionCaption = ',Table,,Report,,,,,Page,,,,,,,,Enum,,Profile,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,Report,,,,,Page,,,,,,,,Enum,,Profile,,,,,,,,,,,,,,,,,,,, "';
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","ReportExtension",,,,,,,,,,,,,,,,,," ";

            trigger OnValidate()
            var
                NotAllowedValueErr: Label 'Source value not allowed.', Comment = 'ESP="Valor no permitido"';
            begin
                case Rec."Source Object Type" of
                    Rec."Source Object Type"::"Page":
                        Rec.TestField("Object Type", Rec."Object Type"::"PageExtension");
                    Rec."Source Object Type"::"Table":
                        Rec.TestField("Object Type", Rec."Object Type"::"TableExtension");
                    Rec."Source Object Type"::"Enum":
                        Rec.TestField("Object Type", Rec."Object Type"::"EnumExtension");
                    Rec."Source Object Type"::"Profile":
                        Rec.TestField("Object Type", Rec."Object Type"::"ProfileExtension");
                    Rec."Source Object Type"::"Report":
                        Rec.TestField("Object Type", Rec."Object Type"::"ReportExtension");
                    else
                        Error(NotAllowedValueErr);
                end;
            end;
        }
        field(7; "Source Object ID"; Integer)
        {
            BlankZero = true;
            Caption = 'Source Object ID', Comment = 'ESP="ID objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;

            trigger OnValidate()
            var
                AllObjects: Record AllObjWithCaption;
                AllProfile: Record "All Profile";
                ExtMngt: Codeunit "EXM Extension Management";
                ProfileNotFoundErr: Label 'Profile with %1 %2 not found.', Comment = 'ESP="Perfil con %1 %2 no encontrado."';
            begin
                if xRec."Source Object ID" <> Rec."Source Object ID" then begin
                    if Rec."Source Object Type" in [Rec."Source Object Type"::Table, Rec."Source Object Type"::Page, Rec."Source Object Type"::Enum, Rec."Source Object Type"::Profile, Rec."Source Object Type"::Report] then
                        if Rec."Object Type" = Rec."Object Type"::"ProfileExtension" then begin
                            AllProfile.SetRange("Role Center ID", Rec."Source Object ID");
                            if AllProfile.IsEmpty() then
                                Error(ProfileNotFoundErr, AllProfile.FieldCaption("Role Center ID"), Rec."Source Object ID");
                        end else
                            AllObjects.Get(Rec."Source Object Type", Rec."Source Object ID");

                    Rec."Source Name" := ExtMngt.GetObjectName(Rec."Source Object Type", Rec."Source Object ID");

                    if (xRec."Source Object ID" <> Rec."Source Object ID") then
                        UpdateRelated();
                end;
            end;

            trigger OnLookup()
            var
                AllObjects: Record AllObjWithCaption;
                AllProfile: Record "All Profile";
                AllObjList: Page "All Objects with Caption";
                ProfileList: Page "Profile List";
            begin
                case Rec."Object Type" of
                    Rec."Object Type"::"ProfileExtension":
                        begin
                            AllProfile.SetRange("Role Center ID", Rec."Source Object ID");
                            if not AllProfile.IsEmpty() then begin
                                AllProfile.FindLast();
                                ProfileList.SetSelectionFilter(AllProfile);
                            end;

                            ProfileList.Editable(false);
                            ProfileList.LookupMode(true);
                            if ProfileList.RunModal() = Action::LookupOK then begin
                                ProfileList.GetRecord(AllProfile);
                                Rec.Validate("Source Object ID", AllProfile."Role Center ID");
                            end;

                        end;
                    Rec."Object Type"::"TableExtension", Rec."Object Type"::"PageExtension", Rec."Object Type"::"EnumExtension", Rec."Object Type"::"ReportExtension":
                        begin
                            if AllObjects.Get(Rec."Source Object Type", Rec."Source Object ID") then
                                AllObjList.SetRecord(AllObjects);

                            AllObjects.FilterGroup(2);
                            AllObjects.SetRange("Object Type", Rec."Source Object Type");
                            AllObjects.FilterGroup(0);
                            if AllObjects.FindSet() then
                                AllObjList.SetTableView(AllObjects);

                            AllObjList.Editable(false);
                            AllObjList.LookupMode(true);
                            if AllObjList.RunModal() = Action::LookupOK then begin
                                AllObjList.GetRecord(AllObjects);
                                Rec.Validate("Source Object ID", AllObjects."Object ID");
                            end;
                        end;
                    else
                        exit;
                end;
            end;
        }
        field(8; "Source Name"; Text[250])
        {
            Caption = 'Name', Comment = 'ESP="Nombre"';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(10; "Total Fields"; Integer)
        {
            BlankZero = true;
            Caption = 'Total fields', Comment = 'ESP="Campos relacionados"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(11; Obsolete; Boolean)
        {
            Caption = 'Obsolete', Comment = 'ESP="Obsoleto"';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(12; "Created by"; Code[50])
        {
            Caption = 'Created by', Comment = 'ESP="Creado por"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(13; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', Comment = 'ESP="Fecha creación"';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
        }
        field(14; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº Cliente"';
            DataClassification = OrganizationIdentifiableInformation;
            TableRelation = Customer;
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
        key(K4; "Customer No.", "Object Type", "Object ID")
        { }
    }

    //#region Triggers
    trigger OnInsert()
    var
        EXMExtMgt: Codeunit "EXM Extension Management";
    begin
        Rec."Created by" := CopyStr(UserId(), 1, MaxStrLen("Created by"));
        Rec."Creation Date" := CurrentDateTime();

        Rec.TestField(Name);
        if Rec."Object Type" in [Rec."Object Type"::"TableExtension", Rec."Object Type"::"PageExtension", Rec."Object Type"::"EnumExtension", Rec."Object Type"::"ProfileExtension", Rec."Object Type"::"ReportExtension"] then
            Rec.TestField("Source Object ID");

        EXMExtMgt.ValidateExtensionRangeID(Rec."Extension Code", Rec."Object ID");
    end;

    trigger OnDelete()
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMFields: Record "EXM Table Fields";
    begin
        EXMFields.SetRange("Extension Code", Rec."Extension Code");
        EXMFields.SetRange("Source Line No.", Rec."Line No.");
        EXMFields.DeleteAll();

        EXMEnumValues.SetRange("Extension Code", Rec."Extension Code");
        EXMEnumValues.SetRange("Source Line No.", Rec."Line No.");
        EXMEnumValues.DeleteAll();
    end;

    procedure GetLineNo(): Integer
    var
        ExtLine: Record "EXM Extension Lines";
    begin
        ExtLine.SetRange("Extension Code", Rec."Extension Code");
        if ExtLine.FindLast() then
            exit(ExtLine."Line No." + 10000);
        exit(10000);
    end;

    procedure GetTotalFields(): Integer
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMTableFields: Record "EXM Table Fields";
    begin
        case Rec."Object Type" of
            Rec."Object Type"::"Table", Rec."Object Type"::"TableExtension":
                begin
                    EXMTableFields.SetRange("Extension Code", Rec."Extension Code");
                    EXMTableFields.SetRange("Source Line No.", Rec."Line No.");
                    EXMTableFields.SetRange("Table Source Type", Rec."Object Type");
                    EXMTableFields.SetRange("Table ID", Rec."Object ID");
                    EXMTableFields.SetRange("Source Table ID", Rec."Source Object ID");
                    exit(EXMTableFields.Count());
                end;

            Rec."Object Type"::"Enum", Rec."Object Type"::"EnumExtension":
                begin
                    EXMEnumValues.SetRange("Extension Code", Rec."Extension Code");
                    EXMEnumValues.SetRange("Source Line No.", Rec."Line No.");
                    EXMEnumValues.SetRange("Source Type", Rec."Object Type");
                    EXMEnumValues.SetRange("Enum ID", Rec."Object ID");
                    EXMEnumValues.SetRange("Source Enum ID", Rec."Source Object ID");
                    exit(EXMEnumValues.Count());
                end;
            else
                exit(0);
        end;
    end;

    procedure SetObjectID(ObjectType: Integer; CustNo: Code[20]) ObjectID: Integer
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMExtLine: Record "EXM Extension Lines";
        EXMSetup: Record "EXM Extension Setup";
        IsHandled: Boolean;
        ExpectedId: Integer;
        ObjectIdErr: Label 'Next object ID (%1) is bigger than extension ending id (%2).', comment = 'ESP="Propuesta ID objeto (%1) es superior al id final de la extensión (%2)."';
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Objects ID" then
            exit;

        EXMExtHeader.Get(Rec."Extension Code");
        if EXMExtHeader."Object Ending ID" = 0 then
            exit;

        IsHandled := false;
        OnBeforeCalculateObjectID(ObjectType, CustNo, ObjectID, IsHandled);
        if IsHandled then
            exit(ObjectID);

        EXMExtLine.SetCurrentKey("Customer No.", "Object Type", "Object ID");
        EXMExtLine.SetRange("Customer No.", CustNo);
        EXMExtLine.SetRange("Object Type", ObjectType);
        EXMExtLine.SetFilter("Object ID", '%1..%2', EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
        if not EXMExtLine.IsEmpty() then begin
            if EXMSetup."Find Object ID Gaps" then begin
                EXMExtLine.FindSet();
                ExpectedId := EXMExtHeader."Object Starting ID";
                repeat
                    if ExpectedId <> EXMExtLine."Object ID" then
                        exit(ExpectedId)
                    else
                        ExpectedId += 1;
                until EXMExtLine.Next() = 0;
                ObjectID := ExpectedId;
            end else begin
                EXMExtLine.FindLast();
                ObjectID := EXMExtLine."Object ID" + 1;
            end;
        end else
            ObjectID := EXMExtHeader."Object Starting ID";

        OnAfterAssignObjectID(ObjectType, CustNo, ObjectID);

        if ObjectID > EXMExtHeader."Object Ending ID" then
            Error(ObjectIdErr, ObjectID, EXMExtHeader."Object Ending ID");

        exit(ObjectID)
    end;
    //#endregion Triggers

    local procedure UpdateRelated()
    var
        EnumValues: Record "EXM Enum Values";
        NewEnumValues: Record "EXM Enum Values";
        NewTableFields: Record "EXM Table Fields";
        TableFields: Record "EXM Table Fields";
    begin
        case Rec."Object Type" of
            Rec."Object Type"::"Table", Rec."Object Type"::"TableExtension":
                begin
                    TableFields.SetRange("Extension Code", Rec."Extension Code");
                    TableFields.SetRange("Source Line No.", Rec."Line No.");
                    TableFields.SetRange("Table Source Type", xRec."Object Type");
                    TableFields.SetRange("Source Table ID", xRec."Source Object ID");
                    TableFields.SetRange("Table ID", xRec."Object ID");
                    if TableFields.FindSet() then
                        repeat
                            NewTableFields.Init();
                            NewTableFields := TableFields;
                            NewTableFields."Table Source Type" := Rec."Object Type";
                            NewTableFields."Source Table ID" := Rec."Source Object ID";
                            NewTableFields."Table ID" := Rec."Object ID";
                            NewTableFields.Insert();
                            TableFields.Delete();
                        until TableFields.Next() = 0;
                end;

            Rec."Object Type"::"Enum", Rec."Object Type"::"EnumExtension":
                begin
                    EnumValues.SetRange("Extension Code", Rec."Extension Code");
                    EnumValues.SetRange("Source Line No.", Rec."Line No.");
                    EnumValues.SetRange("Source Type", xRec."Object Type");
                    EnumValues.SetRange("Source Enum ID", xRec."Object ID");
                    EnumValues.SetRange("Enum ID", xRec."Object ID");
                    if EnumValues.FindSet() then
                        repeat
                            NewEnumValues.Init();
                            NewEnumValues := EnumValues;
                            NewEnumValues."Source Type" := Rec."Object Type";
                            NewEnumValues."Source Enum ID" := Rec."Source Object ID";
                            NewEnumValues."Enum ID" := Rec."Object ID";
                            NewEnumValues.Insert();
                            EnumValues.Delete();
                        until EnumValues.Next() = 0;
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignObjectID(ObjectType: Integer; CustNo: Code[20]; var ObjectID: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateObjectID(ObjectType: Integer; CustNo: Code[20]; var ObjectID: Integer; var IsHandled: Boolean)
    begin
    end;
}