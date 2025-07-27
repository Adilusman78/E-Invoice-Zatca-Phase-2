pageextension 70505 "PstSalesCreditmemo" extends "Posted Sales Credit Memo"
{
    PromotedActionCategories = 'New,Process,Report,Invoice,Correct,Print/Send,Navigate,E-Invoice';
    layout
    {

    }

    actions
    {
        addafter(Print)
        {
            action("Arabic Invoice_DSSS")
            {
                Caption = 'Print Credit Memo';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                ToolTip = 'Print Credit Memo';
                Image = Print;
                trigger OnAction()

                begin
                    CurrPage.SetSelectionFilter(Rec);
                    Report.Run(50501, true, false, Rec);
                end;
            }
        }
    }
   

    var
    // ShowEInvoicingPrints: Boolean;
}