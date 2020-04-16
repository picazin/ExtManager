page 83202 "EXM Extension Lines"
{
    Caption = ' Objects', Comment = 'ESP="Objetos"';
    PageType = ListPart;
    SourceTable = "EXM Extension Lines";
    SourceTableView = sorting("Extension Code", "Object Type", "Object ID", "Source Object Type", "Source Object ID");
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                }
                field("Name"; "Name")
                {
                    ApplicationArea = All;
                }
                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                    Editable = ("Source Object Type" <> "Source Object Type"::" ");
                }
                field("Source Name"; "Source Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Fields"; "Total Fields")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    var
                        EXMExtTableFields: Record "EXM Extension Table Fields";
                        EXMEnumValues: Record "EXM Enum Values";
                        EXMFieldList: Page "EXM Field List";
                        EXMEnumVal: Page "EXM Enum Values";
                    begin
                        case "Object Type" of
                            "Object Type"::"Table", "Object Type"::"TableExtension":
                                begin
                                    EXMExtTableFields.SetRange("Extension Code", "Extension Code");
                                    EXMExtTableFields.SetRange("Source Line No.", "Line No.");
                                    EXMExtTableFields.SetRange("Table Source Type", "Object Type");
                                    EXMExtTableFields.SetRange("Table ID", "Object ID");
                                    EXMExtTableFields.SetRange("Source Table ID", "Source Object ID");

                                    EXMFieldList.SetTableView(EXMExtTableFields);
                                    EXMFieldList.LookupMode := true;
                                    if EXMFieldList.RunModal() = Action::LookupOK then
                                        CurrPage.Update(true);
                                end;

                            "Object Type"::Enum, "Object Type"::EnumExtension:
                                begin
                                    EXMEnumValues.SetRange("Extension Code", "Extension Code");
                                    EXMEnumValues.SetRange("Source Line No.", "Line No.");
                                    EXMEnumValues.SetRange("Source Type", "Object Type");
                                    EXMEnumValues.SetRange("Enum ID", "Object ID");
                                    EXMEnumValues.SetRange("Source Enum ID", "Source Object ID");

                                    EXMEnumVal.SetTableView(EXMEnumValues);
                                    EXMEnumVal.LookupMode := true;
                                    if EXMEnumVal.RunModal() = Action::LookupOK then
                                        CurrPage.Update(true);
                                end;
                            else
                                exit;
                        end;
                    end;
                }
                field(Obsolete; Obsolete)
                {
                    ApplicationArea = All;
                }
                field("Created by"; "Created by")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ViewField)
            {
                Caption = 'Fields', Comment = 'ESP="Campos"';
                ApplicationArea = All;
                Image = ViewPage;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = Page "EXM Field List";
                RunPageLink = "Extension Code" = field("Extension Code"), "Source Line No." = field("Line No."), "Table Source Type" = field("Object Type"), "Table ID" = field("Object ID"), "Source Table ID" = field("Source Object ID");
            }
        }
    }
}