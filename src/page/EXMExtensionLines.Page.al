page 83202 "EXM Extension Lines"
{
    AutoSplitKey = true;
    Caption = ' Objects', Comment = 'ESP="Objetos"';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "EXM Extension Lines";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                FreezeColumn = Name;
                field("Object Type"; Rec."Object Type")
                { }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        EXMExtMgt: Codeunit "EXM Extension Management";
                    begin
                        if (xRec."Object ID" <> Rec."Object ID") then
                            EXMExtMgt.ChechManualObjectID(Rec);
                    end;
                }
                field(Name; Rec."Name")
                { }
                field("Source Object Type"; Rec."Source Object Type")
                {
                    Editable = false;
                }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    Editable = (Rec."Source Object Type" = Rec."Source Object Type"::Table) or (Rec."Source Object Type" = Rec."Source Object Type"::Page) or (Rec."Source Object Type" = Rec."Source Object Type"::Enum) or (Rec."Source Object Type" = Rec."Source Object Type"::Profile) or (Rec."Source Object Type" = Rec."Source Object Type"::Report);
                }
                field("Source Name"; Rec."Source Name")
                {
                    Editable = false;
                }
                field("Total Fields"; Rec."Total Fields")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        ViewRelatedFields();
                    end;
                }
                field(Obsolete; Rec.Obsolete)
                { }
                field("Created by"; Rec."Created by")
                { }
                field("Creation Date"; Rec."Creation Date")
                { }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ViewField)
            {
                ApplicationArea = All;
                Caption = 'View detail', Comment = 'ESP="Ver detalle"';
                Image = ViewPage;
                ToolTip = 'View object detail.', Comment = 'ESP="Ver detalle objeto."';

                trigger OnAction()
                begin
                    ViewRelatedFields();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec."Total Fields" := Rec.GetTotalFields();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Validate("Object Type", xRec."Object Type");
    end;

    local procedure ViewRelatedFields()
    var
        EXMEnumValues: Record "EXM Enum Values";
        EXMTableFields: Record "EXM Table Fields";
        EXMEnumVal: Page "EXM Enum Values";
        EXMFieldList: Page "EXM Field List";
    begin
        case Rec."Object Type" of
            Rec."Object Type"::"Table", Rec."Object Type"::"TableExtension":
                begin
                    CurrPage.SaveRecord();
                    Commit();

                    if (Rec."Object Type" = Rec."Object Type"::Table) and (Rec."Source Object ID" = 0) then begin
                        EXMTableFields.SetRange("Extension Code", Rec."Extension Code");
                        EXMTableFields.SetRange("Source Line No.", Rec."Line No.");
                        EXMTableFields.SetRange("Table Source Type", Rec."Object Type");
                        EXMTableFields.SetRange("Table ID", Rec."Object ID");
                        EXMTableFields.SetRange("Source Table ID", Rec."Source Object ID");
                        if EXMTableFields.IsEmpty() then begin
                            EXMTableFields.Init();
                            EXMTableFields."Extension Code" := Rec."Extension Code";
                            EXMTableFields."Source Line No." := Rec."Line No.";
                            EXMTableFields."Table Source Type" := Rec."Object Type";
                            EXMTableFields."Table ID" := Rec."Object ID";
                            EXMTableFields."Source Table ID" := Rec."Source Object ID";
                            EXMTableFields."Field ID" := 1;
                            EXMTableFields.IsPK := true;
                            EXMTableFields."Created by" := CopyStr(UserId(), 1, MaxStrLen(EXMTableFields."Created by"));
                            EXMTableFields."Creation Date" := CurrentDateTime();
                            EXMTableFields.Insert();
                            Commit();
                        end;
                    end;

                    EXMTableFields.SetRange("Extension Code", Rec."Extension Code");
                    EXMTableFields.SetRange("Source Line No.", Rec."Line No.");
                    EXMTableFields.SetRange("Table Source Type", Rec."Object Type");
                    EXMTableFields.SetRange("Table ID", Rec."Object ID");
                    EXMTableFields.SetRange("Source Table ID", Rec."Source Object ID");
                    EXMFieldList.SetTableView(EXMTableFields);

                    EXMFieldList.Editable(true);
                    EXMFieldList.RunModal();
                end;

            Rec."Object Type"::Enum, Rec."Object Type"::EnumExtension:
                begin
                    CurrPage.SaveRecord();
                    Commit();

                    EXMEnumValues.SetRange("Extension Code", Rec."Extension Code");
                    EXMEnumValues.SetRange("Source Line No.", Rec."Line No.");
                    EXMEnumValues.SetRange("Source Type", Rec."Object Type");
                    EXMEnumValues.SetRange("Enum ID", Rec."Object ID");
                    EXMEnumValues.SetRange("Source Enum ID", Rec."Source Object ID");

                    EXMEnumVal.SetTableView(EXMEnumValues);
                    EXMEnumVal.RunModal();
                end;
            else
                exit;
        end;
    end;
}