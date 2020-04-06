codeunit 83201 "EXM Install Setup"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        EXMExtSetup: Record "EXM Extension Setup";
    begin
        if not EXMExtSetup.Get() then begin
            EXMExtSetup.Init();
            EXMExtSetup.Insert();
        end;
    end;
}