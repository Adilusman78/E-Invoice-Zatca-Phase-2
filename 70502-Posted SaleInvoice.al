// pageextension 70502 "PstSalesInv" extends "Posted Sales Invoice"
// {
//     PromotedActionCategories = 'New,Process,Report,Invoice,Correct,Print/Send,Navigate,E-Invoice';
//     layout
//     {

//     }

//     actions
//     {
//         addafter(Print)
//         {
//             action("Arabic Invoice_DSSS")
//             {
//                 Caption = 'Print Invoice';
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Category8;
//                 Image = Print;
//                 trigger OnAction()
//                 var
//                     myInt: Integer;
//                 begin
//                     CurrPage.SetSelectionFilter(Rec);
//                     Report.Run(50500, true, false, Rec);
//                 end;
//             }

//             action("Export Invoice XML")
//             {
//                 Caption = 'Export Invoice XML';
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Category8;
//                 Image = Export;
//                 trigger OnAction()
//                 var
//                     TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
//                 begin
//                     // CurrPage.SetSelectionFilter(Rec);
//                     // TaxInvXmlPort.SetSources(Rec);
//                     // TaxInvXmlPort.Run();

//                     Message(CreateXmlDemo);
//                 end;
//             }
//         }
//     }
//     local procedure CreateXmlDemo(): Text
//     var
//         xmlElem2: XmlElement;
//         xmlElem3: XmlElement;
//         xmlElem: XmlElement;
//         xmlElem4: XmlElement;
//         XmlDoc: XmlDocument;
//         XmlDec: XmlDeclaration;
//         SignatureNode: XmlNode;
//         RootNode: XmlNode;
//         XmlResult: Text;
//         NanmeSp: XmlNamespaceManager;
//         ns1: Text[50];
//         prefix: Text[5];
//         localName: Text[10];
//         SignatureTxtBold: TextConst ENU = '<b>signature</b>';
//     begin
//         //Create the doc
//         xmlDoc := xmlDocument.Create();

//         //Add the declaration
//         xmlDec := xmlDeclaration.Create('1.0', 'utf-8', 'yes');
//         xmlDoc.SetDeclaration(xmlDec);

//         // //Create root node
//         // xmlElem := xmlElement.Create('DemoXMLFile');

//         // //Add some attributes to the root node
//         // xmlElem.SetAttribute('attribute1', 'value1');
//         // xmlElem.SetAttribute('attribute2', 'value2');

//         // //Add DataItems
//         // xmlElem2 := XmlElement.Create('DataItems');

//         // //Add a couple of DataItem 
//         // xmlElem3 := XmlElement.Create('DataItem');
//         // //Add text to the dataitem
//         // xmlElem3.Add(XmlText.Create('textvalue'));


//         // xmlElem4 := XmlElement.Create('Signature');

//         // xmlElem4.SetAttribute('xmlns' + 'ds', 'http://www.w3.org/2000/09/xmldsig#');
//         // XMLDomMgt.AddAttributeWithPrefix()

//         // NanmeSp.AddNamespace('ds', xmlElem4.NamespaceUri);

//         ns1 := 'http://www.w3.org/2000/09/xmldsig#';
//         // prefix := 'pf1';
//         // localName := 'foo';
//         // xmlElem4 := XmlElement.Create(prefix + localName);

//         // XMLDomMgt.AddNamespaceDeclaration(lHeaderXmlNode,'ds','http://example.com/ns1');
//         // XMLDomMgt.AddRootElementWithPrefix(pXmlDocument, 'Envelope', 'SOAP', SoapNS11, pEnvelopeXmlNode)

//         XMLDomMgt.AddRootElement(xmlDoc, 'Invoice', RootNode);
//         XMLDomMgt.AddElementWithPrefix(RootNode, 'signature', '', 'ds', 'http://www.w3.org/2000/09/xmldsig#', SignatureNode);
//         //XMLDomMgt.AddAttributeWithPrefix(RootNode, 'xmlns', '', 'cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2');
//         XMLDomMgt.AddAttribute(SignatureNode, 'Id', 'signature');
//         XMLDomMgt.AddAttribute(SignatureNode, 'xmlns', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2');



//         //  NanmeSp.AddNamespace('ds', prefix + localName);
//         // xmlElem4.AddFirst(xmlElem4.NamespaceUri);
//         // xmlElem4.SetAttribute('xmlns' + prefix, ns1);
//         // xmlElem4.Add(XmlAttribute.Create('xmlns', ns1));
//         // xmlElem4.Add(XmlAttribute.CreateNamespaceDeclaration('ds', xmlElem4.NamespaceUri));

//         // xmlElem4.Add(XmlText.Create(ns1));

//         // XElement el = new XElement(ns1 + localName, new XAttribute(XNamespace.Xmlns + prefix, ns1));
//         //Write elements to the doc

//         // xmlElem2.Add(xmlElem3);
//         // xmlElem2.Add(xmlElem4);
//         // xmlElem.Add(xmlElem2);

//         // xmlElem.Add(SignatureNode);
//         // XmlDoc.Add(xmlElem);
//         XmlDoc.WriteTo(XmlResult);

