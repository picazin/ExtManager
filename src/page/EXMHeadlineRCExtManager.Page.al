page 83208 "EXM Headline RC Ext. Manager"
{
    Caption = 'EXM Extension Manager', Comment = 'ESP="EXM Gestor Extensiones"';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                Visible = UserGreetingVisible;
                field(GreetingText; RCHeadlinesPageCommon.GetGreetingText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Greeting headline', Comment = 'ESP="Bienvenida!"';
                    Editable = false;
                    ToolTip = 'Welcome message. If pressed go to picazin.dev website', Comment = 'ESP="Mensaje de bienvenida. Visitar picazin.dev si pulsamos."';
                }
            }
            group(Control2)
            {
                ShowCaption = false;
                Visible = DefaultFieldsVisible;
                field(DocumentationText; RCHeadlinesPageCommon.GetDocumentationText())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Documentation headline', Comment = 'ESP="Documentación"';
                    DrillDown = true;
                    Editable = false;
                    ToolTip = 'View documentation', Comment = 'ESP="Ver documentación"';

                    trigger OnDrillDown()
                    begin
                        HyperLink(RCHeadlinesPageCommon.DocumentationUrlTxt());
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Order Processor");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
    end;

    var
        RCHeadlinesPageCommon: Codeunit "EXM RC Headlines Page Common";
        [InDataSet]
        DefaultFieldsVisible: Boolean;
        [InDataSet]
        UserGreetingVisible: Boolean;
}