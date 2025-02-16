page 83215 "EXM Extension TreeView"
{
    Caption = 'EXM Extension TreeView';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "EXM Tree View";
    SourceTableTemporary = true;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Content1)
            {
                IndentationColumn = Rec."Indentation";
                IndentationControls = "Type Description";
                ShowAsTree = true;
                TreeInitialState = ExpandAll;

                field("Extension Code"; Rec."Extension Code")
                {
                    StyleExpr = StyleExp;
                }
                field("Type Description"; Rec."Type Description")
                {
                    StyleExpr = StyleExp;
                }
                field("Object ID"; Rec."Object ID")
                {
                    StyleExpr = StyleExp;
                }
                field("Object Name"; Rec."Object Name")
                {
                    StyleExpr = StyleExp;
                }
                field("Field ID"; Rec."Field ID")
                {
                    StyleExpr = StyleExp;
                }
                field("Field Name"; Rec."Field Name")
                {
                    StyleExpr = StyleExp;
                }
                field("Field Data Type"; Rec."Field Data Type")
                {
                    StyleExpr = StyleExp;
                }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    StyleExpr = StyleExp;
                }
                field("Source Object Type"; Rec."Source Object Type")
                {
                    StyleExpr = StyleExp;
                }
                field("Source Name"; Rec."Source Name")
                {
                    StyleExpr = StyleExp;
                }
                field(Indentation; Rec.Indentation)
                {
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
        FieldLbl: Label 'Field', comment = 'ESP="Campo"';
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

                //Extension Header
                LineNo += 1;

                Rec.Init();
                Rec."Line No." := LineNo;
                Rec.Indentation := 0;
                Rec."Extension Code" := EXMExtHeader.Code;
                Rec."Object Name" := EXMExtHeader.Description;
                Rec."Object Type" := EXMExtLine."Object Type"::" ";
                Rec.Insert();

                EXMExtLine.SetCurrentKey("Extension Code", "Object Type");
                EXMExtLine.SetRange("Extension Code", EXMExtHeader.Code);
                if EXMExtLine.FindSet() then
                    repeat
                        //Extension object type header
                        if EXMExtLine."Object Type" <> ObjType then begin
                            LineNo += 1;

                            Rec.Init();
                            Rec."Line No." := LineNo;
                            Rec.Indentation := 1;
                            Rec."Extension Code" := EXMExtLine."Extension Code";
                            Rec."Object Type" := EXMExtLine."Object Type";
                            Rec.Insert();

                            ObjType := Rec."Object Type";
                        end;

                        LineNo += 1;

                        //Extension objects
                        Rec.Init();
                        Rec."Line No." := LineNo;
                        Rec.Indentation := 2;
                        Rec."Extension Code" := EXMExtLine."Extension Code";
                        Rec."Object Type" := EXMExtLine."Object Type";
                        Rec."Object ID" := EXMExtLine."Object ID";
                        Rec."Object Name" := EXMExtLine.Name;
                        Rec."Source Object Type" := EXMExtLine."Source Object Type";
                        Rec."Source Object ID" := EXMExtLine."Source Object ID";
                        Rec."Source Name" := EXMExtLine."Source Name";
                        Rec."Type Description" := Format(EXMExtLine."Object Type");
                        Rec.Insert();

                        if EXMExtLine."Object Type" in [EXMExtLine."Object Type"::Table, EXMExtLine."Object Type"::"TableExtension"] then begin
                            EXMFields.SetRange("Extension Code", EXMExtHeader.Code);
                            EXMFields.SetRange("Source Line No.", EXMExtLine."Line No.");
                            if EXMFields.FindSet() then
                                repeat
                                    LineNo += 1;

                                    //Extension fields
                                    Rec.Init();
                                    Rec."Line No." := LineNo;
                                    Rec.Indentation := 3;

                                    Rec."Extension Code" := EXMExtLine."Extension Code";
                                    Rec."Object Type" := EXMExtLine."Object Type";
                                    Rec."Object ID" := EXMExtLine."Object ID";
                                    Rec."Object Name" := EXMExtLine.Name;

                                    Rec."Field ID" := EXMFields."Field ID";
                                    Rec."Field Name" := EXMFields."Field Name";
                                    if EXMFields.Lenght <> 0 then
                                        Rec."Field Data Type" := Format(EXMFields."Data Type") + '[' + Format(EXMFields.Lenght) + ']'
                                    else
                                        Rec."Field Data Type" := Format(EXMFields."Data Type");

                                    Rec."Source Object Type" := EXMExtLine."Source Object Type";
                                    Rec."Source Object ID" := EXMExtLine."Source Object ID";
                                    Rec."Source Name" := EXMExtLine."Source Name";
                                    Rec."Type Description" := FieldLbl;
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
        if Rec.Indentation = 0 then
            StyleExp := 'favorable';
        if Rec.Indentation = 1 then
            StyleExp := 'strong';
        if Rec.Indentation = 3 then
            StyleExp := 'standardaccent';
    end;

    var
        ExtCode: Code[20];
        ViewCustNoExt: Code[20];
        ExtType: Integer;
        StyleExp: Text;

    internal procedure SetFilters(SetExtType: Integer; SetExtCode: Code[20]; SetCustNo: Code[20])
    begin
        ExtType := SetExtType;
        ExtCode := SetExtCode;
        ViewCustNoExt := SetCustNo;
    end;
}