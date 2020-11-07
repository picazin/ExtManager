page 83215 "EXM Extension TreeView"
{
    Caption = 'EXM Extension TreeView';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "EXM Tree View";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Content1)
            {
                IndentationColumn = Rec."Indentation";
                IndentationControls = "Object Type";
                ShowAsTree = true;
                TreeInitialState = ExpandAll;

                field("Extension Code"; Rec."Extension Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Extension Code field', Comment = 'ESP="Especifica el valor del campo Cód. extensión"';
                }

                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto"';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Object ID field', Comment = 'ESP="Especifica el valor del campo ID objeto"';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
                }
                field("Field ID"; Rec."Field ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Id field', Comment = 'ESP="Especifica el valor del campo ID Campo"';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Name field', Comment = 'ESP="Especifica el valor del campo Nombre Campo"';
                }
                field("Field Data Type"; Rec."Field Data Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Field Data Type field', Comment = 'ESP="Especifica el valor del campo Tipo Dato Campo"';
                }
                field("Source Object ID"; Rec."Source Object ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Source Object ID field', Comment = 'ESP="Especifica el valor del campo ID objeto origen"';
                }
                field("Source Object Type"; Rec."Source Object Type")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Source Object Type field', Comment = 'ESP="Especifica el valor del campo Tipo objeto origen"';
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Name field', Comment = 'ESP="Especifica el valor del campo Nombre"';
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = All;
                    Caption = 'Level', Comment = 'ESP="Nivel"';
                    StyleExpr = StyleExp;
                    ToolTip = 'Specifies the value of the Level field', Comment = 'ESP="Especifica el valor del campo Nivel"';
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

                            ObjType := "Object Type";
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