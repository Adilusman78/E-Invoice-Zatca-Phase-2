page 70503 "Zatca Sales Credit Memo Info"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Header";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("E-Invoice Cleared By ZATCA"; Rec."E-Invoice Cleared By ZATCA")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Invoice Clearance Status"; Rec."E-Invoice Clearance Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("E-Invoice ZATCA Pih Hash"; Rec."E-Invoice ZATCA Pih Hash")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("ZATCA Invoice Response_DSSS"; ZATCAResponseTxt)
                {
                    Caption = 'Invoice Clearance Response';
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("E-Invoice ZATCA QR Code"; Rec."E-Invoice ZATCA QR Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    trigger OnOpenPage()
    begin
        ZATCAResponseTxt := Rec.GetZATCADescription();
    end;

    var
        ZATCAResponseTxt: Text;
}