pageextension 70506 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control1900201301)
        {
            group("ZATCA")
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


    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Export Order XML")
            {
                Caption = 'Export Order XML';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Export Order XML';
                Visible = false;
                Image = Export;
                trigger OnAction()
                var
                    TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
                    CreateXML: Codeunit CreateXMLOfSalesOrder;
                begin
                    CreateXML.CreateXmlDemoOfSalesOrder(Rec);
                end;
            }
            action("Send XML - ZATCA")
            {
                Caption = 'Send Invoice - ZATCA';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Send XML - ZATCA';
                Image = Export;
                trigger OnAction()
                var
                    TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
                    CreateXML: Codeunit CreateXMLOfSalesOrder;
                begin
                    if Confirm('Do you want to send Invoice XML to ZATCA for clearance?', false) then begin
                        CreateXML.CreateXmlDemoOfSalesOrder(Rec);
                        ZATCAResponseTxt := Rec.GetZATCADescription();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        ZATCAResponseTxt := Rec.GetZATCADescription();
    end;

    var
        ZATCAResponseTxt: Text;

}