codeunit 83203 "EXM Assisted Setup"
{
    var
        AssistedSetup: Codeunit "Assisted Setup";

    procedure WizardComplete()
    begin
        AssistedSetup.Complete(Page::"EXM Setup Wizard");
    end;

    local procedure GetAppId(): Guid
    var
        EmptyGuid: Guid;
        Info: ModuleInfo;
    begin
        if Info.Id() = EmptyGuid then
            NavApp.GetCurrentModuleInfo(Info);
        exit(Info.Id());
    end;

    local procedure GetInformationSetupStatus()
    begin
        AssistedSetup.IsComplete(Page::"EXM Setup Wizard");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnReRunOfCompletedSetup', '', false, false)]
    local procedure OnReRunOfCompletedSetup(ExtensionId: Guid; PageID: Integer; var Handled: Boolean)
    var
        AlreadySetUpQst: Label 'Setup is already set up. To change settings for it, go to the setup again. Do you want go there now ?', Comment = 'ESP="La configuración se ha realizado. Desea ejecutar nuevamente?"';
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Assisted Setup", 'OnRegister', '', false, false)]
    local procedure SetupInitialize()
    var
        Language: Codeunit Language;
        AssistedSetupGroup: Enum "Assisted Setup Group";
        VideoCategory: Enum "Video Category";
        CurrentGlobalLanguage: Integer;
        InitialEXMSetupDescTxt: Label 'EXM need some amazing information from you to make everything works fine!', Comment = 'ESP="EXM necesita pedirte información para funcionar correctamente, Será rápido!!"';
        SetupWizardLinkTxt: Label 'https://www.picazin.dev', Locked = true;
        SetupWizardTxt: Label 'Set up Extension Manager', Comment = 'ESP="Configurar Gestor Extensiones"';
    begin
        CurrentGlobalLanguage := GlobalLanguage();
        AssistedSetup.Add(GetAppId(), Page::"EXM Setup Wizard", SetupWizardTxt, AssistedSetupGroup::Extensions, '', VideoCategory::Extensions, SetupWizardLinkTxt, InitialEXMSetupDescTxt);
        GlobalLanguage(Language.GetDefaultApplicationLanguageId());

        AssistedSetup.AddTranslation(Page::"EXM Setup Wizard", Language.GetDefaultApplicationLanguageId(), SetupWizardTxt);
        GlobalLanguage(CurrentGlobalLanguage);
        GetInformationSetupStatus();
    end;
}