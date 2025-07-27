pageextension 70506 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control1900201301)
        {
            group("E-Invoice")
            {
                field("E-Invoice Cleared By ZATCA"; Rec."E-Invoice Cleared By ZATCA")
                {
                    ApplicationArea = All;
                    Editable = false;
                }


            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("E-Invoice Order Information")
            {
                Caption = 'E-Invoice Order Information';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'E-Invoice Order Information';
                Image = Info;
                RunObject = page "Zatca Sales Order Info";
                RunPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
            }
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
                Caption = 'E-Invoice Send - ZATCA';
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