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

            // action("Export Invoice XML")
            // {
            //     Caption = 'Export Credit Memo XML';
            //     ApplicationArea = all;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Category8;
            //     ToolTip = 'Export Credit Memo XML';
            //     Image = Export;
            //     trigger OnAction()
            //     var
            //         TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
            //         CreateXML: Codeunit CreateXMLDemo_DSSS;
            //     begin
            //         CreateXML.CreateXmlDemo1(Rec);
            //         // CurrPage.SetSelectionFilter(Rec);
            //         // TaxInvXmlPort.SetSources(Rec);
            //         // TaxInvXmlPort.Run();

            //     end;
            // }
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