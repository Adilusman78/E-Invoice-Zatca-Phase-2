codeunit 70503 CreateXMLOfSalesOrder
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
        comapnyinfo_lRec: Record "Company Information";
    begin
        SalesHeader.CalcFields("E-Invoice ZATCA Response");
        if comapnyinfo_lRec.Get() then
            if comapnyinfo_lRec."E-Invoice Zatca Function" = true then begin
                if SalesHeader."E-Invoice Clearance Status" <> 'CLEARED' then
                    Error('Please Submit Document to Zatca');
            end;
        SalesInvHeader."E-Invoice ZATCA Invoice Response" := SalesHeader."E-Invoice ZATCA Response";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', true, true)]
    local procedure OnBeforeSalesCrMemoLineInsert(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SalesHeader: Record "Sales Header")
    var
        comapnyinfo_lRec: Record "Company Information";

    begin
        SalesHeader.CalcFields("E-Invoice ZATCA Response");
        if comapnyinfo_lRec.Get() then
            if comapnyinfo_lRec."E-Invoice Zatca Function" = true then begin
                if SalesHeader."E-Invoice Clearance Status" <> 'CLEARED' then
                    Error('Please Submit Document to Zatca');
            end;
        SalesCrMemoHeader."E-Invoice ZATCA Invoice Response" := SalesHeader."E-Invoice ZATCA Response";
        SalesCrMemoHeader.Modify();
    end;

    local procedure DefaultCurrencyCode(): Code[20]
    var
        genLedgSetup_lRec: Record "General Ledger Setup";
    begin
        Clear(_DefaultCurrencyCode);
        if genLedgSetup_lRec.Get() then begin
            if _DefaultCurrencyCode = '' then begin
                _DefaultCurrencyCode := genLedgSetup_lRec."LCY Code";
            end;
        end;
    end;

    procedure GetInvoiceHash(): Text
    begin
        if CompanyInfo.get() then;
        if CompanyInfo."E-Invoice Invoice Hash" = '' then begin
            PiHContant := 'NWZlY2ViNjZmZmM4NmYzOGQ5NTI3ODZjNmQ2OTZjNzljMmRiYzIzOWRkNGU5MWI0NjcyOWQ3M2EyN2ZiNTdlOQ==';
            exit(PiHContant);
        end else begin
            PiHContant := CompanyInfo."E-Invoice Invoice Hash";
            exit(PiHContant);
        end;

    end;

    procedure CreateXmlDemoOfSalesOrder(var SalesHeaderRec: Record "Sales Header"): Text
    var
    begin

        Clear(RootXmlNode);
        Clear(extUBLExtensionsNode);
        Clear(extExtensionURINode);
        Clear(RootNameSpaceURL);
        GetInvoiceHash();
        DefaultCurrencyCode();

        if Customer_Rec.Get(SalesHeaderRec."Sell-to Customer No.") then;



        SalesHeaderRec.CalcFields("Amount Including VAT", Amount);
        RootNameSpaceURL := 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2';

        //Create the doc
        xmlDoc := xmlDocument.Create();

        //Add the declaration
        xmlDec := xmlDeclaration.Create('1.0', 'utf-8', 'yes');
        xmlDoc.SetDeclaration(xmlDec);

        // Root Element 
        RootXmlNode := XmlElement.Create('Invoice', '*-123#').AsXmlNode(); //we are using for tag close
        RootXmlNode.AsXmlElement.Add(XmlAttribute.CreateNamespaceDeclaration('Invoice123', RootNameSpaceURL));
        RootXmlNode.AsXmlElement.Add(XmlAttribute.CreateNamespaceDeclaration('cac', 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2'));
        RootXmlNode.AsXmlElement.Add(XmlAttribute.CreateNamespaceDeclaration('cbc', 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2'));
        RootXmlNode.AsXmlElement.Add(XmlAttribute.CreateNamespaceDeclaration('ext', 'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2'));

        // extUBLExtensions Node4
        extUBLExtensionsNode := XmlElement.Create('UBLExtensions', '*-123#').AsXmlNode();
        extUBLExtensionsNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ext', '*-123#'));
        // extUBLExtensions Node end

        extUBLExtensionNode := XmlElement.Create('UBLExtension', '*-123#').AsXmlNode();
        extUBLExtensionNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ext', '*-123#'));

        //extExtensionURI start
        extExtensionURINode := XmlElement.Create('ExtensionURI', '*-123#', 'urn:oasis:names:specification:ubl:dsig:enveloped:xades').AsXmlNode();
        extExtensionURINode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ext', '*-123#'));
        // extExtensionURI Ends

        //ExtensionContent Start
        extExtensionContent := XmlElement.Create('ExtensionContent', '*-123#').AsXmlNode();
        extExtensionContent.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ext', '*-123#'));

        sigUBLDocumentSignatures := XmlElement.Create('UBLDocumentSignatures', 'urn:oasis:names:specification:ubl:schema:xsd:CommonSignatureComponents-2').AsXmlNode();
        sigUBLDocumentSignatures.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('sig', 'urn:oasis:names:specification:ubl:schema:xsd:CommonSignatureComponents-2'));
        sigUBLDocumentSignatures.AsXmlElement.Add(XmlAttribute.CreateNamespaceDeclaration('sac', 'urn:oasis:names:specification:ubl:schema:xsd:SignatureAggregateComponents-2'));
        sigUBLDocumentSignatures.AsXmlElement.Add(XmlAttribute.CreateNamespaceDeclaration('sbc', 'urn:oasis:names:specification:ubl:schema:xsd:SignatureBasicComponents-2'));


        SacSignatureInformation := XmlElement.Create('SignatureInformation', '*-123#').AsXmlNode();
        SacSignatureInformation.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('sac', '*-123#'));

        CBCNode := XmlElement.Create('ID', '*-123#', 'urn:oasis:names:specification:ubl:signature:1').AsXmlNode();
        CBCNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        SBCNode := XmlElement.Create('ReferencedSignatureID', '*-123#', 'urn:oasis:names:specification:ubl:signature:Invoice').AsXmlNode();
        SBCNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('sbc', '*-123#'));


        dsSignatureXmlNode := XmlElement.Create('Signature', 'http://www.w3.org/2000/09/xmldsig#').AsXmlNode();
        dsSignatureXmlNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', 'http://www.w3.org/2000/09/xmldsig#'));
        dsSignatureXmlNode.AsXmlElement().Add(XmlAttribute.Create('Id', 'signature'));

        dsSignedInfo := XmlElement.Create('SignedInfo', '*-123#').AsXmlNode();
        dsSignedInfo.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        //zeeshan issue

        dsCanonicalizationMethod := XmlElement.Create('CanonicalizationMethod', '*-123#').AsXmlNode();
        dsCanonicalizationMethod.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsCanonicalizationMethod.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/2006/12/xml-c14n11'));

        dsSignatureMethod := XmlElement.Create('SignatureMethod', '*-123#').AsXmlNode();
        dsSignatureMethod.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsSignatureMethod.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha256'));
        //zeeshan issue

        dsReference := XmlElement.Create('Reference', '*-123#').AsXmlNode();
        dsReference.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsReference.AsXmlElement().Add(XmlAttribute.Create('Id', 'invoiceSignedData'));
        dsReference.AsXmlElement().Add(XmlAttribute.Create('URI', ''));

        dsTransforms := XmlElement.Create('Transforms', '*-123#').AsXmlNode();
        dsTransforms.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsTransform1 := XmlElement.Create('Transform', '*-123#').AsXmlNode();
        dsTransform1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsTransform1.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/TR/1999/SalesHeaderRec-xpath-19991116'));

        dsTransformXpath1 := XmlElement.Create('XPath', '*-123#', 'not(//ancestor-or-self::ext:UBLExtensions)').AsXmlNode();
        dsTransformXpath1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsTransform2 := XmlElement.Create('Transform', '*-123#').AsXmlNode();
        dsTransform2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsTransform2.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/TR/1999/SalesHeaderRec-xpath-19991116'));

        dsTransformXpath2 := XmlElement.Create('XPath', '*-123#', 'not(//ancestor-or-self::cac:Signature)').AsXmlNode();
        dsTransformXpath2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsTransform3 := XmlElement.Create('Transform', '*-123#').AsXmlNode();
        dsTransform3.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsTransform3.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/TR/1999/SalesHeaderRec-xpath-19991116'));

        dsTransformXpath3 := XmlElement.Create('XPath', '*-123#', 'not(//ancestor-or-self::cac:AdditionalDocumentReference[cbc:ID=QR])').AsXmlNode();
        dsTransformXpath3.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsTransform4 := XmlElement.Create('Transform', '*-123#').AsXmlNode();
        dsTransform4.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsTransform4.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/2006/12/xml-c14n11'));

        dsDigestMethod := XmlElement.Create('DigestMethod', '*-123#').AsXmlNode();
        dsDigestMethod.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsDigestMethod.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha256'));

        dsDigestValue := XmlElement.Create('DigestValue', '*-123#', 'WI6GNwty4XrTc3P1WrRM1xlhqz9TimXdCLH9sgmj0Sg=').AsXmlNode();
        dsDigestValue.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));


        dsReference1 := XmlElement.Create('Reference', '*-123#').AsXmlNode();
        dsReference1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsReference1.AsXmlElement().Add(XmlAttribute.Create('Type', 'http://www.w3.org/2000/09/xmldsig#SignatureProperties'));
        dsReference1.AsXmlElement().Add(XmlAttribute.Create('URI', '#xadesSignedProperties'));

        dsDigestMethod1 := XmlElement.Create('DigestMethod', '*-123#').AsXmlNode();
        dsDigestMethod1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsDigestMethod1.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha256'));

        dsDigestValue1 := XmlElement.Create('DigestValue', '*-123#', 'ZjU2ZjM4YTExODRmNzE0ZjIxODA4MDYxYjhiMzdmM2JlMTJiNWQ0N2E2YjhjNzQwMjg2NDBkMzJlM2MxNjM2Nw==').AsXmlNode();
        dsDigestValue1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsSignatureValue := XmlElement.Create('SignatureValue', '*-123#', 'MEUCIQCCGL7AJacVObs7luFYTbsqKr9qLZX+LYjZivOjDNnaYgIgT0SrZZKk3L8fzV8/J7h9p7wH0BoqplW0RBcWOVNeW0w=').AsXmlNode();
        dsSignatureValue.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsKeyInfo := XmlElement.Create('KeyInfo', '*-123#').AsXmlNode();
        dsKeyInfo.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsX509Data := XmlElement.Create('X509Data', '*-123#').AsXmlNode();
        dsX509Data.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsX509Certificate := XmlElement.Create('X509Certificate', '*-123#', 'MIID6TCCA5CgAwIBAgITbwAAf8tem6jngr16DwABAAB/yzAKBggqhkjOPQQDAjBjMRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxEzARBgoJkiaJk/IsZAEZFgNnb3YxFzAVBgoJkiaJk/IsZAEZFgdleHRnYXp0MRwwGgYDVQQDExNUU1pFSU5WT0lDRS1TdWJDQS0xMB4XDTIyMDkxNDEzMjYwNFoXDTI0MDkxMzEzMjYwNFowTjELMAkGA1UEBhMCU0ExEzARBgNVBAoTCjMxMTExMTExMTExDDAKBgNVBAsTA1RTVDEcMBoGA1UEAxMTVFNULTMxMTExMTExMTEwMTExMzBWMBAGByqGSM49AgEGBSuBBAAKA0IABGGDDKDmhWAITDv7LXqLX2cmr6+qddUkpcLCvWs5rC2O29W/hS4ajAK4Qdnahym6MaijX75Cg3j4aao7ouYXJ9GjggI5MIICNTCBmgYDVR0RBIGSMIGPpIGMMIGJMTswOQYDVQQEDDIxLVRTVHwyLVRTVHwzLWE4NjZiMTQyLWFjOWMtNDI0MS1iZjhlLTdmNzg3YTI2MmNlMjEfMB0GCgmSJomT8ixkAQEMDzMxMTExMTExMTEwMTExMzENMAsGA1UEDAwEMTEwMDEMMAoGA1UEGgwDVFNUMQwwCgYDVQQPDANUU1QwHQYDVR0OBBYEFDuWYlOzWpFN3no1WtyNktQdrA8JMB8GA1UdIwQYMBaAFHZgjPsGoKxnVzWdz5qspyuZNbUvME4GA1UdHwRHMEUwQ6BBoD+GPWh0dHA6Ly90c3RjcmwuemF0Y2EuZ292LnNhL0NlcnRFbnJvbGwvVFNaRUlOVk9JQ0UtU3ViQ0EtMS5jcmwwga0GCCsGAQUFBwEBBIGgMIGdMG4GCCsGAQUFBzABhmJodHRwOi8vdHN0Y3JsLnphdGNhLmdvdi5zYS9DZXJ0RW5yb2xsL1RTWkVpbnZvaWNlU0NBMS5leHRnYXp0Lmdvdi5sb2NhbF9UU1pFSU5WT0lDRS1TdWJDQS0xKDEpLmNydDArBggrBgEFBQcwAYYfaHR0cDovL3RzdGNybC56YXRjYS5nb3Yuc2Evb2NzcDAOBgNVHQ8BAf8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMDMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwMwCgYIKoZIzj0EAwIDRwAwRAIgOgjNPJW017lsIijmVQVkP7GzFO2KQKd9GHaukLgIWFsCIFJF9uwKhTMxDjWbN+1awsnFI7RLBRxA/6hZ+F1wtaqU').AsXmlNode();
        dsX509Certificate.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));


        dsObject := XmlElement.Create('Object', '*-123#').AsXmlNode();
        dsObject.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        xadesQualifyingProperties := XmlElement.Create('QualifyingProperties', 'http://uri.etsi.org/01903/v1.3.2#').AsXmlNode();
        xadesQualifyingProperties.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', 'http://uri.etsi.org/01903/v1.3.2#'));
        xadesQualifyingProperties.AsXmlElement().Add(XmlAttribute.Create('Target', 'signature'));

        xadesSignedProperties := XmlElement.Create('SignedProperties', '*-123#').AsXmlNode();
        xadesSignedProperties.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));
        xadesSignedProperties.AsXmlElement().Add(XmlAttribute.Create('Id', 'xadesSignedProperties'));

        xadesSignedSignatureProperties := XmlElement.Create('SignedSignatureProperties', '*-123#').AsXmlNode();
        xadesSignedSignatureProperties.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));

        xadesSigningTime := XmlElement.Create('SigningTime', '*-123#', '2022-09-15T01:45:47Z').AsXmlNode();
        xadesSigningTime.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));

        xadesSigningCertificate := XmlElement.Create('SigningCertificate', '*-123#').AsXmlNode();
        xadesSigningCertificate.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));


        xadesCert := XmlElement.Create('Cert', '*-123#').AsXmlNode();
        xadesCert.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));

        xadesCertDigest := XmlElement.Create('CertDigest', '*-123#').AsXmlNode();
        xadesCertDigest.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));


        dsDigestMethod2 := XmlElement.Create('DigestMethod', '*-123#').AsXmlNode();
        dsDigestMethod2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));
        dsDigestMethod2.AsXmlElement().Add(XmlAttribute.Create('Algorithm', 'http://www.w3.org/2001/04/xmlenc#sha256'));

        dsDigestValue2 := XmlElement.Create('DigestValue', '*-123#', 'YTJkM2JhYTcwZTBhZTAxOGYwODMyNzY3NTdkZDM3YzhjY2IxOTIyZDZhM2RlZGJiMGY0NDUzZWJhYWI4MDhmYg==').AsXmlNode();
        dsDigestValue2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        xadesIssuerSerial := XmlElement.Create('IssuerSerial', '*-123#').AsXmlNode();
        xadesIssuerSerial.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('xades', '*-123#'));

        dsX509IssuerName := XmlElement.Create('X509IssuerName', '*-123#', 'CN=TSZEINVOICE-SubCA-1, DC=extgazt, DC=gov, DC=local').AsXmlNode();
        dsX509IssuerName.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        dsX509SerialNumber := XmlElement.Create('X509SerialNumber', '*-123#', '2475382886904809774818644480820936050208702411').AsXmlNode();
        dsX509SerialNumber.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('ds', '*-123#'));

        cbcProfileID := XmlElement.Create('ProfileID', '*-123#', 'reporting:1.0').AsXmlNode();
        cbcProfileID.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));


        cbcID := XmlElement.Create('ID', '*-123#', 'SME00023').AsXmlNode();
        cbcID.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcUUID := XmlElement.Create('UUID', '*-123#', Format(SalesHeaderRec.SystemId).TrimStart('{').TrimEnd('}')).AsXmlNode();
        cbcUUID.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcIssueDate := XmlElement.Create('IssueDate', '*-123#', '2022-09-07').AsXmlNode();
        cbcIssueDate.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcIssueTime := XmlElement.Create('IssueTime', '*-123#', '12:21:28').AsXmlNode();
        cbcIssueTime.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcInvoiceTypeCode := XmlElement.Create('InvoiceTypeCode', '*-123#', '388').AsXmlNode();
        cbcInvoiceTypeCode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcInvoiceTypeCode.AsXmlElement().Add(XmlAttribute.Create('name', '0100000'));

        cbcDocumentCurrencyCode := XmlElement.Create('DocumentCurrencyCode', '*-123#', Format(_DefaultCurrencyCode)).AsXmlNode();
        cbcDocumentCurrencyCode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcTaxCurrencyCode := XmlElement.Create('TaxCurrencyCode', '*-123#', Format('SAR')).AsXmlNode();
        cbcTaxCurrencyCode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAdditionalDocumentReference := XmlElement.Create('AdditionalDocumentReference', '*-123#').AsXmlNode();
        cacAdditionalDocumentReference.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID1 := XmlElement.Create('ID', '*-123#', 'ICV').AsXmlNode();
        cbcID1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcUUID1 := XmlElement.Create('UUID', '*-123#', '23').AsXmlNode();
        cbcUUID1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAdditionalDocumentReference1 := XmlElement.Create('AdditionalDocumentReference', '*-123#').AsXmlNode();
        cacAdditionalDocumentReference1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID2 := XmlElement.Create('ID', '*-123#', 'PIH').AsXmlNode();
        cbcID2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAttachment := XmlElement.Create('Attachment', '*-123#').AsXmlNode();
        cacAttachment.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcEmbeddedDocumentBinaryObject := XmlElement.Create('EmbeddedDocumentBinaryObject', '*-123#', PiHContant).AsXmlNode();
        cbcEmbeddedDocumentBinaryObject.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcEmbeddedDocumentBinaryObject.AsXmlElement().Add(XmlAttribute.Create('mimeCode', 'text/plain'));

        cacAdditionalDocumentReference2 := XmlElement.Create('AdditionalDocumentReference', '*-123#').AsXmlNode();
        cacAdditionalDocumentReference2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID3 := XmlElement.Create('ID', '*-123#', 'QR').AsXmlNode();
        cbcID3.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAttachment2 := XmlElement.Create('Attachment', '*-123#').AsXmlNode();
        cacAttachment2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcEmbeddedDocumentBinaryObject2 := XmlElement.Create('EmbeddedDocumentBinaryObject', '*-123#', CU_GenerateQR.InitArguments(SalesHeaderRec."No.", SalesHeaderRec, CompanyInfo)).AsXmlNode();
        cbcEmbeddedDocumentBinaryObject2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcEmbeddedDocumentBinaryObject2.AsXmlElement().Add(XmlAttribute.Create('mimeCode', 'text/plain'));

        cacSignature := XmlElement.Create('Signature', '*-123#').AsXmlNode();
        cacSignature.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID4 := XmlElement.Create('ID', '*-123#', 'urn:oasis:names:specification:ubl:signature:Invoice').AsXmlNode();
        cbcID4.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcSignatureMethod := XmlElement.Create('SignatureMethod', '*-123#', 'urn:oasis:names:specification:ubl:dsig:enveloped:xades').AsXmlNode();
        cbcSignatureMethod.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAccountingSupplierParty := XmlElement.Create('AccountingSupplierParty', '*-123#').AsXmlNode();
        cacAccountingSupplierParty.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cacParty := XmlElement.Create('Party', '*-123#').AsXmlNode();
        cacParty.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cacPartyIdentification := XmlElement.Create('PartyIdentification', '*-123#').AsXmlNode();
        cacPartyIdentification.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID5 := XmlElement.Create('ID', '*-123#', Format(CompanyInfo."E-Invoice Scheme_ID")).AsXmlNode();
        cbcID5.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcID5.AsXmlElement().Add(XmlAttribute.Create('schemeID', 'CRN'));


        cacPostalAddress := XmlElement.Create('PostalAddress', '*-123#').AsXmlNode();
        cacPostalAddress.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcStreetName := XmlElement.Create('StreetName', '*-123#', Format(CompanyInfo."E-Invoice Street Name")).AsXmlNode();
        cbcStreetName.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcBuildingNumber := XmlElement.Create('BuildingNumber', '*-123#', Format(CompanyInfo."E-Invoice Building No")).AsXmlNode();
        cbcBuildingNumber.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcPlotIdentification := XmlElement.Create('PlotIdentification', '*-123#', Format(CompanyInfo."E-Invoice Plot_Identification")).AsXmlNode();
        cbcPlotIdentification.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcCitySubdivisionName := XmlElement.Create('CitySubdivisionName', '*-123#', Format(CompanyInfo."E-Invoice City_Subdivision_Name")).AsXmlNode();
        cbcCitySubdivisionName.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcCityName := XmlElement.Create('CityName', '*-123#', Format(CompanyInfo.City)).AsXmlNode();
        cbcCityName.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcPostalZone := XmlElement.Create('PostalZone', '*-123#', Format(CompanyInfo."Post Code")).AsXmlNode();
        cbcPostalZone.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacCountry := XmlElement.Create('Country', '*-123#').AsXmlNode();
        cacCountry.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcIdentificationCode := XmlElement.Create('IdentificationCode', '*-123#', Format(CompanyInfo."Country/Region Code")).AsXmlNode();
        cbcIdentificationCode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacPartyTaxScheme := XmlElement.Create('PartyTaxScheme', '*-123#').AsXmlNode();
        cacPartyTaxScheme.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));


        cbcCompanyID := XmlElement.Create('CompanyID', '*-123#', Format(CompanyInfo."E-Invoice Scheme_ID")).AsXmlNode(); // need to confirm mapping
        cbcCompanyID.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacTaxScheme := XmlElement.Create('TaxScheme', '*-123#').AsXmlNode();
        cacTaxScheme.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));
        cbcID6 := XmlElement.Create('ID', '*-123#', 'VAT').AsXmlNode();
        cbcid6.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));


        cacPartyLegalEntity := XmlElement.Create('PartyLegalEntity', '*-123#').AsXmlNode();
        cacPartyLegalEntity.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcRegistrationName := XmlElement.Create('RegistrationName', '*-123#', Format(CompanyInfo."E-Invoice Registration_Name")).AsXmlNode();
        cbcRegistrationName.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAccountingCustomerParty := XmlElement.Create('AccountingCustomerParty', '*-123#').AsXmlNode();
        cacAccountingCustomerParty.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cacParty1 := XmlElement.Create('Party', '*-123#').AsXmlNode();
        cacParty1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cacPartyIdentification1 := XmlElement.Create('PartyIdentification', '*-123#').AsXmlNode();
        cacPartyIdentification1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));


        cbcID7 := XmlElement.Create('ID', '*-123#', Format(Customer_Rec."E-Invoice Scheme_ID")).AsXmlNode();
        cbcID7.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcID7.AsXmlElement().Add(XmlAttribute.Create('schemeID', 'NAT'));


        cacPostalAddress1 := XmlElement.Create('PostalAddress', '*-123#').AsXmlNode();
        cacPostalAddress1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));



        cbcStreetName1 := XmlElement.Create('StreetName', '*-123#', Format(Customer_Rec."E-Invoice Street Name")).AsXmlNode();
        cbcStreetName1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcBuildingNumber1 := XmlElement.Create('BuildingNumber', '*-123#', Format(Customer_Rec."E-Invoice Building No")).AsXmlNode();
        cbcBuildingNumber1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcPlotIdentification1 := XmlElement.Create('PlotIdentification', '*-123#', Format(Customer_Rec."E-InvoicePlot_Identification")).AsXmlNode();
        cbcPlotIdentification1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcCitySubdivisionName1 := XmlElement.Create('CitySubdivisionName', '*-123#', Format(Customer_Rec."E-Invoice City_Subdivision_Name")).AsXmlNode();
        cbcCitySubdivisionName1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcCityName1 := XmlElement.Create('CityName', '*-123#', Format(Customer_Rec.City)).AsXmlNode();
        cbcCityName1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcPostalZone1 := XmlElement.Create('PostalZone', '*-123#', Format(Customer_Rec."Post Code")).AsXmlNode();
        cbcPostalZone1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacCountry1 := XmlElement.Create('Country', '*-123#').AsXmlNode();
        cacCountry1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcIdentificationCode1 := XmlElement.Create('IdentificationCode', '*-123#', Format(Customer_Rec."Country/Region Code")).AsXmlNode();
        cbcIdentificationCode1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacPartyTaxScheme1 := XmlElement.Create('PartyTaxScheme', '*-123#').AsXmlNode();
        cacPartyTaxScheme1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cacTaxScheme1 := XmlElement.Create('TaxScheme', '*-123#').AsXmlNode();
        cacTaxScheme1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));
        cbcID8 := XmlElement.Create('ID', '*-123#', 'VAT').AsXmlNode();
        cbcid8.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));


        cacPartyLegalEntity1 := XmlElement.Create('PartyLegalEntity', '*-123#').AsXmlNode();
        cacPartyLegalEntity1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcRegistrationName1 := XmlElement.Create('RegistrationName', '*-123#', Format(CompanyInfo."E-Invoice Registration_Name")).AsXmlNode();
        cbcRegistrationName1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        // 
        cacDeliveryNode := XmlElement.Create('Delivery', '*-123#').AsXmlNode();
        cacDeliveryNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        // need to discuss 
        cbcActualDeliveryDateNode := XmlElement.Create('ActualDeliveryDate', '*-123#', Format('2022-09-07')).AsXmlNode();
        cbcActualDeliveryDateNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));


        cacPaymentMeansNode := XmlElement.Create('PaymentMeans', '*-123#').AsXmlNode();
        cacPaymentMeansNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        // need to discuss 
        cbcPaymentMeansCodeNode := XmlElement.Create('PaymentMeansCode', '*-123#', Format('10')).AsXmlNode();
        cbcPaymentMeansCodeNode.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacAllowanceCharge := XmlElement.Create('AllowanceCharge', '*-123#').AsXmlNode();
        cacAllowanceCharge.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        // Need to discuss
        cbcChargeIndicator := XmlElement.Create('ChargeIndicator', '*-123#', 'false').AsXmlNode();
        cbcChargeIndicator.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        // Need to discuss
        cbcAllowanceChargeReason := XmlElement.Create('AllowanceChargeReason', '*-123#', 'discount').AsXmlNode();
        cbcAllowanceChargeReason.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        // Need to discuss
        cbcAmount := XmlElement.Create('Amount', '*-123#', Format(SalesHeaderRec."Invoice Discount Value")).AsXmlNode();
        cbcAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        // Need to discuss
        cacTaxCategory := XmlElement.Create('TaxCategory', '*-123#').AsXmlNode();
        cacTaxCategory.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        // Need to discuss
        cacTaxCategorycbcID := XmlElement.Create('ID', '*-123#', 'S').AsXmlNode();
        cacTaxCategorycbcID.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cacTaxCategorycbcID.AsXmlElement().Add(XmlAttribute.Create('schemeID', Format('UN/ECE 5305')));
        cacTaxCategorycbcID.AsXmlElement().Add(XmlAttribute.Create('schemeAgencyID', Format('6')));

        // Need to discuss
        cbcPercent := XmlElement.Create('Percent', '*-123#', '15').AsXmlNode();
        cbcPercent.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        // Need to discuss
        cacTaxCategorycacTaxScheme := XmlElement.Create('TaxScheme', '*-123#').AsXmlNode();
        cacTaxCategorycacTaxScheme.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        // Need to discuss
        cacTaxSchemecbcID := XmlElement.Create('ID', '*-123#', 'VAT').AsXmlNode();
        cacTaxSchemecbcID.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cacTaxSchemecbcID.AsXmlElement().Add(XmlAttribute.Create('schemeID', Format('UN/ECE 5153')));
        cacTaxSchemecbcID.AsXmlElement().Add(XmlAttribute.Create('schemeAgencyID', Format('6')));

        cacTaxTotal := XmlElement.Create('TaxTotal', '*-123#').AsXmlNode();
        cacTaxTotal.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcTaxAmount := XmlElement.Create('TaxAmount', '*-123#', Format((SalesHeaderRec."Amount Including VAT") - SalesHeaderRec.Amount).Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cacTaxTotal1 := XmlElement.Create('TaxTotal', '*-123#').AsXmlNode();
        cacTaxTotal1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcTaxAmount1 := XmlElement.Create('TaxAmount', '*-123#', Format(SalesHeaderRec."Amount Including VAT" - SalesHeaderRec.Amount).Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxAmount1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxAmount1.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cacTaxSubtotal := XmlElement.Create('TaxSubtotal', '*-123#').AsXmlNode();
        cacTaxSubtotal.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcTaxableAmount := XmlElement.Create('TaxableAmount', '*-123#', Format(SalesHeaderRec.Amount).Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxableAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxableAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcTaxAmount2 := XmlElement.Create('TaxAmount', '*-123#', Format(SalesHeaderRec."Amount Including VAT" - SalesHeaderRec.Amount).Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxAmount2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxAmount2.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));


        cacTaxCategory1 := XmlElement.Create('TaxCategory', '*-123#').AsXmlNode();
        cacTaxCategory1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID10 := XmlElement.Create('ID', '*-123#', 'S').AsXmlNode();
        cbcID10.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcID10.AsXmlElement().Add(XmlAttribute.Create('schemeID', 'UN/ECE 5305'));
        cbcID10.AsXmlElement().Add(XmlAttribute.Create('schemeAgencyID', '6'));

        cbcPercent := XmlElement.Create('Percent', '*-123#', '15.00').AsXmlNode();
        cbcPercent.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacTaxScheme2 := XmlElement.Create('TaxScheme', '*-123#').AsXmlNode();
        cacTaxScheme2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcID11 := XmlElement.Create('ID', '*-123#', 'VAT').AsXmlNode();
        cbcID11.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcID11.AsXmlElement().Add(XmlAttribute.Create('schemeID', 'UN/ECE 5153'));
        cbcID11.AsXmlElement().Add(XmlAttribute.Create('schemeAgencyID', '6'));


        cacLegalMonetaryTotal := XmlElement.Create('LegalMonetaryTotal', '*-123#').AsXmlNode();
        cacLegalMonetaryTotal.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcLineExtensionAmount := XmlElement.Create('LineExtensionAmount', '*-123#', Format(SalesHeaderRec."Amount").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcLineExtensionAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcLineExtensionAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcTaxExclusiveAmount := XmlElement.Create('TaxExclusiveAmount', '*-123#', Format(SalesHeaderRec."Amount").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxExclusiveAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxExclusiveAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcTaxInclusiveAmount := XmlElement.Create('TaxInclusiveAmount', '*-123#', Format(SalesHeaderRec."Amount Including VAT").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxInclusiveAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxInclusiveAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcAllowanceTotalAmount := XmlElement.Create('AllowanceTotalAmount', '*-123#', '0.00').AsXmlNode();
        cbcAllowanceTotalAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcAllowanceTotalAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcPrepaidAmount := XmlElement.Create('PrepaidAmount', '*-123#', '0.00').AsXmlNode();
        cbcPrepaidAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcPrepaidAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcPayableAmount := XmlElement.Create('PayableAmount', '*-123#', Format(SalesHeaderRec."Amount Including VAT").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcPayableAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcPayableAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));


        //Line infor










        extUBLExtensionNode.AsXmlElement().Add(extExtensionURINode);
        //UBL Extension Close



        SacSignatureInformation.AsXmlElement().Add(CBCNode);
        SacSignatureInformation.AsXmlElement().Add(SBCNode);


        dsTransform1.AsXmlElement().Add(dsTransformXpath1);
        dsTransforms.AsXmlElement().Add(dsTransform1);

        dsTransform2.AsXmlElement().Add(dsTransformXpath2);
        dsTransforms.AsXmlElement().Add(dsTransform2);

        dsTransform3.AsXmlElement().Add(dsTransformXpath3);
        dsTransforms.AsXmlElement().Add(dsTransform3);
        dsTransforms.AsXmlElement().Add(dsTransform4);


        dsReference.AsXmlElement().Add(dsTransforms);
        dsReference.AsXmlElement().Add(dsDigestMethod);
        dsReference.AsXmlElement().Add(dsDigestValue);



        dsSignedInfo.AsXmlElement().Add(dsCanonicalizationMethod);
        dsSignedInfo.AsXmlElement().Add(dsSignatureMethod);
        dsSignedInfo.AsXmlElement().Add(dsReference);//Refrence Close



        dsReference1.AsXmlElement().Add(dsDigestMethod1);
        dsReference1.AsXmlElement().Add(dsDigestValue1);

        dsSignedInfo.AsXmlElement().Add(dsReference1);
        dsSignatureXmlNode.AsXmlElement().Add(dsSignedInfo);//SignedInfo Close
        dsSignatureXmlNode.AsXmlElement().Add(dsSignatureValue);
        dsX509Data.AsXmlElement().Add(dsX509Certificate);
        dsKeyInfo.AsXmlElement().Add(dsX509Data);
        dsSignatureXmlNode.AsXmlElement().add(dsKeyInfo);



        xadesSignedSignatureProperties.AsXmlElement().Add(xadesSigningTime);


        xadesCertDigest.AsXmlElement().Add(dsDigestMethod2);
        xadesCertDigest.AsXmlElement().Add(dsDigestValue2);

        xadesCert.AsXmlElement().Add(xadesCertDigest);


        xadesIssuerSerial.AsXmlElement().Add(dsX509IssuerName);
        xadesIssuerSerial.AsXmlElement().Add(dsX509SerialNumber);


        xadesCert.AsXmlElement().Add(xadesIssuerSerial);
        xadesSigningCertificate.AsXmlElement().Add(xadesCert);

        xadesSignedSignatureProperties.AsXmlElement().Add(xadesSigningCertificate);

        xadesSignedProperties.AsXmlElement().Add(xadesSignedSignatureProperties);
        xadesQualifyingProperties.AsXmlElement().Add(xadesSignedProperties);
        dsObject.AsXmlElement().Add(xadesQualifyingProperties);
        dsSignatureXmlNode.AsXmlElement().Add(dsObject);
        SacSignatureInformation.AsXmlElement().Add(dsSignatureXmlNode);//SignatureClose
        sigUBLDocumentSignatures.AsXmlElement().Add(SacSignatureInformation);//Signature Information Close
        extExtensionContent.AsXmlElement().Add(sigUBLDocumentSignatures);//UBL Document Signature Close

        extUBLExtensionNode.AsXmlElement().Add(extExtensionContent);


        extUBLExtensionsNode.AsXmlElement().Add(extUBLExtensionNode);


        RootXmlNode.AsXmlElement.Add(extUBLExtensionsNode);
        //UBL Extensions Close


        RootXmlNode.AsXmlElement.Add(cbcProfileID);
        RootXmlNode.AsXmlElement.Add(cbcID);
        RootXmlNode.AsXmlElement.Add(cbcUUID);
        RootXmlNode.AsXmlElement.Add(cbcIssueDate);
        RootXmlNode.AsXmlElement.Add(cbcIssueTime);
        RootXmlNode.AsXmlElement.Add(cbcInvoiceTypeCode);
        RootXmlNode.AsXmlElement.Add(cbcDocumentCurrencyCode);
        RootXmlNode.AsXmlElement.Add(cbcTaxCurrencyCode);


        cacAdditionalDocumentReference.AsXmlElement().Add(cbcID1);
        cacAdditionalDocumentReference.AsXmlElement().Add(cbcUUID1);
        RootXmlNode.AsXmlElement().Add(cacAdditionalDocumentReference);


        cacAdditionalDocumentReference1.AsXmlElement().Add(cbcID2);
        cacAttachment.AsXmlElement().Add(cbcEmbeddedDocumentBinaryObject);
        cacAdditionalDocumentReference1.AsXmlElement().Add(cacAttachment);
        RootXmlNode.AsXmlElement().Add(cacAdditionalDocumentReference1);


        cacAdditionalDocumentReference2.AsXmlElement().Add(cbcID3);
        cacAttachment2.AsXmlElement().Add(cbcEmbeddedDocumentBinaryObject2);
        cacAdditionalDocumentReference2.AsXmlElement().Add(cacAttachment2);
        RootXmlNode.AsXmlElement().Add(cacAdditionalDocumentReference2);

        cacSignature.AsXmlElement().Add(cbcID4);
        cacSignature.AsXmlElement().Add(cbcSignatureMethod);
        RootXmlNode.AsXmlElement().Add(cacSignature);

        cacPartyIdentification.AsXmlElement().Add(cbcID5);
        cacParty.AsXmlElement().Add(cacPartyIdentification);


        cacPostalAddress.AsXmlElement().add(cbcStreetName);
        cacPostalAddress.AsXmlElement().add(cbcBuildingNumber);
        cacPostalAddress.AsXmlElement().add(cbcPlotIdentification);
        cacPostalAddress.AsXmlElement().add(cbcCitySubdivisionName);
        cacPostalAddress.AsXmlElement().add(cbcCityName);
        cacPostalAddress.AsXmlElement().add(cbcPostalZone);

        cacCountry.AsXmlElement().Add(cbcIdentificationCode);
        cacPostalAddress.AsXmlElement().Add(cacCountry);
        cacParty.AsXmlElement().Add(cacPostalAddress);



        cacPartyTaxScheme.AsXmlElement().Add(cbcCompanyID);
        cacTaxScheme.AsXmlElement().Add(cbcID6);
        cacPartyTaxScheme.AsXmlElement().Add(cacTaxScheme);
        cacParty.AsXmlElement().Add(cacPartyTaxScheme);


        cacPartyLegalEntity.AsXmlElement().Add(cbcRegistrationName);
        cacParty.AsXmlElement().Add(cacPartyLegalEntity);
        cacAccountingSupplierParty.AsXmlElement().Add(cacParty);
        RootXmlNode.AsXmlElement().Add(cacAccountingSupplierParty);


        cacPartyIdentification1.AsXmlElement().Add(cbcID7);
        cacParty1.AsXmlElement().Add(cacPartyIdentification1);


        cacPostalAddress1.AsXmlElement().add(cbcStreetName1);
        cacPostalAddress1.AsXmlElement().add(cbcBuildingNumber1);
        cacPostalAddress1.AsXmlElement().add(cbcPlotIdentification1);
        cacPostalAddress1.AsXmlElement().add(cbcCitySubdivisionName1);
        cacPostalAddress1.AsXmlElement().add(cbcCityName1);
        cacPostalAddress1.AsXmlElement().add(cbcPostalZone1);

        cacCountry1.AsXmlElement().Add(cbcIdentificationCode1);
        cacPostalAddress1.AsXmlElement().Add(cacCountry1);
        cacParty1.AsXmlElement().Add(cacPostalAddress1);



        cacTaxScheme1.AsXmlElement().Add(cbcID8);
        cacPartyTaxScheme1.AsXmlElement().Add(cacTaxScheme1);
        cacParty1.AsXmlElement().Add(cacPartyTaxScheme1);


        cacPartyLegalEntity1.AsXmlElement().Add(cbcRegistrationName1);
        cacParty1.AsXmlElement().Add(cacPartyLegalEntity1);
        cacAccountingCustomerParty.AsXmlElement().Add(cacParty1);
        RootXmlNode.AsXmlElement().Add(cacAccountingCustomerParty);

        cacDeliveryNode.AsXmlElement().Add(cbcActualDeliveryDateNode);
        RootXmlNode.AsXmlElement().Add(cacDeliveryNode);

        cacPaymentMeansNode.AsXmlElement().Add(cbcPaymentMeansCodeNode);
        RootXmlNode.AsXmlElement().Add(cacPaymentMeansNode);


        cacAllowanceCharge.AsXmlElement().Add(cbcChargeIndicator);
        cacAllowanceCharge.AsXmlElement().Add(cbcAllowanceChargeReason);
        cacAllowanceCharge.AsXmlElement().Add(cbcAmount);
        cacTaxCategory.AsXmlElement().Add(cacTaxCategorycbcID);
        cacTaxCategory.AsXmlElement().Add(cbcPercent);

        cacTaxCategorycacTaxScheme.AsXmlElement().Add(cacTaxSchemecbcID);
        cacTaxCategory.AsXmlElement().Add(cacTaxCategorycacTaxScheme);
        cacAllowanceCharge.AsXmlElement().Add(cacTaxCategory);
        RootXmlNode.AsXmlElement().Add(cacAllowanceCharge);

        cacTaxTotal.AsXmlElement().Add(cbcTaxAmount);
        RootXmlNode.AsXmlElement().Add(cacTaxTotal);

        cacTaxTotal1.AsXmlElement().Add(cbcTaxAmount1);


        cacTaxSubtotal.AsXmlElement().Add(cbcTaxableAmount);
        cacTaxSubtotal.AsXmlElement().Add(cbcTaxAmount2);


        cacTaxCategory1.AsXmlElement().Add(cbcID10);
        cacTaxCategory1.AsXmlElement().Add(cbcPercent);

        cacTaxScheme2.AsXmlElement().Add(cbcID11);
        cacTaxCategory1.AsXmlElement().Add(cacTaxScheme2);
        cacTaxSubtotal.AsXmlElement().Add(cacTaxCategory1);
        cacTaxTotal1.AsXmlElement().Add(cacTaxSubtotal);

        RootXmlNode.AsXmlElement().Add(cacTaxTotal1);



        cacLegalMonetaryTotal.AsXmlElement().Add(cbcLineExtensionAmount);
        cacLegalMonetaryTotal.AsXmlElement().Add(cbcTaxExclusiveAmount);
        cacLegalMonetaryTotal.AsXmlElement().Add(cbcTaxInclusiveAmount);
        cacLegalMonetaryTotal.AsXmlElement().Add(cbcAllowanceTotalAmount);
        cacLegalMonetaryTotal.AsXmlElement().Add(cbcPrepaidAmount);
        cacLegalMonetaryTotal.AsXmlElement().Add(cbcPayableAmount);
        RootXmlNode.AsXmlElement().Add(cacLegalMonetaryTotal);



        //Line creations
        //RootXmlNode := '';
        // XmlDoc.Add(RootXmlNode);
        SalesInvoiceLine.SetRange("Document No.", SalesHeaderRec."No.");
        SalesInvoiceLine.SetFilter(Type, '<>%1', SalesInvoiceLine.Type::" ");
        if SalesInvoiceLine.FindSet() then begin
            repeat
                _Counter := _Counter + 1;
                RootXmlNode := XMlElimentCreate(SalesInvoiceLine, _Counter);
            until SalesInvoiceLine.Next() = 0;
        end;
        XmlDoc.Add(RootXmlNode);
        XmlDoc.WriteTo(XmlResult);
        XmlResult := XmlResult.Replace(':Invoice123', '');
        XmlResult := XmlResult.Replace(' xmlns="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:ext="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:sac="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:cac="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:cbc="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:sbc="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:ds="*-123#"', '');
        XmlResult := XmlResult.Replace(' xmlns:xades="*-123#"', '');

        // Message(XmlResult);


        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        Base64Convert.FromBase64StringToStream(Base64Convert.TextToBase64String(XmlResult), OutStr);
        TempBlob.CreateInStream(inStr, TextEncoding::UTF8);

        ToFile := SalesHeaderRec."No." + ' - ' + Format(CurrentDateTime) + '.xml';
        SendOrderXMLToZATCA(inStr, SalesHeaderRec, PiHContant);
        //DownloadFromStream(inStr, 'Export', '', 'All Files (.)|.', ToFile);

        exit(XmlResult);

    end;

    var
        _Counter: Integer;

    local procedure XMlElimentCreate(SalesInvoiceLine: Record "Sales Line"; _Counter: Integer): XmlNode
    var
        cbcIDLine: XmlNode;
        cbcInvoicedQuantity: XmlNode;
        cbcLineExtensionAmountLine: XmlNode;
        cacTaxTotalLine: XmlNode;
        cbcTaxAmountLine: XmlNode;
        cbcRoundingAmount: XmlNode;
        cacItem: XmlNode;
        cbcName: XmlNode;
        cacClassifiedTaxCategory: XmlNode;
        cbcIDLine1: XmlNode;
        cbcPercentLine1: XmlNode;
        cacTaxSchemeLine: XmlNode;
        cbcIDLine2: XmlNode;
        cacPrice: XmlNode;
        cbcPriceAmount: XmlNode;
        cacAllowanceChargeLine: XmlNode;
        cbcChargeIndicatorLine: XmlNode;
        cbcAllowanceChargeReasonLine: XmlNode;
        cbcAmountLine: XmlNode;
        cacInvoiceLine: XmlNode;
        _text: Text;
    begin

        cacInvoiceLine := XmlElement.Create('InvoiceLine', '*-123#').AsXmlNode();
        cacInvoiceLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));


        cbcIDLine := XmlElement.Create('ID', '*-123#', _Counter).AsXmlNode();
        cbcIDLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcInvoicedQuantity := XmlElement.Create('InvoicedQuantity', '*-123#', Format(SalesInvoiceLine.Quantity)).AsXmlNode();
        cbcInvoicedQuantity.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcInvoicedQuantity.AsXmlElement().Add(XmlAttribute.Create('unitCode', Format(SalesInvoiceLine."Unit of Measure Code")));

        cbcLineExtensionAmountLine := XmlElement.Create('LineExtensionAmount', '*-123#', Format(SalesInvoiceLine."Line Amount").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcLineExtensionAmountLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcLineExtensionAmountLine.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cacTaxTotalLine := XmlElement.Create('TaxTotal', '*-123#').AsXmlNode();
        cacTaxTotalLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcTaxAmountLine := XmlElement.Create('TaxAmount', '*-123#', Format(SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine."Line Amount").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcTaxAmountLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcTaxAmountLine.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cbcRoundingAmount := XmlElement.Create('RoundingAmount', '*-123#', Format(SalesInvoiceLine."Amount Including VAT").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcRoundingAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcRoundingAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cacItem := XmlElement.Create('Item', '*-123#').AsXmlNode();
        cacItem.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcName := XmlElement.Create('Name', '*-123#', Format(SalesInvoiceLine.Description)).AsXmlNode();
        cbcName.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacClassifiedTaxCategory := XmlElement.Create('ClassifiedTaxCategory', '*-123#').AsXmlNode();
        cacClassifiedTaxCategory.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcIDLine1 := XmlElement.Create('ID', '*-123#', 'S').AsXmlNode();
        cbcIDLine1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcPercentLine1 := XmlElement.Create('Percent', '*-123#', '15').AsXmlNode();
        cbcPercentLine1.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacTaxSchemeLine := XmlElement.Create('TaxScheme', '*-123#').AsXmlNode();
        cacTaxSchemeLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcIDLine2 := XmlElement.Create('ID', '*-123#', 'VAT').AsXmlNode();
        cbcIDLine2.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cacPrice := XmlElement.Create('Price', '*-123#').AsXmlNode();
        cacPrice.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcPriceAmount := XmlElement.Create('PriceAmount', '*-123#', Format(SalesInvoiceLine."Unit Price").Replace(',', '').Replace('.00', '')).AsXmlNode();
        cbcPriceAmount.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcPriceAmount.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));

        cacAllowanceChargeLine := XmlElement.Create('AllowanceCharge', '*-123#').AsXmlNode();
        cacAllowanceChargeLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cac', '*-123#'));

        cbcChargeIndicatorLine := XmlElement.Create('ChargeIndicator', '*-123#', 'false').AsXmlNode();
        cbcChargeIndicatorLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcAllowanceChargeReasonLine := XmlElement.Create('AllowanceChargeReason', '*-123#', 'discount').AsXmlNode();
        cbcAllowanceChargeReasonLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));

        cbcAmountLine := XmlElement.Create('Amount', '*-123#', '0.00').AsXmlNode();
        cbcAmountLine.AsXmlElement().Add(XmlAttribute.CreateNamespaceDeclaration('cbc', '*-123#'));
        cbcAmountLine.AsXmlElement().Add(XmlAttribute.Create('currencyID', Format(_DefaultCurrencyCode)));


        cacInvoiceLine.AsXmlElement().Add(cbcIDLine);
        cacInvoiceLine.AsXmlElement().Add(cbcInvoicedQuantity);
        cacInvoiceLine.AsXmlElement().Add(cbcLineExtensionAmountLine);

        cacTaxTotalLine.AsXmlElement().Add(cbcTaxAmountLine);
        cacTaxTotalLine.AsXmlElement().Add(cbcRoundingAmount);
        cacInvoiceLine.AsXmlElement().Add(cacTaxTotalLine);
        cacItem.AsXmlElement().Add(cbcName);

        cacClassifiedTaxCategory.AsXmlElement().Add(cbcIDLine1);
        cacClassifiedTaxCategory.AsXmlElement().Add(cbcPercentLine1);

        cacTaxSchemeLine.AsXmlElement().Add(cbcIDLine2);
        cacClassifiedTaxCategory.AsXmlElement().Add(cacTaxSchemeLine);
        cacItem.AsXmlElement().Add(cacClassifiedTaxCategory);
        cacInvoiceLine.AsXmlElement().Add(cacItem);
        cacPrice.AsXmlElement().Add(cbcPriceAmount);
        cacAllowanceChargeLine.AsXmlElement().Add(cbcChargeIndicatorLine);
        cacAllowanceChargeLine.AsXmlElement().Add(cbcAllowanceChargeReasonLine);
        cacAllowanceChargeLine.AsXmlElement().Add(cbcAmountLine);
        cacPrice.AsXmlElement().Add(cacAllowanceChargeLine);

        cacInvoiceLine.AsXmlElement().Add(cacPrice);
        RootXmlNode.AsXmlElement().Add(cacInvoiceLine);
        //     RootXmlNode.WriteTo(_text);
        exit(RootXmlNode);
    end;


    procedure SendOrderXMLToZATCA(FileStream: InStream; var SalesHeader: Record "Sales Header"; PiHContant: Text[250])//for upload on AZure
    var
        ABSBlobClient: codeunit "ABS Blob Client";
        Authorization: Interface "Storage Service Authorization";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        tempBlob: Codeunit "Temp Blob";
        Filename: Text;
        tbl_ZatcaSetup: Record "E-Invoicing Zatca Setup";

    begin
        //@@HA
        tbl_ZatcaSetup.Reset();
        if tbl_ZatcaSetup.FindFirst() then begin
            Authorization := StorageServiceAuthorization.CreateSharedKey(tbl_ZatcaSetup."E-Invoice Storage Account Access Key");//?? need to under stand with mateen
            ABSBlobClient.Initialize(LowerCase(tbl_ZatcaSetup."E-Invoice Storage Account Name"), LowerCase(tbl_ZatcaSetup."E-Invoice Contaier Name"), Authorization);

            Filename := 'Invoice.xml';
            ABSBlobClient.PutBlobBlockBlobStream(Filename, FileStream);
            EncryptAndGetSignedXML(SalesHeader, PiHContant);
        end;
    end;



    procedure EncryptAndGetSignedXML(var SalesHeader: Record "Sales Header"; PiHContant: Text[250]): Text
    var
        Client: HttpClient;
        Content: HttpContent;
        ResponseMessage: HttpResponseMessage;
        contentHeaders: HttpHeaders;
        request: HttpRequestMessage;
        Url: Text;
        ResponseText: text;
        PayloadTxt: Text;
        Envinfo_lRec: Codeunit "Environment Information";
        ZatcaApiUrl: Text;
        companyinfo_lRec: Record "Company Information";
        tbl_ZatcaSetup: Record "E-Invoicing Zatca Setup";

    begin
        Clear(PayloadTxt);
        tbl_ZatcaSetup.Reset();
        if tbl_ZatcaSetup.FindFirst() then begin

        end;
        url := tbl_ZatcaSetup."E-Invoice HTTP Triger func. URL"; //new url DSSS //http triger function we will use defult function key
        if Envinfo_lRec.IsProduction() = true then
            PayloadTxt := CreateLinesPayloadCore(tbl_ZatcaSetup, SalesHeader)    //Core means Production
        else
            if Envinfo_lRec.IsProduction() = false then
                PayloadTxt := CreateLinesPayloadSimulation(tbl_ZatcaSetup, SalesHeader); // simulation means Sandbox
        //Message('%1', PayloadTxt);
        content.WriteFrom(PayLoadTxt);
        content.GetHeaders(contentHeaders);
        contentHeaders.Clear();
        request.Content := content;
        request.SetRequestUri(Url);
        request.Method := 'POST';
        if not client.Send(request, ResponseMessage) then begin
            Message('The call to zatcaeinvoicing webservice is failed');
            exit;
        end;
        if not ResponseMessage.IsSuccessStatusCode() then begin
            Message(format(ResponseMessage));
            exit;
        end;

        ResponseMessage.Content().ReadAs(ResponseText);
        // Message(ResponseText);
        ReadZATCARespons(ResponseText, SalesHeader, PiHContant);
    end;

    procedure CreateLinesPayloadSimulation(tbl_ZatcaSetup: Record "E-Invoicing Zatca Setup"; var SalesHeader: Record "Sales Header") LinesPyload: text
    var

        JsonObjectLines: JsonObject;
        JsonObjectLinesLoad: Text;
        _GuidToText: Text;
        _Counter: Integer;
        _SystemID: Text;
    begin
        Clear(LinesPyload);
        Clear(JsonObjectLines);
        Clear(JsonObjectLinesLoad);
        JsonObjectLines.Add('fileName', Format('Invoice.xml'));
        _SystemID := Format(SalesHeader.SystemId);
        _SystemID := _SystemID.Replace('{', '');
        _SystemID := _SystemID.Replace('}', '');
        JsonObjectLines.Add('UUID', Format(SalesHeader.SystemId).TrimStart('{').TrimEnd('}'));
        JsonObjectLines.Add('zatcaAPIUrl', tbl_ZatcaSetup."E-Invoice ZATCA-Env. Simulation");
        JsonObjectLines.Add('pCSID', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Simulation Production CSID")));
        JsonObjectLines.Add('pSecret', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Simulation Production Secret")));
        JsonObjectLines.Add('certificateContent', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Simulation Certificate")));
        JsonObjectLines.Add('privateKey', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Simulation Private Key")));
        JsonObjectLines.Add('pihContent', GetInvoiceHash());
        JsonObjectLines.WriteTo(JsonObjectLinesLoad);
        LinesPyload := JsonObjectLinesLoad;
        exit(LinesPyload)
    end;

    procedure CreateLinesPayloadCore(tbl_ZatcaSetup: Record "E-Invoicing Zatca Setup"; var SalesHeader: Record "Sales Header") LinesPyload: text
    var

        JsonObjectLines: JsonObject;
        JsonObjectLinesLoad: Text;
        _GuidToText: Text;
        _Counter: Integer;
    begin
        Clear(LinesPyload);
        Clear(JsonObjectLines);
        Clear(JsonObjectLinesLoad);
        JsonObjectLines.Add('fileName', Format('Invoice.xml'));
        JsonObjectLines.Add('UUID', Format(SalesHeader.SystemId).TrimStart('{').TrimEnd('}'));
        JsonObjectLines.Add('zatcaAPIUrl', tbl_ZatcaSetup."E-Invoice ZATCA-Env. Production");
        JsonObjectLines.Add('pCSID', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Core Production CSID")));
        JsonObjectLines.Add('pSecret', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Core Production Secret")));
        JsonObjectLines.Add('certificateContent', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Core Certificate")));
        JsonObjectLines.Add('privateKey', tbl_ZatcaSetup.GetCoreCertificateDescription1(tbl_ZatcaSetup.FieldNo("E-Invoice Core Private Key")));
        JsonObjectLines.Add('pihContent', GetInvoiceHash());
        JsonObjectLines.WriteTo(JsonObjectLinesLoad);
        exit(LinesPyload)
    end;

    procedure ReadZATCAResponse(ResponseTxt: Text; SalesHeader: Record "Sales Header"): Text
    var
        JsonBuffer: Record "Json Buffer" Temporary;
        PaymentResponse: Text;
    begin
        JsonBuffer.DeleteAll();

        JsonBuffer.ReadFromText(ResponseTxt);
        Clear(PaymentResponse);

        JsonBuffer.SetFilter("Token type", '<>%1', JsonBuffer."Token type"::"Property Name");
        If JsonBuffer.FindSet() then
            repeat

                if (JsonBuffer.Path = 'clearanceStatus') then begin
                    if UpperCase(JsonBuffer.Value) = 'CLEARED' then
                        SalesHeader.Validate("E-Invoice Cleared By ZATCA", true);

                    SalesHeader.Validate("E-Invoice Clearance Status", JsonBuffer.Value);
                end;

                if (JsonBuffer.Path = 'clearedInvoice') then begin
                    SalesHeader.SetZATCADescription(JsonBuffer.Value, '');
                end;
            until JsonBuffer.Next = 0;
        Message(ResponseTxt);
        SalesHeader.Modify();
    end;

    procedure ReadZATCARespons(ResponseTxt: Text; var SalesHeader: Record "Sales Header"; PiHContant: Text[250])
    var
        JsonResponse: JsonObject;
        Jsontokenvalue: JsonToken;
        jsonOrder: JsonObject;
        Doctype: Text;
        ObjectJSONManagement: Codeunit "JSON Management";
        clearanceStatusTxt: Text;
        clearedInvoiceTxt: Text;
        LengthOFString: Integer;
        HardcodeString: text;
        LengthOFHardcode: Integer;
        PositionOFHardCodeString: Integer;
        AssumedPositionOfExtractedData: Integer;
        LengthOFExtractedDataShouldBe: Integer;
        ExtractedData: Text[250];
        Companyinfo_lRec: Record "Company Information";
        ToText: Text;
        Base64Convert: Codeunit "Base64 Convert";
        Cu_XMLReader: Codeunit "XML XMLReader";
    begin
        Clear(clearedInvoiceTxt);
        Clear(clearanceStatusTxt);
        ObjectJSONManagement.InitializeObject(ResponseTxt);
        ObjectJSONManagement.GetStringPropertyValueByName('httpTriggerError', clearedInvoiceTxt);
        if clearedInvoiceTxt = 'Error' then begin
            SalesHeader.Validate("E-Invoice Cleared By ZATCA", false);
            SalesHeader.Validate("E-Invoice Clearance Status", 'API Call Fail');
            SalesHeader.SetZATCADescription(clearedInvoiceTxt, '');
        end else begin
            ObjectJSONManagement.GetStringPropertyValueByName('clearedInvoice', clearedInvoiceTxt);
            ObjectJSONManagement.GetStringPropertyValueByName('clearanceStatus', clearanceStatusTxt);
            case UpperCase(clearanceStatusTxt) of
                'CLEARED':
                    begin
                        SalesHeader.Validate("E-Invoice Cleared By ZATCA", true);
                        SalesHeader.Validate("E-Invoice Clearance Status", UpperCase(clearanceStatusTxt));
                        SalesHeader."E-Invoice ZATCA Pih Hash" := PiHContant;
                    end;
                else begin
                    begin
                        SalesHeader.Validate("E-Invoice Cleared By ZATCA", false);
                        SalesHeader.Validate("E-Invoice Clearance Status", UpperCase(clearanceStatusTxt));
                    end;
                end;

            end;
            if clearedInvoiceTxt <> '' then begin
                ToText := Base64Convert.FromBase64(clearedInvoiceTxt);
                SalesHeader.SetZATCADescription(clearedInvoiceTxt, Cu_XMLReader.GetEmbeddedDocumentBinaryObjectValue(ToText));
            end;

        end;
        if clearanceStatusTxt = 'CLEARED' then begin
            if Companyinfo_lRec.Get() then
                LengthOFString := StrLen(ResponseTxt);
            HardcodeString := '"invoiceHash":';
            PositionOFHardCodeString := StrPos(ResponseTxt, HardcodeString);
            LengthOFHardcode := StrLen(HardcodeString);
            AssumedPositionOfExtractedData := PositionOFHardCodeString + LengthOFHardcode + 2;
            LengthOFExtractedDataShouldBe := (LengthOFString - AssumedPositionOfExtractedData) - 1;
            ExtractedData := CopyStr(ResponseTxt, AssumedPositionOfExtractedData, LengthOFExtractedDataShouldBe);
            Companyinfo_lRec."E-Invoice Invoice Hash" := ExtractedData;
            Companyinfo_lRec.Modify();
        end;
        SalesHeader.Modify();
    end;

    var
        myInt: Integer;
        invhash: Text;
        strpos: Integer;
        endpos: Integer;

        CU_GenerateQR: Codeunit "Generate QR Code";
        _DefaultCurrencyCode: Code[10];
        CompanyInfo: Record "Company Information";
        Customer_Rec: Record Customer;
        SalesInvoiceLine: Record "Sales Line";

        xmlElem2: XmlElement;
        xmlElem3: XmlElement;
        RootXmlNode: XmlNode;
        xmlElem4: XmlElement;
        XmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;
        SignatureNode: XmlNode;
        RootNode: XmlNode;
        XmlResult: Text;
        NanmeSp: XmlNamespaceManager;
        ns1: Text[50];
        prefix: Text[5];
        localName: Text[10];
        SignatureTxtBold: TextConst ENU = '<b>signature</b>';
        RootNameSpaceURL: Text;
        XmlElm: XmlElement;
        dsSignatureXmlNode: XmlNode;
        TempBlob: Codeunit "Temp Blob";
        inStr: InStream;
        OutStr: OutStream;
        ToFile: Text;
        Base64Convert: Codeunit Base64ConrtDSSS;
        extUBLExtensionsNode: XmlNode;
        extUBLExtensionNode: XmlNode;
        extExtensionContent: XMlNode;
        extExtensionURINode: XmlNode;
        sigUBLDocumentSignatures: XmlNode;
        SacSignatureInformation: XmlNode;
        CBCNode: XmlNode;
        SBCNode: XmlNode;
        dsSignedInfo: XmlNode;
        dsCanonicalizationMethod: XmlNode;
        dsSignatureMethod: XmlNode;
        dsReference: XmlNode;
        dsTransforms: xmlnode;
        dsTransform1: xmlnode;
        dsTransformXpath1: XmlNode;
        dsTransform2: xmlnode;
        dsTransformXpath2: XmlNode;
        dsTransform3: xmlnode;
        dsTransformXpath3: XmlNode;
        dsTransform4: xmlnode;
        dsDigestMethod: XmlNode;
        dsDigestValue: XmlNode;
        dsReference1: XmlNode;
        dsDigestMethod1: XmlNode;
        dsDigestValue1: XmlNode;
        dsSignatureValue: xmlNOde;
        dsKeyInfo: XmlNode;
        dsX509Data: XmlNode;
        dsX509Certificate: XmlNode;
        dsObject: XmlNode;
        xadesQualifyingProperties: XmlNode;
        xadesSignedProperties: xmlnode;
        xadesSignedSignatureProperties: XmlNode;
        xadesSigningTime: XmlNode;
        xadesSigningCertificate: XmlNode;
        xadesCert: xmlnode;
        xadesCertDigest: xmlnode;
        dsDigestMethod2: XmlNode;
        dsDigestValue2: XmlNode;
        xadesIssuerSerial: xmlnode;
        dsX509IssuerName: XmlNode;
        dsX509SerialNumber: XmlNode;
        cbcProfileID: XmlNode;
        cbcID: XmlNode;
        cbcUUID: XmlNode;
        cbcIssueDate: XmlNode;
        cbcIssueTime: XmlNode;
        cbcInvoiceTypeCode: XmlNode;
        cbcDocumentCurrencyCode: XmlNode;
        cbcTaxCurrencyCode: XmlNode;
        cacAdditionalDocumentReference: XmlNode;
        cbcID1: XmlNode;
        cbcUUID1: XmlNode;
        cacAdditionalDocumentReference1: xmlnode;
        cbcID2: xmlnode;
        cacAttachment: XmlNode;
        cbcEmbeddedDocumentBinaryObject: xmlnode;
        cacAdditionalDocumentReference2: xmlnode;
        cbcID3: xmlnode;
        cacAttachment2: XmlNode;
        cbcEmbeddedDocumentBinaryObject2: xmlnode;
        cacSignature: XmlNode;
        cbcID4: XmlNode;
        cbcSignatureMethod: XmlNode;
        cacAccountingSupplierParty: XmlNode;
        cacParty: XmlNode;
        cacPartyIdentification: XmlNode;
        cbcID5: XmlNode;
        cacPostalAddress: XmlNode;
        cbcStreetName: XmlNode;
        cbcBuildingNumber: XmlNode;
        cbcPlotIdentification: XmlNode;
        cbcCitySubdivisionName: XmlNode;
        cbcCityName: XmlNode;
        cbcPostalZone: XmlNode;
        cacCountry: XmlNode;
        cbcIdentificationCode: XmlNode;
        cacPartyTaxScheme: XmlNode;
        cbcCompanyID: XmlNode;

        cacTaxScheme: XmlNode;
        cbcID6: XmlNode;

        cacPartyLegalEntity: XmlNode;
        cbcRegistrationName: XmlNode;

        cacAccountingCustomerParty: XmlNode;
        cacParty1: XmlNode;
        cacPartyIdentification1: XmlNode;
        cbcCitySubdivisionName1: XmlNode;
        cbcCityName1: XmlNode;
        cbcPostalZone1: XmlNode;
        cacCountry1: XmlNode;
        cbcIdentificationCode1: XmlNode;
        cacPartyTaxScheme1: XmlNode;
        cacPostalAddress1: XmlNode;
        cbcStreetName1: XmlNode;
        cbcBuildingNumber1: XmlNode;
        cacTaxScheme1: XmlNode;
        cbcPlotIdentification1: XmlNode;
        cbcID7: XmlNode;
        cbcID8: XmlNode;

        cacDeliveryNode: XmlNode;
        cbcActualDeliveryDateNode: XmlNode;
        cacPaymentMeansNode: XmlNode;
        cbcPaymentMeansCodeNode: XmlNode;
        cacAllowanceCharge: XmlNode;
        cbcChargeIndicator: XmlNode;
        cbcAllowanceChargeReason: XmlNode;
        cbcAmount: XmlNode;
        cacTaxCategory: XmlNode;
        cacTaxCategorycbcID: XmlNode;
        cbcPercent: XmlNode;
        cacTaxCategorycacTaxScheme: XmlNode;
        cacTaxSchemecbcID: XmlNode;

        cacPartyLegalEntity1: XmlNode;
        cbcRegistrationName1: XmlNode;

        PartyLegalEntity: XmlNode;
        cacTaxTotal: XmlNode;
        cbcTaxAmount: XmlNode;
        cacTaxTotal1: XmlNode;
        cbcTaxAmount1: XmlNode;
        cacTaxSubtotal: XmlNode;
        cbcTaxableAmount: XmlNode;
        cbcTaxAmount2: XmlNode;
        cacTaxCategory1: XmlNode;
        cbcID10: XmlNode;
        sbsPercent1: XmlNode;
        cacTaxScheme2: XmlNode;
        cbcID11: XmlNode;
        cacLegalMonetaryTotal: XmlNode;
        cbcLineExtensionAmount: XmlNode;
        cbcTaxExclusiveAmount: XmlNode;
        cbcTaxInclusiveAmount: XmlNode;
        cbcAllowanceTotalAmount: XmlNode;
        cbcPrepaidAmount: XmlNode;
        cbcPayableAmount: XmlNode;


        cacInvoiceLine: XmlNode;




        XMLNameSpaceMgr: XmlNamespaceManager;
        XML: XmlPort "Sales Invoice - PEPPOL 2.1";
        XMBuffer: Record "XML Buffer";
        PiHContant: Text[250];
}