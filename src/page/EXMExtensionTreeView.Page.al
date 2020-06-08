page 83215 "EXM Extension TreeView"
{

    ApplicationArea = All;
    Caption = 'EXM Extension TreeView';
    PageType = List;
    SourceTable = "EXM Extension Lines";
    UsageCategory = Lists;
    SourceTableTemporary = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = "Total Fields";
                IndentationControls = "Object Type";
                ShowAsTree = true;
                TreeInitialState = ExpandAll;

                field("Extension Code"; "Extension Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }

                field("Object Type"; "Object Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }

                field("Source Object ID"; "Source Object ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Source Object Type"; "Source Object Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Source Name"; "Source Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                }
                field("Total Fields"; "Total Fields")
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

                Init();
                LineNo += 1;
                "Line No." := LineNo;
                "Extension Code" := EXMExtHeader.Code;
                Name := EXMExtHeader.Description;
                "Total Fields" := 0;
                "Object Type" := EXMExtLine."Object Type"::" ";
                Insert();

                EXMExtLine.SetCurrentKey("Extension Code", "Object Type");
                EXMExtLine.SetRange("Extension Code", EXMExtHeader.Code);
                if EXMExtLine.FindSet() then
                    repeat
                        if EXMExtLine."Object Type" <> ObjType then begin
                            Init();
                            LineNo += 1;
                            "Line No." := LineNo;
                            "Extension Code" := EXMExtLine."Extension Code";
                            "Object Type" := EXMExtLine."Object Type";
                            "Total Fields" := 1;
                            Insert();
                            ObjType := "Object Type";
                        end;

                        LineNo += 1;

                        Init();
                        Rec := EXMExtLine;
                        "Line No." := LineNo;
                        "Total Fields" := 2;
                        Insert();

                        if EXMExtLine."Object Type" in [EXMExtLine."Object Type"::Table, EXMExtLine."Object Type"::"TableExtension"] then begin
                            EXMFields.SetRange("Extension Code", EXMExtHeader.Code);
                            EXMFields.SetRange("Source Line No.", EXMExtLine."Line No.");
                            if EXMFields.FindSet() then
                                repeat
                                    LineNo += 1;

                                    Init();
                                    "Extension Code" := EXMExtLine."Extension Code";
                                    "Object Type" := EXMExtLine."Object Type";
                                    "Object ID" := EXMExtLine."Object ID";
                                    "Source Object ID" := EXMFields."Field ID";
                                    Name := EXMFields."Field Name";
                                    "Line No." := LineNo;
                                    "Total Fields" := 3;
                                    Insert();
                                until EXMFields.Next() = 0;
                        end;
                    until EXMExtLine.Next() = 0;
            until EXMExtHeader.Next() = 0;

        SetCurrentKey("Extension Code", "Line No.");
        if FindFirst() then;
    end;

    trigger OnAfterGetRecord()
    begin
        StyleExp := 'standard';
        if "Total Fields" = 0 then
            StyleExp := 'favorable';
        if "Total Fields" = 1 then
            StyleExp := 'strong';
        if "Total Fields" = 3 then
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