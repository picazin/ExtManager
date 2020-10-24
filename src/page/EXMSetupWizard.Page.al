page 83212 "EXM Setup Wizard"
{
    Caption = 'Extension Manager assisted setup guide', Comment = 'ESP="Asistente configuración gestor extensiones"';
    ContextSensitiveHelpPage = 'README.md';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = NavigatePage;
    ShowFilter = false;
    SourceTable = "EXM Extension Setup";

    layout
    {
        area(content)
        {
            group(MediaStandard)
            {
                Caption = '';
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible;
                field(MediaRef; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the MediaResourcesStandard.Media Reference field';
                }
            }

            group(FirstPage)
            {
                Caption = '';
                Visible = FirstPageVisible;

                group(Welcome)
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
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Object Names', Comment = 'ESP="Nombre objetos" field';
                    }
                }
                group(NosSerie)
                {
                    Caption = 'Set Extensions Series Nos.', Comment = 'ESP="Definir numerador extensiones"';
                    InstructionalText = 'Define an Extension Series Nos. in order to assign default extension code when creating new extensions.', Comment = 'ESP="Defina un numerador para asignar automaticamente un código al generar una nueva extensión."';
                    Visible = SecondPageVisible;
                    field("Extension Nos."; "Extension Nos.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Extension Nos.', Comment = 'ESP="Nº série extensión" field';
                    }
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
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Default Starting Range', Comment = 'ESP="Indicar valor para campo Rango inicial por defecto"';
                    }
                    field("Default Object Ending ID"; "Default Object Ending ID")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Default Ending Range', Comment = 'ESP="Indicar valor para campo Rango final por defecto"';
                    }
                    field("Find Object ID Gaps"; "Find Object ID Gaps")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Always find for possible gaps between IDs.', comment = 'ESP="Buscar siempre huecos entre los ID."';
                    }

                }
                group(DisableIDSuggestions)
                {
                    Caption = 'Disable automatic IDs', Comment = 'ESP="Deshabilitar IDs automáticos"';
                    InstructionalText = 'Define if you want do disable automatic objects and fields ID. OPTION NOT RECOMMENDED.', Comment = 'ESP="Defina si quiere deshabilitar la asignación automática de ID para objetos y campos. OPCIÓN NO RECOMENDADA."';
                    Visible = ThirdPageVisible;
                    field("Disable Auto. Objects ID"; "Disable Auto. Objects ID")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Disable Auto Objects ID', Comment = 'ESP="Deshabilitar asignación ID objetos"';
                    }
                    field("Disable Auto. Field ID"; "Disable Auto. Field ID")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Disable Auto Field ID', Comment = 'ESP="Deshabilitar asignación ID campos"';
                    }
                }
            }

            group(FinalPage)
            {
                Caption = '';
                Visible = FinalPageVisible;

                group(ActivationDone)
                {
                    Caption = 'You''re done! Hope you enjoy this app!!', Comment = 'ESP="Hecho!! Espero que disfrute de esta aplicación!!"';
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
                Image = Check;
                InFooterBar = true;
                ToolTip = 'Thanks developer with an small tip.', Comment = 'ESP="Agradece al desarrollador con una propina."';
                Visible = FinalPageVisible;

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
                Image = PreviousRecord;
                InFooterBar = true;
                ToolTip = 'Go Back', Comment = 'ESP="Volver atrás"';
                Visible = BackEnabled;

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
                Image = NextRecord;
                InFooterBar = true;
                ToolTip = 'Move to next page', Comment = 'ESP="Ver siguiente página"';
                Visible = NextEnabled;

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
                ToolTip = 'Finish setup', Comment = 'ESP="Finalizar la configuración"';

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

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesStandard: Record "Media Resources";
        TopBannerVisible, FirstPageVisible, SecondPageVisible, ThirdPageVisible, FinalPageVisible, BackEnabled, NextEnabled : Boolean;
        Step: Option First,Second,Third,Finish;

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

    local procedure Finish();
    var
        EXMAssistedSetup: Codeunit "EXM Assisted Setup";
    begin
        EXMAssistedSetup.WizardComplete();
        CurrPage.Close();
    end;

    local procedure LoadTopBanners();
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType)) then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") then
                TopBannerVisible := MediaResourcesStandard."Media Reference".HasValue;
    end;

    local procedure NextStep(Backwards: Boolean);
    begin
        if Backwards then
            Step := Step - 1
        ELSE
            Step := Step + 1;
        EnableControls();
    end;

    local procedure ResetControls();
    begin
        BackEnabled := true;
        NextEnabled := true;
        FirstPageVisible := false;
        SecondPageVisible := false;
        ThirdPageVisible := false;
        FinalPageVisible := false;
    end;

    local procedure ShowFinalPage();
    begin
        FinalPageVisible := true;
        BackEnabled := true;
        NextEnabled := false;
    end;

    local procedure ShowFirstPage();
    begin
        FirstPageVisible := true;
        SecondPageVisible := false;
        ThirdPageVisible := false;
        BackEnabled := false;
        NextEnabled := true;
    end;

    local procedure ShowSecondPage();
    begin
        FirstPageVisible := false;
        SecondPageVisible := true;
        ThirdPageVisible := false;
        BackEnabled := true;
        NextEnabled := true;
    end;

    local procedure ShowThirdPage();
    begin
        FirstPageVisible := false;
        SecondPageVisible := false;
        ThirdPageVisible := true;
        BackEnabled := true;
        NextEnabled := true;
    end;
}

