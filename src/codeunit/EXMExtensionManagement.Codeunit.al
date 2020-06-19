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

    procedure ValidateExtensionRangeID(ExtCode: code[20]; ObjectID: Integer);
    var
        EXMExtHeader: Record "EXM Extension Header";
        IDRangeErr: Label 'ID must be on definid object range %1 - %2', Comment = 'ESP="ID debe estar dentro del rango definido %1 - %2"';
    begin
        EXMExtHeader.Get(ExtCode);
        if not ((ObjectID >= EXMExtHeader."Object Starting ID") and (ObjectID <= EXMExtHeader."Object Ending ID")) then
            Error(IDRangeErr, EXMExtHeader."Object Starting ID", EXMExtHeader."Object Ending ID");
    end;

    procedure GetCustomerExtensions(CustNo: Code[20]) ExtFilter: Text
    var
        EXMExtHeader: Record "EXM Extension Header";
    begin
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

    procedure GetTableFieldData(TableNo: Integer)
    var
        FieldData: Record Field;
        TempEXMFields: Record "EXM Table Fields" temporary;
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

    procedure GetEnumValues(EnumID: Integer)
    var
        TempEXMEnums: Record "EXM Enum Values" temporary;
        EnumRec: RecordRef;
        EnumRef: FieldRef;
        TotalValues: Integer;
        Counter: Integer;
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
}