page 83207 "EXM Role Center"
{
    Caption = 'EXtension Manager', Comment = 'ESP="Gestor Extensiones"';
    PageType = RoleCenter;
    ApplicationArea = All;
    layout
    {
        area(RoleCenter)
        {
            part(Headline; "EXM Headline RC Ext. Manager")
            { }
            part(Activities; "EXM Extensions Activities")
            { }
            part("Report Inbox Part"; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = R;
            }
            systempart(Control1901377608; MyNotes)
            { }
        }
    }

    actions
    {
        area(Creation)
        {
            action(EXMExtensionCard)
            {
                Caption = 'New extension', Comment = 'ESP="Nueva extensión"';
                Image = New;
                RunObject = Page "EXM Extension Header";
                RunPageMode = Create;
                ToolTip = 'Create new extension', Comment = 'ESP="Crear nueva extensión"';
            }
            action(RelatedTables)
            {
                Caption = 'New table group', Comment = 'ESP="Nuevo grupo de tablas"';
                Image = New;
                RunObject = Page "EXM Related Data";
                RunPageMode = Create;
                ToolTip = 'Create new table group where fields will be replicated when one selected', Comment = 'ESP="Crear nuevo grupo de tablas donde replicar campos."';
            }
        }
        area(Embedding)
        {
            action(EXMExtensionList)
            {
                Caption = 'Extensions', Comment = 'ESP="Extensiones"';
                RunObject = Page "EXM Extension List";
                ToolTip = 'View all extensions', Comment = 'ESP="Ver extensiones"';
            }
            action(Customers)
            {
                Caption = 'Customers', Comment = 'ESP="Clientes"';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View customers list', Comment = 'ESP="Ver listado de clientes"';
            }
            action(TreeView)
            {
                Caption = 'Extensions Tree View', Comment = 'ESP="Vista arbol extensiones"';
                Image = Customer;
                RunObject = Page "EXM Extension TreeView";
                ToolTip = 'View all data from all extensions', Comment = 'ESP="Ver datos extensiones"';
            }
        }
        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup', Comment = 'ESP="Configuración"';
                Image = Setup;
                ToolTip = 'Overview and change system and application settings', Comment = 'ESP="Modificar parámetros aplicación"';

                action(EXMSetup)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Setup EXM', Comment = 'ESP="Configuración EXM"';
                    RunObject = Page "EXM Extension Manager Setup";
                    ToolTip = 'Setup EXM', Comment = 'ESP="Configuración EXM"';

                }
                action("Assisted Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup', Comment = 'ESP="Asistente de configuración"';
                    RunObject = Page "EXM Setup Wizard";
                    ToolTip = 'Setup EXM using an assisted wizard', Comment = 'ESP="Configurar mediante asistente"';
                }
                action("Related Table Fields")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Related Table Fields', Comment = 'ESP="Campos tablas relacionadas"';
                    RunObject = Page "EXM Related Data List";
                    ToolTip = 'Set tables to create same fields as selected one.', Comment = 'ESP="Definir tablas donde crear copias de campo seleccionado."';
                }
            }
        }
    }
}