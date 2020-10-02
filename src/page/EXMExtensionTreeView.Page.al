page 83215 "EXM Extension TreeView"
{
    PageType = List;
    Caption = 'EXM Extension TreeView';
    SourceTable = "EXM Extension Lines";
    SourceTableTemporary = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Content1)
            {
                IndentationColumn = Rec."Total Fields";
                IndentationControls = "Object Type";
                ShowAsTree = true;
                TreeInitialState = ExpandAll;

                field("Extension Code"; Rec."Extension Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }

                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }

                field("Source Object ID"; Rec."Source Object ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Source Object Type"; Rec."Source Object Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Total Fields"; Rec."Total Fields")
                {
                    ApplicationArea = All;
                    Caption = 'Level', Comment = 'ESP="Nivel"';
                    StyleExpr = StyleExp;
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        EXMExtHeader: Record "EXM Extension Header";
        EXMExtLine: Record "EXM Extension Lines";
        EXMFields: Record "EXM Table Fields";
        LineNo: Integer;
        ObjType: Integer;
    begin
        if ExtCode <> '' then
            EXMExtHeader.SetRange(Code, ExtCode)
        else begin
            EXMExtHeader.SetRange(Type, ExtType);
            if ViewCustNoExt <> '' then
                EXMExtHeader.SetRange("Customer No.", ViewCustNoExt);
        end;
        if EXMExtHeader.FindSet() then
            repeat
                ObjType := -1;

                Rec.Init();
                LineNo += 1;
                Rec."Line No." := LineNo;
                Rec."Extension Code" := EXMExtHeader.Code;
                Rec.Name := EXMExtHeader.Description;
                Rec."Total Fields" := 0;
                Rec."Object Type" := EXMExtLine."Object Type"::" ";
                Rec.Insert();

                EXMExtLine.SetCurrentKey("Extension Code", "Object Type");
                EXMExtLine.SetRange("Extension Code", EXMExtHeader.Code);
                if EXMExtLine.FindSet() then
                    repeat
                        if EXMExtLine."Object Type" <> ObjType then begin
                            Rec.Init();
                            LineNo += 1;
                            Rec."Line No." := LineNo;
                            Rec."Extension Code" := EXMExtLine."Extension Code";
                            Rec."Object Type" := EXMExtLine."Object Type";
                            Rec."Total Fields" := 1;
                            Rec.Insert();
                            ObjType := Rec."Object Type";
                        end;

                        LineNo += 1;

                        Rec.Init();
                        Rec := EXMExtLine;
                        Rec."Line No." := LineNo;
                        Rec."Total Fields" := 2;
                        Rec.Insert();

                        if EXMExtLine."Object Type" in [EXMExtLine."Object Type"::Table, EXMExtLine."Object Type"::"TableExtension"] then begin
                            EXMFields.SetRange("Extension Code", EXMExtHeader.Code);
                            EXMFields.SetRange("Source Line No.", EXMExtLine."Line No.");
                            if EXMFields.FindSet() then
                                repeat
                                    LineNo += 1;

                                    Rec.Init();
                                    Rec."Extension Code" := EXMExtLine."Extension Code";
                                    Rec."Object Type" := EXMExtLine."Object Type";
                                    Rec."Object ID" := EXMExtLine."Object ID";
                                    Rec."Source Object ID" := EXMFields."Field ID";
                                    Rec.Name := EXMFields."Field Name";
                                    Rec."Line No." := LineNo;
                                    Rec."Total Fields" := 3;
                                    Rec.Insert();
                                until EXMFields.Next() = 0;
                        end;
                    until EXMExtLine.Next() = 0;
            until EXMExtHeader.Next() = 0;

        Rec.SetCurrentKey("Extension Code", "Line No.");
        if Rec.FindFirst() then;
    end;

    trigger OnAfterGetRecord()
    begin
        StyleExp := 'standard';
        if Rec."Total Fields" = 0 then
            StyleExp := 'favorable';
        if Rec."Total Fields" = 1 then
            StyleExp := 'strong';
        if Rec."Total Fields" = 3 then
            StyleExp := 'standardaccent';
    end;

    internal procedure SetFilters(SetExtType: Integer; SetExtCode: Code[20]; SetCustNo: Code[20])
    begin
        ExtType := SetExtType;
        ExtCode := SetExtCode;
        ViewCustNoExt := SetCustNo;
    end;

    var
        StyleExp: Text;
        ExtCode: Code[20];
        ViewCustNoExt: Code[20];
        ExtType: Integer;
}