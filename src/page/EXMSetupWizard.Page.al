page 83212 "EXM Setup Wizard"
{
    PageType = NavigatePage;
    Caption = 'Extension Manager assisted setup guide', Comment = 'ESP="Asistente configuración gestor extensiones"';
    ContextSensitiveHelpPage = 'README.md';
    SourceTable = "EXM Extension Setup";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ShowFilter = false;

    layout
    {
        area(content)
        {
            group(MediaStandard)
            {
                Caption = '';
                Editable = false;
                Visible = TopBannerVisible;
                ShowCaption = false;
                field(MediaRef; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(FirstPage)
            {
                Caption = '';
                Visible = FirstPageVisible;

                group("Welcome")
                {
                    Caption = 'Welcome to Extension Manager Setup', Comment = 'ESP="Bienvenido a la configuración de EXM Gestor Extensiones"';
                    Visible = FirstPageVisible;

                    group(Introduction)
                    {
                        Caption = '';
                        InstructionalText = 'We''ll need to ask you for a few things in order to get a proper user experience. Don''t worry, it won''t take long.', Comment = 'ESP="Debemos preguntarle algunas cosas para empezar a trabajar. No sé preocupe, será rápido!"';
                        Visible = FirstPageVisible;
                    }

                    group("Let's go!")
                    {
                        Caption = 'Let''s go!', Comment = 'ESP="Vamos!!"';
                        InstructionalText = 'Choose Next so you can specify Extension Manager information.', Comment = 'ESP="Pulse Siguiente para configurar el gestor de extensiones."';
                    }
                }
            }

            group(SecondPage)
            {
                ShowCaption = false;
                Visible = SecondPageVisible;

                group(ObjectNames)
                {
                    Caption = 'Object and Fields names', Comment = 'ESP="Nombres de objetos y campos"';
                    InstructionalText = 'When retriving data from Business Central how would you like to see objects and fields names?', Comment = 'ESP="Al recuperar datos de Business Central, ¿cómo le gustaría ver los nombres de objetos y campos?"';
                    Visible = SecondPageVisible;

                    field("Object Names"; "Object Names")
                    { ApplicationArea = All; }
                }
                group(NosSerie)
                {
                    Caption = 'Set Extensions Series Nos.', Comment = 'ESP="Definir numerador extensiones"';
                    InstructionalText = 'Define an Extension Series Nos. in order to assign default extension code when creating new extensions.', Comment = 'ESP="Defina un numerador para asignar automaticamente un código al generar una nueva extensión."';
                    Visible = SecondPageVisible;
                    field("Extension Nos."; "Extension Nos.")
                    { ApplicationArea = All; }
                }
            }

            group(ThirdPage)
            {
                ShowCaption = false;
                Visible = ThirdPageVisible;
                group(ObjectRange)
                {
                    Caption = 'Set Objects Default IDs', Comment = 'ESP="Definir IDs objetos por defecto"';
                    InstructionalText = 'Define starting and ending default object IDs for extensions. You can change them in every extension.', Comment = 'ESP="Defina IDs iniciales y finales por defecto en las extensiones. Se pueden modificar en cada extensión."';
                    Visible = ThirdPageVisible;
                    field("Default Object Starting ID"; "Default Object Starting ID")
                    { ApplicationArea = All; }
                    field("Default Object Ending ID"; "Default Object Ending ID")
                    { ApplicationArea = All; }
                }
                group(DisableIDSuggestions)
                {
                    Caption = 'Disable automatic IDs', Comment = 'ESP="Deshabilitar IDs automáticos"';
                    InstructionalText = 'Define if you want do disable automatic objects and fields ID. OPTION NOT RECOMMENDED.', Comment = 'ESP="Defina si quiere deshabilitar la asignación automática de ID para objetos y campos. OPCIÓN NO RECOMENDADA."';
                    Visible = ThirdPageVisible;
                    field("Disable Auto. Objects ID"; "Disable Auto. Objects ID")
                    { ApplicationArea = All; }
                    field("Disable Auto. Field ID"; "Disable Auto. Field ID")
                    { ApplicationArea = All; }
                }
            }

            group(FinalPage)
            {
                Caption = '';
                Visible = FinalPageVisible;

                group("ActivationDone")
                {
                    Caption = 'You''re done! Hope you enjoy this app!!', Comment = 'ESP="Hecho!! Espero que disfute de esta aplicación!!"';
                    Visible = FinalPageVisible;

                    group(DoneMessage)
                    {
                        Caption = '';
                        InstructionalText = 'Click Finish to start managing your extensions.', Comment = 'ESP="Pulse Finalizar para empezar a gestionar sus extensiones."';
                        Visible = FinalPageVisible;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Donate)
            {
                ApplicationArea = All;
                Caption = 'Donate', Comment = 'ESP="Donar"';
                Enabled = FinalPageVisible;
                Visible = FinalPageVisible;
                Image = Check;
                InFooterBar = true;

                trigger OnAction();
                var
                    DonateQst: Label 'If you are enjoying this extension and want to thank me for my work, please donate.', Comment = 'ESP="Si te ha resultado útil esta extensión y quieres agradecer mi trabajo, por favor, haz un donativo!!"';
                begin
                    if Confirm(DonateQst, true) then
                        Hyperlink('https://paypal.me/picazin');
                end;
            }
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back', Comment = 'ESP="Atrás"';
                Enabled = BackEnabled;
                Visible = BackEnabled;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction();
                begin
                    NextStep(true);
                end;
            }

            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next', Comment = 'ESP="Siguiente"';
                Enabled = NextEnabled;
                Visible = NextEnabled;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction();
                begin
                    NextStep(false);
                end;
            }

            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish', Comment = 'ESP="Finalizar"';
                Enabled = FinalPageVisible;
                Image = Approve;
                InFooterBar = true;

                trigger OnAction();
                begin
                    Finish();
                end;
            }
        }
    }

    trigger OnInit();
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage();
    begin
        Step := Step::First;
        EnableControls();
    end;

    local procedure EnableControls();
    begin
        ResetControls();

        case Step of
            Step::First:
                ShowFirstPage();

            Step::Second:
                ShowSecondPage();

            Step::Third:
                ShowThirdPage();

            Step::Finish:
                ShowFinalPage();
        end;
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;
        EnableControls();
    end;

    local procedure Finish();
    var
        EXMAssistedSetup: Codeunit "EXM Assisted Setup";
    begin
        EXMAssistedSetup.WizardComplete();
        CurrPage.Close();
    end;

    local procedure ShowFirstPage();
    begin
        FirstPageVisible := true;
        SecondPageVisible := false;
        ThirdPageVisible := false;
        FinishEnabled := false;
        BackEnabled := false;
        NextEnabled := true;
        DonateEnable := false;
    end;

    local procedure ShowSecondPage();
    begin
        FirstPageVisible := false;
        SecondPageVisible := true;
        ThirdPageVisible := false;
        FinishEnabled := false;
        BackEnabled := true;
        NextEnabled := true;
        DonateEnable := false;
    end;

    local procedure ShowThirdPage();
    begin
        FirstPageVisible := false;
        SecondPageVisible := false;
        ThirdPageVisible := true;
        FinishEnabled := true;
        BackEnabled := true;
        NextEnabled := true;
        DonateEnable := false;
    end;

    local procedure ShowFinalPage();
    begin
        FinalPageVisible := true;
        BackEnabled := true;
        NextEnabled := false;
        DonateEnable := true;
    end;

    local procedure ResetControls();
    begin
        FinishEnabled := true;
        BackEnabled := true;
        NextEnabled := true;
        FirstPageVisible := false;
        SecondPageVisible := false;
        ThirdPageVisible := false;
        FinalPageVisible := false;
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType)) then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") then
                TopBannerVisible := MediaResourcesStandard."Media Reference".HasValue;
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option First,Second,Third,Finish;
        TopBannerVisible: Boolean;
        FirstPageVisible: Boolean;
        SecondPageVisible: Boolean;
        ThirdPageVisible: Boolean;
        FinalPageVisible: Boolean;
        FinishEnabled: Boolean;
        BackEnabled: Boolean;
        NextEnabled: Boolean;
        DonateEnable: Boolean;
}