//         //   TempBlob.CreateInStream(inStr, TextEncoding::UTF8);

//         // File.DownloadFromStream(inStr, 'Export', '', '', 'TextXml');

//         exit(XmlResult);
//     end;

//     procedure ProductList(): Text
//     var
//         lXmlDocument: XmlDocument;
//         lEnvolopeXmlNode: XmlNode;
//         lHeaderXmlNode: XmlNode;
//         lBodyXmlNode: XmlNode;
//         lTempXmlNode: XmlNode;
//         lXMLText: Text;
//         ApiNameSpace: Label 'urn:Magento';
//     begin
//         CreateSoapDocument(lXmlDocument, 1, lEnvolopeXmlNode, lHeaderXmlNode, lBodyXmlNode);
//         XMLDomMgt.AddElement(lBodyXmlNode, 'signature', '', ApiNameSpace, lBodyXmlNode);

//         lXmlDocument.WriteTo(lXMLText);
//         exit(lXMLText);
//     end;

//     procedure CreateSoapDocument(var pXmlDocument: XmlDocument; pVersion: Option "1.1","1.2"; var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode; var pBodyXmlNode: XmlNode);
//     begin
//         CreateEnvelope(pXmlDocument, pEnvelopeXmlNode, pVersion);
//         CreateBody(pEnvelopeXmlNode, pBodyXmlNode, pVersion);
//     end;

//     //This function will create a Soap Envelope
//     procedure CreateEnvelope(var pXmlDocument: XmlDocument; var pEnvelopeXmlNode: XmlNode; pVersion: Option "1.1","1.2");
//     var
//         XmlDec: XmlDeclaration;
//     begin
//         pXmlDocument := XmlDocument.Create;
//         // XMLDomMgt.AddDeclaration(pXmlDocument, '1.0', 'UTF-8', 'no');//Soap
//         // XMLDomMgt.AddNamespaceDeclaration();
//         XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', 'no');
//         pXmlDocument.SetDeclaration(XmlDec);
//         XMLDomMgt.AddRootElementWithPrefix(pXmlDocument, 'Signature', 'ds', SoapNS11, pEnvelopeXmlNode);
//     end;

//     //This function will create a Soap Header
//     procedure CreateHeader(var pEnvelopeXmlNode: XmlNode; var pHeaderXmlNode: XmlNode; pVersion: Option "1.1","1.2");
//     begin
//         XMLDOMMgt.AddElement(pEnvelopeXmlNode, 'Header', '', SoapNS11, pHeaderXmlNode)
//     end;

//     //This function will create a Soap Body
//     procedure CreateBody(var pSoapEnvelope: XmlNode; var pSoapBody: XmlNode; pVersion: Option "1.1","1.2");
//     var
//         ApiNameSpace: Label 'urn:Magento';
//     begin
//         // XMLDOMMgt.AddElement(pSoapEnvelope, 'Body', '', SoapNS11, pSoapBody);
//         XMLDOMMgt.AddElement(pSoapEnvelope, 'Body', '', SoapNS11, pSoapBody);
//     end;

//     local procedure ExportCustomerToXXML()
//     var
//         xmlDoc: XmlDocument;
//         xmlDec: XmlDeclaration;
//         InvElem: XmlElement;
//         ProfileIdElem: XmlElement;
//         TempBlob: Codeunit "Temp Blob";
//         outStr: OutStream;
//         inStr: InStream;
//         TempFile: File;
//         fileName: Text;
//     begin
//         xmlDoc := xmlDocument.Create();
//         xmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
//         xmlDoc.SetDeclaration(xmlDec);


//         InvElem := xmlElement.Create('Invoice');

//         ProfileIdElem := XmlElement.Create('cbc:ProfileID');
//         ProfileIdElem.Add(xmlText.Create('reporting:1.0'));

//         InvElem.Add(ProfileIdElem);

//         xmlDoc.Add(InvElem);

//         // Create an outStream from the Blob, notice the encoding.
//         TempBlob.CreateOutStream(outStr, TextEncoding::UTF8);

//         // Write the contents of the doc to the stream
//         xmlDoc.WriteTo(outStr);

//         // From the same Blob, that now contains the XML document, create an inStr
//         TempBlob.CreateInStream(inStr, TextEncoding::UTF8);

//         fileName := 'T-' + Format(CurrentDateTime);
//         // Save the data of the InStream as a file.
//         File.DownloadFromStream(inStr, 'Export', '', '', fileName);
//     end;

//     // trigger OnOpenPage()
//     // var
//     // begin
//     //     Clear(ShowEInvoicingPrints);

//     //     if (CompanyName = 'First Axel Last BU 24/3/21') or (CompanyName = 'First Axles Trading Co.') then
//     //         ShowEInvoicingPrints := true;
//     // end;

//     var
//         XMLDomMgt: Codeunit "XML DOM Management";
//         SoapNS11: Label 'http://schemas.xmlsoap.org/soap/envelope/', Locked = true;
//         ShowEInvoicingPrints: Boolean;
// }