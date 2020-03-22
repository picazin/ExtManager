codeunit 83200 "EXM Extension Management"
{

    procedure AllowedObjectsID(ObjectID: Integer)
    var
        ObjectNotAllowedErr: Label 'Acording to Microsoft guides, current ID not allowed.Check guide:', Comment = 'ESP="ID no permitido según guias de Microsoft. Más información:"';
        URLLbl: Label 'https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-object-ranges';
    begin
        if not ((ObjectID >= 50000) and (ObjectID <= 999990)) then     //Customization range
            if not (ObjectID >= 1000000) and (ObjectID <= 69999999) then   //ISV solution range
                if not (ObjectID >= 70000000) and (ObjectID <= 74999999) then   //Partner cloud solution
                    Error(ObjectNotAllowedErr + '\' + URLLbl);
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
}