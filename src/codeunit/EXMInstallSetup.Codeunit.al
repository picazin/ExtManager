codeunit 83201 "EXM Install Setup"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        EXMExtSetup: Record "EXM Extension Setup";
        ExtHeader: Record "EXM Extension Header";
    begin
        if not EXMExtSetup.Get() then begin
            EXMExtSetup.Init();
            EXMExtSetup.Insert();
        end;

        if CheckUpdateCustomerNoData() then begin
            ExtHeader.SetRange(Type, ExtHeader.Type::External);
            if ExtHeader.FindSet() then
                repeat
                    SetCustomerData(ExtHeader);
                until ExtHeader.Next() = 0;
        end;
    end;

    local procedure CheckUpdateCustomerNoData(): Boolean
    begin
        //"version": "0.2.9.0" set customer no. to lines. Must update data if installed version is lower version
        Exit((GetInstallingVersionNo() >= '0.2.9.0') and (GetCurrentlyInstalledVersionNo() < '0.2.9.0'));
    end;

    procedure GetInstallingVersionNo(): Text
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        exit(Format(AppInfo.AppVersion()));
    end;

    procedure GetCurrentlyInstalledVersionNo(): Text
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        exit(Format(AppInfo.DataVersion()));
    end;

    local procedure SetCustomerData(ExtHeader: Record "EXM Extension Header")
    var
        ExtLine: Record "EXM Extension Lines";
        ExtField: Record "EXM Table Fields";
        ExtEnum: Record "EXM Enum Values";
    begin
        ExtLine.SetRange("Extension Code", ExtHeader.Code);
        ExtLine.ModifyAll("Customer No.", ExtHeader."Customer No.");

        ExtField.SetRange("Extension Code", ExtHeader.Code);
        ExtField.ModifyAll("Customer No.", ExtHeader."Customer No.");

        ExtEnum.SetRange("Extension Code", ExtHeader.Code);
        ExtEnum.ModifyAll("Customer No.", ExtHeader."Customer No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnCompanyInitialize', '', false, false)]
    local procedure CompanyInitialize()
    begin

    end;
}