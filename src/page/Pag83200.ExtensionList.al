page 83200 "Extension List"
{
    Caption = 'Extensions', Comment = 'ESP="Extensiones"';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Extension Header";
    Editable = false;
    CardPageId = "Extension Header";
    RefreshOnActivate = true;
    DataCaptionFields = Description;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; "Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }
                field("Type"; "Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}