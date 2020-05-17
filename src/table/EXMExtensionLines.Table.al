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
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
            OptionCaption = ',Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,,,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,,,,,,,,,,,,,,,,,,, "';
            InitValue = " ";

            trigger OnValidate()
            var
                EXMExtHeader: Record "EXM Extension Header";
            begin
                case "Object Type" of
                    "Object Type"::"PageExtension":
                        "Source Object Type" := "Source Object Type"::"Page";
                    "Object Type"::"TableExtension":
                        "Source Object Type" := "Source Object Type"::"Table";
                    "Object Type"::"EnumExtension":
                        "Source Object Type" := "Source Object Type"::"Enum";
                    "Object Type"::"ProfileExtension":
                        "Source Object Type" := "Source Object Type"::"Profile";
                    else
                        "Source Object Type" := "Source Object Type"::" "
                end;

                EXMExtHeader.Get("Extension Code");
                Validate("Object ID", SetObjectID("Object Type", EXMExtHeader."Customer No."))
            end;
        }
        field(4; "Object ID"; Integer)
        {
            Caption = 'Object ID', Comment = 'ESP="ID objeto"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
            NotBlank = true;
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
            OptionMembers = "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension",,,,,,,,,,,,,,,,,,," ";
            OptionCaption = ',Table,,,,,,,Page,,,,,,,,Enum,,Profile,,,,,,,,,,,,,,,,,,,, ', Comment = 'ESP=",Table,,,,,,,Page,,,,,,,,Enum,,Profile,,,,,,,,,,,,,,,,,,,, "';
            InitValue = " ";

            trigger OnValidate()
            var
                NotAllowedValueErr: Label 'Source value not allowed.', Comment = 'ESP="Valor no permitido"';
            begin
                case "Object Type" of
                    "Object Type"::"Page":
                        TestField("Object Type", "Object Type"::"PageExtension");
                    "Object Type"::"Table":
                        TestField("Object Type", "Object Type"::"TableExtension");
                    "Object Type"::"Enum":
                        TestField("Object Type", "Object Type"::"EnumExtension");
                    "Object Type"::"Profile":
                        TestField("Object Type", "Object Type"::"ProfileExtension");
                    else
                        Error(NotAllowedValueErr);
                end;
            end;
        }
        field(7; "Source Object ID"; Integer)
        {
            Caption = 'Source Object ID', Comment = 'ESP="ID objeto origen"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;

            trigger OnValidate()
            var
                AllProfile: Record "All Profile";
                AllObjects: Record AllObjWithCaption;
                ProfileNotFoundErr: Label 'Profile with %1 %2 not found.', Comment = 'ESP="Perfil con %1 %2 no encontrado."';
            begin
                if xRec."Source Object ID" <> "Source Object ID" then begin
                    if "Source Object Type" in ["Source Object Type"::Table, "Source Object Type"::Page, "Source Object Type"::Enum, "Source Object Type"::Profile] then
                        if "Object Type" = "Object Type"::"ProfileExtension" then begin
                            AllProfile.SetRange("Role Center ID", "Source Object ID");
                            if AllProfile.IsEmpty() then
                                Error(ProfileNotFoundErr, AllProfile.FieldCaption("Role Center ID"), "Source Object ID");
                        end else
                            AllObjects.Get("Source Object Type", "Source Object ID");

                    "Source Name" := GetObjectName("Source Object Type", "Source Object ID");
                end;
            end;

            trigger OnLookup()
            var
                AllProfile: Record "All Profile";
                AllObjects: Record AllObjWithCaption;
                ProfileList: Page "Profile List";
                AllObjList: Page "All Objects with Caption";
            begin
                case "Object Type" of
                    "Object Type"::"ProfileExtension":
                        begin
                            AllProfile.SetRange("Role Center ID", "Source Object ID");
                            if not AllProfile.IsEmpty() then begin
                                AllProfile.FindLast();
                                ProfileList.SetSelectionFilter(AllProfile);
                            end;

                            ProfileList.Editable(false);
                            ProfileList.LookupMode(true);
                            if ProfileList.RunModal() = Action::LookupOK then begin
                                ProfileList.GetRecord(AllProfile);
                                Validate("Source Object ID", AllProfile."Role Center ID");
                            end;

                        end;
                    "Object Type"::"TableExtension", "Object Type"::"PageExtension", "Object Type"::EnumExtension:
                        begin
                            if AllObjects.Get("Source Object Type", "Source Object ID") then
                                AllObjList.SetRecord(AllObjects);

                            AllObjects.FilterGroup(2);
                            AllObjects.SetRange("Object Type", "Source Object Type");
                            AllObjects.FilterGroup(0);
                            if AllObjects.FindSet() then
                                AllObjList.SetTableView(AllObjects);

                            AllObjList.Editable(false);
                            AllObjList.LookupMode(true);
                            if AllObjList.RunModal() = Action::LookupOK then begin
                                AllObjList.GetRecord(AllObjects);
                                Validate("Source Object ID", AllObjects."Object ID");
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
            Caption = 'Total fields', Comment = 'ESP="Campos relacionados"';
            DataClassification = OrganizationIdentifiableInformation;
            BlankZero = true;
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

    //#region Triggers
    trigger OnInsert()
    var
        EXMExtMgt: Codeunit "EXM Extension Management";
    begin
        "Created by" := CopyStr(UserId(), 1, MaxStrLen("Created by"));
        "Creation Date" := CurrentDateTime();

        TestField(Name);
        if "Object Type" in ["Object Type"::"TableExtension", "Object Type"::"PageExtension", "Object Type"::"EnumExtension", "Object Type"::"ProfileExtension"] then
            TestField("Source Object ID");

        EXMExtMgt.ValidateExtensionRangeID("Extension Code", "Object ID");
    end;

    trigger OnDelete()
    var
        EXMFields: Record "EXM Table Fields";
        EXMEnumValues: Record "EXM Enum Values";
    begin
        EXMFields.SetRange("Extension Code", "Extension Code");
        EXMFields.SetRange("Source Line No.", "Line No.");
        EXMFields.DeleteAll();

        EXMEnumValues.SetRange("Extension Code", "Extension Code");
        EXMEnumValues.SetRange("Source Line No.", "Line No.");
        EXMEnumValues.DeleteAll();
    end;
    //#endregion Triggers   

    //TODO Improvement - Look for empty ID
    local procedure SetObjectID(ObjectType: Integer; CustNo: Code[20]) ObjectID: Integer
    var
        EXMSetup: Record "EXM Extension Setup";
        EXMExtHeader: Record "EXM Extension Header";
        EXMExtLine: Record "EXM Extension Lines";
        EXMExtMgt: Codeunit "EXM Extension Management";
        IsHandled: Boolean;
    begin
        EXMSetup.Get();
        If EXMSetup."Disable Auto. Objects ID" then
            exit;

        IsHandled := false;
        OnBeforeCalculateObjectID(ObjectType, CustNo, ObjectID, IsHandled);
        if IsHandled then
            exit(ObjectID);

        EXMExtHeader.Get("Extension Code");
        EXMExtLine.SetCurrentKey("Extension Code", "Object Type", "Object ID");
        if CustNo <> '' then
            EXMExtLine.SetFilter("Extension Code", EXMExtMgt.GetCustomerExtensions(CustNo))
        else
            EXMExtLine.SetRange("Extension Code", "Extension Code");

        EXMExtLine.SetRange("Object Type", ObjectType);
        EXMExtLine.SetFilter("Object ID", '%1..%2', EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
        if EXMExtLine.FindLast() then
            ObjectID := EXMExtLine."Object ID" + 1
        else
            ObjectID := EXMExtHeader."Object Starting ID";

        exit(ObjectID)
    end;

    local procedure GetObjectName(ObjectType: Integer; ObjectID: Integer): Text[249]
    var
        AllObj: Record AllObjWithCaption;
        AllProfile: Record "All Profile";
        EXMExtSetup: Record "EXM Extension Setup";
    begin
        EXMExtSetup.Get();

        if ObjectType = 18 then begin
            AllProfile.SetRange("Role Center ID", ObjectID);
            if AllProfile.FindSet() then
                exit(AllProfile."Profile ID")
        end else
            if AllObj.Get(ObjectType, ObjectID) then
                case EXMExtSetup."Object Names" of
                    EXMExtSetup."Object Names"::Caption:
                        exit(AllObj."Object Caption");
                    EXMExtSetup."Object Names"::Name:
                        exit(AllObj."Object Name");
                end;
    end;

    procedure GetTotalFields(): Integer
    var
        EXMTableFields: Record "EXM Table Fields";
        EXMEnumValues: Record "EXM Enum Values";
    begin
        case "Object Type" of
            "Object Type"::"Table", "Object Type"::"TableExtension":
                begin
                    EXMTableFields.SetRange("Extension Code", "Extension Code");
                    EXMTableFields.SetRange("Source Line No.", "Line No.");
                    EXMTableFields.SetRange("Table Source Type", "Object Type");
                    EXMTableFields.SetRange("Table ID", "Object ID");
                    EXMTableFields.SetRange("Source Table ID", "Source Object ID");
                    exit(EXMTableFields.Count());
                end;

            "Object Type"::Enum, "Object Type"::EnumExtension:
                begin
                    EXMEnumValues.SetRange("Extension Code", "Extension Code");
                    EXMEnumValues.SetRange("Source Line No.", "Line No.");
                    EXMEnumValues.SetRange("Source Type", "Object Type");
                    EXMEnumValues.SetRange("Enum ID", "Object ID");
                    EXMEnumValues.SetRange("Source Enum ID", "Source Object ID");
                    exit(EXMEnumValues.Count());
                end;
            else
                exit(0);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalculateObjectID(ObjectType: Integer; CustNo: Code[20]; var ObjectID: Integer; var IsHandled: Boolean)
    begin
    end;
}