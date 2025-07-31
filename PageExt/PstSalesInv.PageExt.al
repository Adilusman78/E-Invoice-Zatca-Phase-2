pageextension 70502 "PstSalesInv" extends "Posted Sales Invoice"
{
    PromotedActionCategories = 'New,Process,Report,Invoice,Correct,Print/Send,Navigate,E-Invoice';
    layout
    {
        addafter("Work Description")
        {
            field("Cleared By ZATCA_DSSS"; Rec."E-Invoice Cleared By ZATCA")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible=false;
                //Visible = Zatcavisibility;
            }
            field("ZATCA Clearance Status_DSSS"; Rec."E-Invoice ZATCA Clearance Status")
            {
                ApplicationArea = All;
                Editable = false;
                //Visible=false;
                //Visible = Zatcavisibility;

            }
            field("Pih Hash_DSSS"; Rec."E-Invoice Pih Hash")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("ZATCA Invoice Response_DSSS"; Rec.GetZATCADescription())
            {
                Caption = 'Invoice Clearance Response';
                ApplicationArea = All;
                Editable = false;
                MultiLine = true;
                // Visible=false;
                //Visible = Zatcavisibility;

            }
            field("ZATCA QR Code"; Rec."E-Invoice ZATCA QR Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(Print)
        {
            action("Arabic Invoice_DSSS")
            {
                Caption = 'Print Invoice';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                ToolTip = 'Print Invoice';
                Image = Print;
                trigger OnAction()

                begin
                    CurrPage.SetSelectionFilter(Rec);
                    Report.Run(70500, true, false, Rec);
                end;
            }

            action("Export Invoice XML")
            {
                Caption = 'Export Invoice XML';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                PromotedCategory = Category8;
                ToolTip = 'Export Invoice XML';
                Image = Export;
                trigger OnAction()
                var
                    TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
                    CreateXML: Codeunit CreateXMLDemo_DSSS;
                begin
                    CreateXML.CreateXmlDemo(rec);
                    // CurrPage.SetSelectionFilter(Rec);
                    // TaxInvXmlPort.SetSources(Rec);
                    // TaxInvXmlPort.Run();

                end;
            }
        }
    }


    var
    // ShowEInvoicingPrints: Boolean;
}