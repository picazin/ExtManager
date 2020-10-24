codeunit 83200 "EXM Extension Management"
{
    procedure AllowedObjectsID(ObjectID: Integer)
    var
        ObjectNotAllowedErr: Label 'Acording to Microsoft guides, current ID not allowed.Check guide:', Comment = 'ESP="ID no permitido según guias de Microsoft. Más información:"';
        URLLbl: Label 'https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-object-ranges';
        ErrTxt: Text;
    begin
        if not ((ObjectID >= 50000) and (ObjectID <= 999990)) then     //Customization range
            if not (ObjectID >= 1000000) and (ObjectID <= 69999999) then   //ISV solution range
                if not (ObjectID >= 70000000) and (ObjectID <= 74999999) then begin     //Partner cloud solution
                    ErrTxt := ObjectNotAllowedErr + '\' + URLLbl;
                    Error(ErrTxt);
                end;
    end;

    procedure ChechManualObjectID(ExtLine: Record "EXM Extension Lines")
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMExtLine: Record "EXM Extension Lines";
        ObjectIDErr: Label '%1 used on %2 extension.', comment = 'ESP="%1 usado en extensión %2"';
    begin
        EXMExtHeader.Get(ExtLine."Extension Code");
        EXMExtLine.SetCurrentKey("Extension Code", "Object Type", "Object ID");
        if EXMExtHeader."Customer No." <> '' then
            EXMExtLine.SetFilter("Extension Code", GetCustomerExtensions(EXMExtHeader."Customer No."))
        else
            EXMExtLine.SetFilter("Extension Code", GetInternalExtensions());

        EXMExtLine.SetRange("Object Type", ExtLine."Object Type");
        EXMExtLine.SetRange("Object ID", ExtLine."Object ID");
        if EXMExtLine.FindFirst() then
            Error(ObjectIDErr, ExtLine."Object ID", EXMExtLine."Extension Code");
    end;

    procedure CreateRelatedFields(ExtField: Record "EXM Table Fields")
    var
        ExtLine: Record "EXM Extension Lines";
        NewExtLine: Record "EXM Extension Lines";
        RelHeader: Record "EXM Related Groups";
        RelLines: Record "EXM Related Lines";
        NewExtField: Record "EXM Table Fields";
        RelData: Page "EXM Related Data List";
    begin
        ExtLine.Get(ExtField."Extension Code", ExtField."Source Line No.");
        GetAvailableRelData(ExtLine."Source Object ID", RelHeader);
        RelData.SetTableView(RelHeader);
        RelData.LookupMode(true);
        if RelData.RunModal() = Action::LookupOK then begin
            RelData.GetRecord(RelHeader);
            RelLines.SetRange(Code, RelHeader.Code);
            RelLines.SetFilter("Table ID", '<>%1', ExtLine."Source Object ID");
            if RelLines.FindSet() then
                repeat
                    Clear(NewExtLine);
                    NewExtLine.SetRange("Extension Code", ExtLine."Extension Code");
                    NewExtLine.SetRange("Object Type", NewExtLine."Object Type"::"TableExtension");
                    NewExtLine.SetRange("Source Object Type", NewExtLine."Source Object Type"::Table);
                    NewExtLine.SetRange("Source Object ID", RelLines."Table ID");
                    if not NewExtLine.FindSet() then begin
                        NewExtLine.Init();
                        NewExtLine."Extension Code" := ExtLine."Extension Code";
                        NewExtLine."Line No." := ExtLine.GetLineNo();
                        NewExtLine.Validate("Object Type", ExtLine."Object Type");
                        NewExtLine.Name := CopyStr(ExtLine."Extension Code" + ' ' + RelLines.Name, 1, MaxStrLen(NewExtLine.Name));
                        NewExtLine.Validate("Source Object Type", ExtLine."Source Object Type");
                        NewExtLine.Validate("Source Object ID", RelLines."Table ID");
                        NewExtLine.Insert(true);
                    end;

                    if not NewExtField.Get(ExtField."Extension Code", NewExtLine."Line No.", ExtField."Table Source Type", NewExtLine."Source Object ID", NewExtLine."Object ID", ExtField."Field ID") then begin
                        NewExtField.Init();
                        NewExtField := ExtField;
                        NewExtField."Source Line No." := NewExtLine."Line No.";
                        NewExtField."Source Table ID" := NewExtLine."Source Object ID";
                        NewExtField."Table ID" := NewExtLine."Object ID";
                        NewExtField.Insert(true);
                    end;
                until RelLines.Next() = 0;
        end;
    end;

    procedure GetCustomerExtensions(CustNo: Code[20]) ExtFilter: Text
    var
        EXMExtHeader: Record "EXM Extension Header";
    begin
        EXMExtHeader.SetCurrentKey(Type, "Customer No.", Code);
        EXMExtHeader.SetRange(Type, EXMExtHeader.Type::External);
        EXMExtHeader.SetRange("Customer No.", CustNo);
        if EXMExtHeader.FindSet() then
            repeat
                if ExtFilter = '' then
                    ExtFilter := EXMExtHeader.Code
                else
                    ExtFilter += '|' + EXMExtHeader.Code;
            until EXMExtHeader.Next() = 0;
    end;

    procedure GetEnumValues(EnumID: Integer)
    var
        TempEXMEnums: Record "EXM Enum Values" temporary;
        EnumRec: RecordRef;
        EnumRef: FieldRef;
        Counter: Integer;
        TotalValues: Integer;
    begin
        EnumRec.Open(EnumID);
        EnumRef := EnumRec.Field(1);
        TotalValues := (EnumRef.EnumValueCount());
        for Counter := 1 to TotalValues do begin
            TempEXMEnums.Init();
            TempEXMEnums."Extension Code" := Format(SessionId());
            TempEXMEnums."Source Line No." := Counter;
            TempEXMEnums."Source Type" := TempEXMEnums."Source Type"::Enum;
            TempEXMEnums."Enum ID" := EnumID;
            TempEXMEnums."Ordinal ID" := EnumRef.GetEnumValueOrdinal(Counter);
            TempEXMEnums."Enum Value" := CopyStr(EnumRef.GetEnumValueName(Counter), 1, MaxStrLen(TempEXMEnums."Enum Value"));
            TempEXMEnums.Insert();
        end;

        if not TempEXMEnums.IsEmpty() then begin
            TempEXMEnums.FindFirst();
            Page.Run(Page::"EXM Enum Values", TempEXMEnums);
        end;
    end;

    procedure GetInternalExtensions() ExtFilter: Text
    var
        EXMExtHeader: Record "EXM Extension Header";
    begin
        EXMExtHeader.SetCurrentKey(Type, Code);
        EXMExtHeader.SetRange(Type, EXMExtHeader.Type::Internal);
        if EXMExtHeader.FindSet() then
            repeat
                if ExtFilter = '' then
                    ExtFilter := EXMExtHeader.Code
                else
                    ExtFilter += '|' + EXMExtHeader.Code;
            until EXMExtHeader.Next() = 0;
    end;

    procedure GetObjectName(SourceObjectType: Integer; ObjectID: Integer): Text[249]
    var
        AllObj: Record AllObjWithCaption;
        AllProfile: Record "All Profile";
        EXMExtSetup: Record "EXM Extension Setup";
    begin
        EXMExtSetup.Get();

        if SourceObjectType = 18 then begin
            AllProfile.SetRange("Role Center ID", ObjectID);
            if AllProfile.FindFirst() then
                exit(AllProfile."Profile ID")
        end else
            if AllObj.Get(SourceObjectType, ObjectID) then
                case EXMExtSetup."Object Names" of
                    EXMExtSetup."Object Names"::Caption:
                        exit(AllObj."Object Caption");
                    EXMExtSetup."Object Names"::Name:
                        exit(AllObj."Object Name");
                end;
    end;

    procedure GetTableFieldData(TableNo: Integer)
    var
        TempEXMFields: Record "EXM Table Fields" temporary;
        FieldData: Record Field;
        intType: Integer;
    begin
        FieldData.SetRange(TableNo, TableNo);
        if FieldData.FindSet() then
            repeat
                TempEXMFields.Init();
                TempEXMFields."Extension Code" := Format(SessionId());
                TempEXMFields."Source Line No." := FieldData."No.";
                TempEXMFields."Table Source Type" := TempEXMFields."Table Source Type"::Table;
                TempEXMFields."Table ID" := TableNo;
                TempEXMFields."Field ID" := FieldData."No.";
                TempEXMFields."Field Name" := FieldData.FieldName;
                TempEXMFields."Field Caption" := FieldData."Field Caption";
                intType := FieldData.Type;
                TempEXMFields."Data Type" := intType;
                TempEXMFields.Lenght := FieldData.Len;
                TempEXMFields."Field Class" := FieldData.Class;
                TempEXMFields."Option String" := CopyStr(FieldData.OptionString, 1, MaxStrLen(TempEXMFields."Option String"));
                TempEXMFields.Obsolete := (FieldData.ObsoleteState <> FieldData.ObsoleteState::No);
                TempEXMFields.IsPK := FieldData.IsPartOfPrimaryKey;
                TempEXMFields.Insert();
            until FieldData.Next() = 0;

        if not TempEXMFields.IsEmpty() then begin
            TempEXMFields.FindFirst();
            Page.Run(Page::"EXM Table Field Detail", TempEXMFields);
        end;
    end;

    procedure ValidateExtensionRangeID(ExtCode: code[20]; ObjectID: Integer);
    var
        EXMExtHeader: Record "EXM Extension Header";
        IDRangeErr: Label 'ID must be on definid object range %1 - %2', Comment = 'ESP="ID debe estar dentro del rango definido %1 - %2"';
    begin
        EXMExtHeader.Get(ExtCode);
        if not ((ObjectID >= EXMExtHeader."Object Starting ID") and (ObjectID <= EXMExtHeader."Object Ending ID")) then
            Error(IDRangeErr, EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
    end;

    local procedure GetAvailableRelData(TableID: Integer; var RelHeader: Record "EXM Related Groups")
    var
        RelLines: Record "EXM Related Lines";
        DataFilter: Text;
    begin
        RelLines.SetRange("Table ID", TableID);
        if RelLines.FindSet() then
            repeat
                if DataFilter = '' then
                    DataFilter := RelLines.Code
                else
                    DataFilter += '|' + RelLines.Code
            until RelLines.Next() = 0;
        if DataFilter = '' then
            RelHeader.SetRange(Code, DataFilter)
        else
            RelHeader.SetFilter(Code, DataFilter);
    end;
}