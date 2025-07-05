pageextension 70502 "PstSalesInv" extends "Posted Sales Invoice"
{
    PromotedActionCategories = 'New,Process,Report,Invoice,Correct,Print/Send,Navigate,E-Invoice';
    layout
    {
        addafter("Work Description")
        {
            field("Cleared By ZATCA_DSSS"; Rec."Cleared By ZATCA_DSSS")
            {
                ApplicationArea = All;
                Editable = false;
                // Visible=false;
                //Visible = Zatcavisibility;
            }
            field("ZATCA Clearance Status_DSSS"; Rec."ZATCA Clearance Status_DSSS")
            {
                ApplicationArea = All;
                Editable = false;
                //Visible=false;
                //Visible = Zatcavisibility;

            }
            field("Pih Hash_DSSS"; Rec."Pih Hash_DSSS")
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
            field("ZATCA QR Code"; Rec."ZATCA QR Code")
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
    // local procedure ExportCustomerToXXML()
    // var
    //     TempBlob: Codeunit "Temp Blob";
    //     xmlDoc: XmlDocument;
    //     xmlDec: XmlDeclaration;
    //     InvElem: XmlElement;
    //     ProfileIdElem: XmlElement;
    //     OutStream: OutStream;
    //     InStream: InStream;
    //    // TempFile: File;
    //     fileName: Text;
    // begin
    //     xmlDoc := xmlDocument.Create();
    //     xmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
    //     xmlDoc.SetDeclaration(xmlDec);


    //     InvElem := xmlElement.Create('Invoice');

    //     ProfileIdElem := XmlElement.Create('cbc:ProfileID');
    //     ProfileIdElem.Add(xmlText.Create('reporting:1.0'));

    //     InvElem.Add(ProfileIdElem);

    //     xmlDoc.Add(InvElem);

    //     // Create an outStream from the Blob, notice the encoding.
    //     TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);

    //     // Write the contents of the doc to the stream
    //     xmlDoc.WriteTo(OutStream);

    //     // From the same Blob, that now contains the XML document, create an inStr
    //     TempBlob.CreateInStream(InStream, TextEncoding::UTF8);

    //     fileName := 'T-' + Format(CurrentDateTime);
    //     // Save the data of the InStream as a file.
    //     File.DownloadFromStream(InStream, 'Export', '', '', fileName);
    // end;

    // trigger OnOpenPage()
    // var
    // begin
    //     Clear(ShowEInvoicingPrints);

    //     if (CompanyName = 'First Axel Last BU 24/3/21') or (CompanyName = 'First Axles Trading Co.') then
    //         ShowEInvoicingPrints := true;
    // end;

    var
    // ShowEInvoicingPrints: Boolean;
}