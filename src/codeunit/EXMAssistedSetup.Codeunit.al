codeunit 83203 "EXM Assisted Setup"
{

    var
        AssistedSetup: Codeunit "Assisted Setup";
        AssistedSetupGroup: Enum "Assisted Setup Group";
        CurrentGlobalLanguage: Integer;
        SetupWizardTxt: Label 'Set up Extension Manager', Comment = 'ESP="Configurar Gestor Extensiones"';
        SetupWizardLinkTxt: Label 'https://www.picazin.dev', Locked = true;
        AlreadySetUpQst: Label 'Setup is already set up. To change settings for it, go to the setup again. Do you want go there now ?', Comment = 'ESP="La configuración se ha realizado. Desea ejecutar nuevamente?"';


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', false, false)]
    local procedure SetupInitialize()
    begin
        CurrentGlobalLanguage := GlobalLanguage();
        AssistedSetup.Add(GetAppId(), Page::"EXM Setup Wizard", SetupWizardTxt, AssistedSetupGroup::Extensions, '', SetupWizardLinkTxt);
        GlobalLanguage(1033);
        AssistedSetup.AddTranslation(Page::"EXM Setup Wizard", 1033, SetupWizardTxt);
        GlobalLanguage(CurrentGlobalLanguage);
        GetInformationSetupStatus();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnReRunOfCompletedSetup', '', false, false)]
    local procedure OnReRunOfCompletedSetup(ExtensionId: Guid; PageID: Integer; var Handled: Boolean)
    begin
        if ExtensionId <> GetAppId() then
            exit;

        case PageID of
            Page::"Assisted Company Setup Wizard":
                begin
                    if Confirm(AlreadySetUpQst, true) then
                        Page.Run(Page::"EXM Setup Wizard");
                    Handled := true;
                end;
        end;
    end;

    local procedure GetAppId(): Guid
    var
        Info: ModuleInfo;
        EmptyGuid: Guid;
    begin
        if Info.Id() = EmptyGuid then
            NavApp.GetCurrentModuleInfo(Info);
        exit(Info.Id());
    end;

    procedure WizardComplete()
    begin
        AssistedSetup.Complete(Page::"EXM Setup Wizard");
    end;

    local procedure GetInformationSetupStatus()
    begin
        AssistedSetup.IsComplete(Page::"EXM Setup Wizard");
    end;
}