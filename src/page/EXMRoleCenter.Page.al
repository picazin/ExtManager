page 83207 "EXM Role Center"
{
    PageType = RoleCenter;
    Caption = 'EXtension Manager', Comment = 'ESP="Gestor Extensiones"';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "EXM Headline RC Ext. Manager")
            {
                ApplicationArea = All;
            }
            part(Activities; "EXM Extensions Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
                ApplicationArea = Basic, Suite;
            }
            part("Power BI Report Spinner Part"; "Power BI Report Spinner Part")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action("EXMExtensionCard")
            {
                RunPageMode = Create;
                Caption = 'New extension', Comment = 'ESP="Nueva extensión"';
                ToolTip = 'Create new extension', Comment = 'ESP="Crear nueva extensión"';
                Image = New;
                RunObject = Page "EXM Extension Header";
                ApplicationArea = Basic, Suite;
            }
        }
        area(Embedding)
        {
            action("EXMExtensionList")
            {
                Caption = 'Extensions', Comment = 'ESP="Extensiones"';
                ToolTip = 'View all extensions', Comment = 'ESP="Ver extensiones"';
                RunObject = Page "EXM Extension List";
                ApplicationArea = Basic, Suite;
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers', Comment = 'ESP="Clientes"';
                Image = Customer;
                RunObject = Page "Customer List";
            }
        }
        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup', Comment = 'ESP="Configuración"';
                ToolTip = 'Overview and change system and application settings', Comment = 'ESP="Modificar parámetros aplicación"';
                Image = Setup;

                action("EXMSetup")
                {
                    Caption = 'Setup EXM', Comment = 'ESP="Configuración EXM"';
                    ToolTip = 'Setup EXM', Comment = 'ESP="Configuración EXM"';
                    RunObject = Page "EXM Extension Manager Setup";
                    ApplicationArea = Basic, Suite;

                }
                action("Assisted Setup")
                {
                    Caption = 'Assisted Setup', Comment = 'ESP="Asistente de configuración"';
                    ToolTip = 'Setup EXM using an assisted wizard', Comment = 'ESP="Configurar mediante asistente"';
                    RunObject = Page "EXM Setup Wizard";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}