xmlport 70503 "Tax Invoice Final XML DSSS"
{
    Caption = 'Tax Invoice XML';

    UseRequestPage = false;
    // DefaultNamespace = 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03';
    Direction = Export;
    Encoding = UTF8;
    // Format = Xml;
    // FormatEvaluate = Xml;
    // XmlVersionNo = V10;
    // UseDefaultNamespace = false;
    // Namespaces = xsi = 'xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance xmlns:xsd=http://www.w3.org/2001/XMLSchema xmlns:cac=urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2 xmlns:cbc=urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

    // Namespaces = "" = 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2 xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance xmlns:xsd=http://www.w3.org/2001/XMLSchema xmlns:cac=urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2 xmlns:cbc=urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

    Namespaces = "" = 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2', cac = 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2', cbc = 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2', ext = 'urn:oasis:names:specification:ubl:schema:xsd:CommonExtensionComponents-2';

    schema
    {
        tableelement(invoiceheaderloop; Integer)
        {
            MaxOccurs = Once;
            XmlName = 'Invoice';
            SourceTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));


            textelement(UBLExtensions)
            {
                NamespacePrefix = 'ext';

                textelement(UBLExtension)
                {
                    XmlName = 'UBLExtensions';
                    NamespacePrefix = 'ext';

                    textelement(ExtensionURI)
                    {
                        XmlName = 'ExtensionURI';
                        NamespacePrefix = 'ext';
                        trigger OnBeforePassVariable()

                        begin
                            ExtensionURI := 'urn:oasis:names:specification:ubl:dsig:enveloped:xades';
                        end;
                    }

                    textelement(ExtensionContent)
                    {
                        XmlName = 'ExtensionContent';
                        NamespacePrefix = 'ext';


                        textelement(UBLDocumentSignatures)
                        {
                            XmlName = 'UBLDocumentSignatures';
                            NamespacePrefix = 'sig';

                            textattribute(DSignatures)
                            {
                                XmlName = 'xmlns:Sig';

                                trigger OnBeforePassVariable()

                                begin
                                    DSignatures := 'urn:oasis:names:specification:ubl:schema:xsd:CommonSignatureComponents-2';
                                end;
                            }
                            textattribute(sac)
                            {
                                XmlName = 'xmlns:sac';

                                trigger OnBeforePassVariable()

                                begin
                                    sac := 'urn:oasis:names:specification:ubl:schema:xsd:SignatureAggregateComponents-2';
                                end;
                            }
                            textattribute(sbc)
                            {
                                XmlName = 'xmlns:sbc';

                                trigger OnBeforePassVariable()

                                begin
                                    sbc := 'urn:oasis:names:specification:ubl:schema:xsd:SignatureBasicComponents-2';
                                end;
                            }

                            textelement(SignatureInformation)
                            {
                                XmlName = 'SignatureInformation';
                                NamespacePrefix = 'sac';

                                textelement(SignatureInfor)
                                {
                                    XmlName = 'ID';
                                    NamespacePrefix = 'cbc';
                                    trigger OnBeforePassVariable()

                                    begin
                                        SignatureInfor := 'urn:oasis:names:specification:ubl:signature:1';
                                    end;
                                }
                                textelement(ReferencedSignatureID)
                                {
                                    XmlName = 'ReferencedSignatureID';
                                    NamespacePrefix = 'sbc';
                                    trigger OnBeforePassVariable()

                                    begin
                                        ReferencedSignatureID := 'urn:oasis:names:specification:ubl:signature:Invoice';
                                    end;
                                }

                                textelement("Signature")
                                {
                                    XmlName = 'Signature';
                                    NamespacePrefix = 'ds';

                                    textattribute(dss)
                                    {

                                        XmlName = 'xmlns:Ds';
                                       //NamespacePrefix = 'ds';
                                        trigger OnBeforePassVariable()
                                        begin
                                            dss := 'http://www.w3.org/2000/09/xmldsig#';
                                        end;
                                    }
                                    textattribute(ids)
                                    {
                                        XmlName = 'id';
                                        trigger OnBeforePassVariable()
                                        begin
                                            ids := 'signature';
                                        end;
                                    }
                                    textelement(SignedInfo)
                                    {
                                        XmlName = 'SignedInfo';
                                        NamespacePrefix = 'ds';

                                        textelement(CanonicalizationMethod)
                                        {
                                            XmlName = 'CanonicalizationMethod';
                                            NamespacePrefix = 'ds';

                                            textattribute(Algorithm)
                                            {
                                                XmlName = 'Algorithm';

                                                trigger OnBeforePassVariable()
                                                begin
                                                    Algorithm := 'http://www.w3.org/2006/12/xml-c14n11';
                                                end;
                                            }
                                        }
                                        textelement(SignatureMethod)
                                        {
                                            XmlName = 'SignatureMethod';
                                            NamespacePrefix = 'ds';
                                            textattribute(Algorithm2)
                                            {
                                                XmlName = 'Algorithm';

                                                trigger OnBeforePassVariable()

                                                begin
                                                    Algorithm2 := 'http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha256';
                                                end;
                                            }
                                        }

                                        textelement(Reference)
                                        {
                                            XmlName = 'Reference';
                                            NamespacePrefix = 'ds';

                                            textattribute(Rid)
                                            {
                                                XmlName = 'Id';


                                                trigger OnBeforePassVariable()

                                                begin
                                                    Rid := 'invoiceSignedData';
                                                end;
                                            }
                                            textattribute(URI)
                                            {
                                                XmlName = 'URI';
                                                trigger OnBeforePassVariable()
                                                begin
                                                    URI := '';
                                                end;
                                            }

                                            textelement(Transforms)
                                            {
                                                XmlName = 'Transforms';
                                                NamespacePrefix = 'ds';


                                                textelement(Transform)
                                                {
                                                    XmlName = 'Transform';
                                                    NamespacePrefix = 'ds';

                                                    textattribute(Algorithm3)
                                                    {
                                                        XmlName = 'Algorithm';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            Algorithm3 := 'http://www.w3.org/TR/1999/REC-xpath-19991116';
                                                        end;
                                                    }
                                                    textelement(XPath)
                                                    {
                                                        XmlName = 'XPath';
                                                        NamespacePrefix = 'ds';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            XPath := 'not(//ancestor-or-self::ext:UBLExtensions)';
                                                        end;
                                                    }
                                                }
                                                textelement(Transform2)
                                                {
                                                    XmlName = 'Transform';
                                                    NamespacePrefix = 'ds';

                                                    textattribute(Algorithm4)
                                                    {
                                                        XmlName = 'Algorithm';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            Algorithm4 := 'http://www.w3.org/TR/1999/REC-xpath-19991116';
                                                        end;
                                                    }
                                                    textelement(XPath2)
                                                    {
                                                        XmlName = 'XPath';
                                                        NamespacePrefix = 'ds';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            XPath2 := 'not(//ancestor-or-self::cac:Signature)';
                                                        end;
                                                    }
                                                }

                                                textelement(Transform3)
                                                {
                                                    XmlName = 'Transform';
                                                    NamespacePrefix = 'ds';

                                                    textattribute(Algorithm5)
                                                    {
                                                        XmlName = 'Algorithm';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            Algorithm5 := 'http://www.w3.org/TR/1999/REC-xpath-19991116';
                                                        end;
                                                    }
                                                    textelement(XPath3)
                                                    {
                                                        XmlName = 'XPath';
                                                        NamespacePrefix = 'ds';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            XPath3 := 'not(//ancestor-or-self::cac:AdditionalDocumentReference[cbc:ID=QR])';
                                                        end;
                                                    }
                                                }
                                                textelement(Transform4)
                                                {
                                                    XmlName = 'Transform';
                                                    NamespacePrefix = 'ds';

                                                    textattribute(Algorithm6)
                                                    {
                                                        XmlName = 'Algorithm';
                                                        trigger OnBeforePassVariable()

                                                        begin
                                                            Algorithm6 := 'http://www.w3.org/2006/12/xml-c14n11';
                                                        end;
                                                    }
                                                }

                                            }
                                            textelement(DigestMethod)
                                            {
                                                XmlName = 'DigestMethod';
                                                NamespacePrefix = 'ds';

                                                textattribute(Algorithm7)
                                                {
                                                    XmlName = 'Algorithm';
                                                    trigger OnBeforePassVariable()

                                                    begin
                                                        Algorithm7 := 'http://www.w3.org/2001/04/xmlenc#sha256';
                                                    end;
                                                }
                                            }
                                            textelement(DigestValue)
                                            {
                                                XmlName = 'DigestValue';
                                                NamespacePrefix = 'ds';
                                                trigger OnBeforePassVariable()

                                                begin
                                                    DigestValue := 'WI6GNwty4XrTc3P1WrRM1xlhqz9TimXdCLH9sgmj0Sg=';
                                                end;

                                            }
                                        }
                                        textelement(ReferenceT)
                                        {
                                            XmlName = 'Reference';
                                            NamespacePrefix = 'ds';

                                            textattribute(Rtype)
                                            {
                                                XmlName = 'Type';

                                                trigger OnBeforePassVariable()

                                                begin
                                                    Rtype := 'http://www.w3.org/2000/09/xmldsig#SignatureProperties';
                                                end;
                                            }
                                            textattribute(URIT)
                                            {
                                                XmlName = 'URI';
                                                trigger OnBeforePassVariable()
                                                begin
                                                    URIT := '#xadesSignedProperties';
                                                end;
                                            }

                                            textelement(DigestMethod2)
                                            {
                                                XmlName = 'DigestMethod';
                                                NamespacePrefix = 'ds';

                                                textattribute(Algorithm8)
                                                {
                                                    XmlName = 'Algorithm';
                                                    trigger OnBeforePassVariable()

                                                    begin
                                                        Algorithm8 := 'http://www.w3.org/2001/04/xmlenc#sha256';
                                                    end;
                                                }
                                            }
                                            textelement(DigestValue2)
                                            {
                                                XmlName = 'DigestValue';
                                                NamespacePrefix = 'ds';
                                                trigger OnBeforePassVariable()

                                                begin
                                                    DigestValue2 := 'ZjU2ZjM4YTExODRmNzE0ZjIxODA4MDYxYjhiMzdmM2JlMTJiNWQ0N2E2YjhjNzQwMjg2NDBkMzJlM2MxNjM2Nw==';
                                                end;

                                            }
                                        }
                                    }
                                    textelement(SignatureValue)
                                    {
                                        XmlName = 'SignatureValue';
                                        NamespacePrefix = 'ds';
                                        trigger OnBeforePassVariable()

                                        begin
                                            SignatureValue := 'MEUCIQCCGL7AJacVObs7luFYTbsqKr9qLZX+LYjZivOjDNnaYgIgT0SrZZKk3L8fzV8/J7h9p7wH0BoqplW0RBcWOVNeW0w=';
                                        end;

                                    }

                                    textelement(KeyInfo)
                                    {
                                        XmlName = 'KeyInfo';
                                        NamespacePrefix = 'ds';

                                        textelement(X509Data)
                                        {
                                            XmlName = 'X509Data';
                                            NamespacePrefix = 'ds';

                                            textelement(X509Certificate)
                                            {
                                                XmlName = 'X509Certificate';
                                                NamespacePrefix = 'ds';

                                                trigger OnBeforePassVariable()

                                                begin
                                                    X509Certificate := 'MIID6TCCA5CgAwIBAgITbwAAf8tem6jngr16DwABAAB/yzAKBggqhkjOPQQDAjBjMRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxEzARBgoJkiaJk/IsZAEZFgNnb3YxFzAVBgoJkiaJk/IsZAEZFgdleHRnYXp0MRwwGgYDVQQDExNUU1pFSU5WT0lDRS1TdWJDQS0xMB4XDTIyMDkxNDEzMjYwNFoXDTI0MDkxMzEzMjYwNFowTjELMAkGA1UEBhMCU0ExEzARBgNVBAoTCjMxMTExMTExMTExDDAKBgNVBAsTA1RTVDEcMBoGA1UEAxMTVFNULTMxMTExMTExMTEwMTExMzBWMBAGByqGSM49AgEGBSuBBAAKA0IABGGDDKDmhWAITDv7LXqLX2cmr6+qddUkpcLCvWs5rC2O29W/hS4ajAK4Qdnahym6MaijX75Cg3j4aao7ouYXJ9GjggI5MIICNTCBmgYDVR0RBIGSMIGPpIGMMIGJMTswOQYDVQQEDDIxLVRTVHwyLVRTVHwzLWE4NjZiMTQyLWFjOWMtNDI0MS1iZjhlLTdmNzg3YTI2MmNlMjEfMB0GCgmSJomT8ixkAQEMDzMxMTExMTExMTEwMTExMzENMAsGA1UEDAwEMTEwMDEMMAoGA1UEGgwDVFNUMQwwCgYDVQQPDANUU1QwHQYDVR0OBBYEFDuWYlOzWpFN3no1WtyNktQdrA8JMB8GA1UdIwQYMBaAFHZgjPsGoKxnVzWdz5qspyuZNbUvME4GA1UdHwRHMEUwQ6BBoD+GPWh0dHA6Ly90c3RjcmwuemF0Y2EuZ292LnNhL0NlcnRFbnJvbGwvVFNaRUlOVk9JQ0UtU3ViQ0EtMS5jcmwwga0GCCsGAQUFBwEBBIGgMIGdMG4GCCsGAQUFBzABhmJodHRwOi8vdHN0Y3JsLnphdGNhLmdvdi5zYS9DZXJ0RW5yb2xsL1RTWkVpbnZvaWNlU0NBMS5leHRnYXp0Lmdvdi5sb2NhbF9UU1pFSU5WT0lDRS1TdWJDQS0xKDEpLmNydDArBggrBgEFBQcwAYYfaHR0cDovL3RzdGNybC56YXRjYS5nb3Yuc2Evb2NzcDAOBgNVHQ8BAf8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMDMCcGCSsGAQQBgjcVCgQaMBgwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwMwCgYIKoZIzj0EAwIDRwAwRAIgOgjNPJW017lsIijmVQVkP7GzFO2KQKd9GHaukLgIWFsCIFJF9uwKhTMxDjWbN+1awsnFI7RLBRxA/6hZ+F1wtaqU</ds:X509Certificate>';
                                                end;
                                            }
                                        }
                                    }

                                    textelement(Object)
                                    {
                                        XmlName = 'Object';
                                        NamespacePrefix = 'ds';

                                        textelement(QualifyingProperties)
                                        {
                                            XmlName = 'QualifyingProperties';
                                            NamespacePrefix = 'xades';

                                            textattribute(Qualifypro)
                                            {
                                                XmlName = 'xmlns:xade';

                                                trigger OnBeforePassVariable()

                                                begin
                                                    Qualifypro := 'http://uri.etsi.org/01903/v1.3.2#';
                                                end;
                                            }
                                            textattribute(Traget)
                                            {
                                                XmlName = 'Traget';
                                                trigger OnBeforePassVariable()
                                                begin
                                                    Traget := 'signature';
                                                end;
                                            }

                                            textelement(SignedProperties)
                                            {
                                                XmlName = 'SignedProperties';
                                                NamespacePrefix = 'xades';

                                                textattribute(idTraget)
                                                {
                                                    XmlName = 'Id';
                                                    trigger OnBeforePassVariable()
                                                    begin
                                                        idTraget := 'xadesSignedProperties';
                                                    end;
                                                }

                                                textelement(SignedSignatureProperties)
                                                {
                                                    XmlName = 'SignedSignatureProperties';
                                                    NamespacePrefix = 'xades';
                                                    textelement(SigningTime)
                                                    {
                                                        NamespacePrefix = 'xades';
                                                        XmlName = 'SigningTime';
                                                        trigger OnBeforePassVariable()
                                                        begin
                                                            SigningTime := '0921-09-15T01:45:47Z';
                                                        end;
                                                    }


                                                }
                                                textelement(SigningCertificate)
                                                {
                                                    XmlName = 'SigningCertificate';
                                                    NamespacePrefix = 'xades';

                                                    textelement(Cert)
                                                    {
                                                        XmlName = 'Cert';
                                                        NamespacePrefix = 'xades';

                                                        textelement(CertDigest)
                                                        {
                                                            XmlName = 'CertDigest';
                                                            NamespacePrefix = 'xades';


                                                            textelement(DigestMethod3)
                                                            {
                                                                XmlName = 'DigestMethod';
                                                                NamespacePrefix = 'ds';

                                                                textattribute(Algorithm9)
                                                                {
                                                                    XmlName = 'Algorithm';
                                                                    trigger OnBeforePassVariable()

                                                                    begin
                                                                        Algorithm9 := 'http://www.w3.org/2001/04/xmlenc#sha256';
                                                                    end;
                                                                }
                                                            }
                                                            textelement(DigestValue3)
                                                            {
                                                                XmlName = 'DigestValue';
                                                                NamespacePrefix = 'ds';
                                                                trigger OnBeforePassVariable()

                                                                begin
                                                                    DigestValue3 := 'YTJkM2JhYTcwZTBhZTAxOGYwODMyNzY3NTdkZDM3YzhjY2IxOTIyZDZhM2RlZGJiMGY0NDUzZWJhYWI4MDhmYg==';
                                                                end;

                                                            }

                                                        }

                                                        textelement(IssuerSerial)
                                                        {
                                                            XmlName = 'IssuerSerial';
                                                            NamespacePrefix = 'xades';

                                                            textelement(X509IssuerName)
                                                            {
                                                                XmlName = 'X509IssuerName';
                                                                NamespacePrefix = 'ds';


                                                                trigger OnBeforePassVariable()

                                                                begin
                                                                    X509IssuerName := 'CN=TSZEINVOICE-SubCA-1, DC=extgazt, DC=gov, DC=local';
                                                                end;

                                                            }
                                                            textelement(X509SerialNumber)
                                                            {
                                                                XmlName = 'X509SerialNumber';
                                                                NamespacePrefix = 'ds';
                                                                trigger OnBeforePassVariable()

                                                                begin
                                                                    X509SerialNumber := '2475382886904809774818644480820936050208702411';
                                                                end;

                                                            }

                                                        }

                                                    }
                                                }
                                            }
                                        }
                                    }

                                }
                            }
                        }
                    }
                }

            }
            textelement(ProfileID)
            {
                NamespacePrefix = 'cbc';

                trigger OnBeforePassVariable()
                begin
                    ProfileID := 'reporting:1.0';
                end;
            }
            textelement(ID)
            {
                NamespacePrefix = 'cbc';
                trigger OnBeforePassVariable()
                var
                begin
                    ID := 'SME00023';
                end;
            }
            textelement(UUID)
            {
                NamespacePrefix = 'cbc';
                trigger OnBeforePassVariable()
                var
                begin
                    UUID := '8d487816-70b8-4ade-a618-9d620b73814a';
                end;
            }
            textelement(IssueDate)
            {
                NamespacePrefix = 'cbc';
                trigger OnBeforePassVariable()
                var
                begin
                    IssueDate := Format(Today());
                end;
            }
            textelement(IssueTime)
            {
                NamespacePrefix = 'cbc';
                trigger OnBeforePassVariable()
                var
                begin
                    IssueTime := Format(Time());
                end;
            }
            textelement(InvoiceTypeCode)
            {
                NamespacePrefix = 'cbc';
                textattribute(InvoiceTypeCodename)
                {
                    XmlName = 'name';
                    trigger OnBeforePassVariable()
                    var
                    begin
                        InvoiceTypeCodename := SalesInvoiceHeader."Order No.";
                    end;
                }
                trigger OnBeforePassVariable()
                var
                begin
                    InvoiceTypeCode := SalesInvoiceHeader."No.";
                end;
            }
            textelement(DocumentCurrencyCode)
            {
                NamespacePrefix = 'cbc';
                trigger OnBeforePassVariable()
                var
                begin
                    DocumentCurrencyCode := SalesInvoiceHeader."Currency Code";
                end;
            }
            textelement(TaxCurrencyCode)
            {
                NamespacePrefix = 'cbc';
                trigger OnBeforePassVariable()
                var
                begin
                    TaxCurrencyCode := 'SAR';
                end;
            }

            textelement(AdditionalDocumentReference)
            {
                XmlName = 'AdditionalDocumentReference';
                NamespacePrefix = 'cac';
                textelement(Additionalid)
                {
                    XmlName = 'ID';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    //
                    begin
                        Additionalid := 'ICV';
                    end;
                }
                textelement(UUIDAdditional)
                {
                    XmlName = 'UUID';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    //
                    begin
                        UUIDAdditional := '23';
                    end;
                }
            }

            textelement(AdditionalDocumentReference2)
            {
                XmlName = 'AdditionalDocumentReference';
                NamespacePrefix = 'cac';
                textelement(Additionalid2)
                {
                    XmlName = 'ID';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    //
                    begin
                        Additionalid2 := 'PIH';
                    end;
                }
                textelement(Attachment)
                {
                    NamespacePrefix = 'cac';
                    textelement(EmbeddedDocumentBinaryObject)
                    {
                        NamespacePrefix = 'cbc';
                        textattribute(mimeCode)
                        {
                            XmlName = 'mimeCode';
                            trigger OnBeforePassVariable()
                            var
                            begin
                                mimeCode := 'text/plain';
                            end;
                        }
                        trigger OnBeforePassVariable()

                        begin
                            EmbeddedDocumentBinaryObject := 'NWZlY2ViNjZmZmM4NmYzOGQ5NTI3ODZjNmQ2OTZjNzljMmRiYzIzOWRkNGU5MWI0NjcyOWQ3M2EyN2ZiNTdlOQ==';
                        end;
                    }

                }
            }


            textelement(AdditionalDocumentReference3)
            {
                XmlName = 'AdditionalDocumentReference';
                NamespacePrefix = 'cac';
                textelement(Additionalid3)
                {
                    XmlName = 'ID';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    // 
                    begin
                        Additionalid2 := 'QR';
                    end;
                }
                textelement(Attachment2)
                {
                    NamespacePrefix = 'cac';
                    textelement(EmbeddedDocumentBinaryObject2)
                    {
                        NamespacePrefix = 'cbc';
                        XmlName = 'EmbeddedDocumentBinaryObject';
                        textattribute(mimeCode2)
                        {
                            XmlName = 'mimeCode';
                            trigger OnBeforePassVariable()
                            var
                            begin
                                mimeCode2 := 'text/plain';
                            end;
                        }
                        trigger OnBeforePassVariable()

                        begin
                            EmbeddedDocumentBinaryObject2 := 'ARNBY21lIFdpZGdldOKAmXMgTFREAg8zMTExMTExMTExMDExMTMDFDIwMjItMDktMDdUMTI6MjE6MjhaBAQ0LjYwBQMwLjYGLFdJNkdOd3R5NFhyVGMzUDFXclJNMXhsaHF6OVRpbVhkQ0xIOXNnbWowU2c9B2BNRVVDSVFDQ0dMN0FKYWNWT2JzN2x1RllUYnNxS3I5cUxaWCtMWWpaaXZPakRObmFZZ0lnVDBTclpaS2szTDhmelY4L0o3aDlwN3dIMEJvcXBsVzBSQmNXT1ZOZVcwdz0IWDBWMBAGByqGSM49AgEGBSuBBAAKA0IABGGDDKDmhWAITDv7LXqLX2cmr6+qddUkpcLCvWs5rC2O29W/hS4ajAK4Qdnahym6MaijX75Cg3j4aao7ouYXJ9E=';
                        end;
                    }

                }
            }

            textelement(SignatureAdditional)
            {
                XmlName = 'Signature';
                NamespacePrefix = 'cac';
                textelement(idsignature)
                {
                    XmlName = 'ID';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    //
                    begin
                        idsignature := 'urn:oasis:names:specification:ubl:signature:Invoice';
                    end;
                }
                textelement(SSignatureMethod)
                {
                    XmlName = 'SignatureMethod';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    //
                    begin
                        SSignatureMethod := 'urn:oasis:names:specification:ubl:dsig:enveloped:xades';
                    end;
                }
            }



            textelement(AccountingSupplierParty)
            {
                NamespacePrefix = 'cac';
                textelement(Party)
                {
                    NamespacePrefix = 'cac';
                    textelement(PartyIdentification)
                    {
                        NamespacePrefix = 'cac';
                        //    cbc:ID
                        textelement(cbcID)
                        {
                            XmlName = 'ID';
                            NamespacePrefix = 'cbc';
                            textattribute(IdSchemeID)
                            {
                                XmlName = 'SchemeID';
                                trigger OnBeforePassVariable()
                                var
                                begin
                                    IdSchemeID := 'CRN';
                                end;
                            }
                            trigger OnBeforePassVariable()
                            var
                            begin
                                cbcID := CompanyInformation."Scheme_ID_DSSS";
                            end;
                        }
                    }
                    textelement(PostalAddress)
                    {
                        NamespacePrefix = 'cac';
                        textelement(StreetName)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin
                                StreetName := CompanyInformation."Street Name_DSSS";
                            end;
                        }
                        textelement(AdditionalStreetName)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                AdditionalStreetName := CompanyInformation.Additional_Street_Name_DSSS;
                            end;

                        }
                        textelement(BuildingNumber)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                BuildingNumber := CompanyInformation."Building No_DSSS";
                            end;

                        }
                        textelement(PlotIdentification)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                PlotIdentification := CompanyInformation.Plot_Identification_DSSS;
                            end;
                        }
                        textelement(CitySubdivisionName)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin
                                CitySubdivisionName := CompanyInformation."City_Subdivision_Name_DSSS";
                            end;
                        }
                        textelement(CityName)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin
                                CityName := CompanyInformation.City;
                            end;
                        }
                        textelement(PostalZone)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                PostalZone := CompanyInformation."Post Code";
                            end;
                        }
                        // textelement(CountrySubentity)
                        // {
                        //     NamespacePrefix = 'cbc';
                        //     trigger OnBeforePassVariable()
                        //     var
                        //         
                        //     begin
                        //         CountrySubentity := 'MappingRequired';
                        //     end;
                        // }
                        // textelement(CountrySubentityCode)
                        // {
                        //     NamespacePrefix = 'cbc';
                        //     trigger OnBeforePassVariable()
                        //     var
                        //         
                        //     begin
                        //         CountrySubentityCode := 'MappingRequired';
                        //     end;
                        // }
                        textelement(Country)
                        {
                            NamespacePrefix = 'cac';
                            //    cbc:ID
                            textelement(IdentificationCod)
                            {
                                XmlName = 'IdentificationCode';
                                NamespacePrefix = 'cbc';

                                trigger OnBeforePassVariable()
                                var
                                begin
                                    IdentificationCod := CompanyInformation."Country/Region Code";
                                end;
                            }
                        }
                        // textelement(Country)
                        // {
                        //     NamespacePrefix = 'cac';
                        //     textelement(IdentificationCode)
                        //     {
                        //         NamespacePrefix = 'cbc';
                        //         trigger OnBeforePassVariable()
                        //         var
                        //             
                        //         begin
                        //             IdentificationCode := CompanyInformation."Country/Region Code";
                        //         end;
                        //     }

                        // }
                    }
                    textelement(PartyTaxScheme)
                    {
                        NamespacePrefix = 'cac';

                        textelement(TaxScheme)
                        {
                            NamespacePrefix = 'cac';
                            textelement(CompanyinfoID)
                            {
                                XmlName = 'ID';
                                NamespacePrefix = 'cbc';
                                trigger OnBeforePassVariable()
                                var
                                // 
                                begin
                                    CompanyinfoID := 'VAT';
                                end;
                            }
                        }
                    }
                    textelement(PartyLegalEntity)
                    {
                        NamespacePrefix = 'cac';
                        textelement(RegistrationName)
                        {
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                RegistrationName := CompanyInformation.Registration_Name_DSSS;
                            end;
                        }
                    }
                }
            }
            textelement(AccountingCustomerParty)
            {
                NamespacePrefix = 'cac';
                textelement(CustParty)
                {
                    XmlName = 'Party';
                    NamespacePrefix = 'cac';
                    textelement(PartyIdent)
                    {
                        XmlName = 'PartyIdentification';
                        NamespacePrefix = 'cac';
                        textelement(CustID)
                        {
                            XmlName = 'ID';
                            NamespacePrefix = 'cbc';
                            textattribute(SchemeId)
                            {
                                XmlName = 'SchemeID';
                                trigger OnBeforePassVariable()
                                var
                                // 
                                begin
                                    SchemeId := 'NAT';
                                end;
                            }
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin
                                CustID := Customer_Rec."Scheme_ID_DSSS";
                            end;
                        }
                    }
                    textelement(PostalAddres)
                    {
                        XmlName = 'PostalAddress';
                        NamespacePrefix = 'cac';
                        textelement(StreetNames)
                        {
                            XmlName = 'StreetName';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin
                                StreetNames := Customer_Rec."Street Name_DSSS";
                            end;
                        }
                        // textelement(AdditionalStName)
                        // {
                        //     XmlName = 'AdditionalStreetName';
                        //     NamespacePrefix = 'cbc';
                        //     trigger OnBeforePassVariable()
                        //     var
                        //         
                        //     begin
                        //         AdditionalStName := Customer_Rec.Additional_Street_Name_DSSS;
                        //     end;
                        // }
                        textelement(BuildNumber)
                        {
                            XmlName = 'BuildingNumber';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                BuildNumber := Customer_Rec."Building No_DSSS";
                            end;
                        }
                        textelement(PlotIdentifi)
                        {
                            XmlName = 'PlotIdentification';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin
                                PlotIdentifi := Customer_Rec.Plot_Identification_DSSS;
                            end;
                        }
                        textelement(CitySubdivName)
                        {
                            XmlName = 'CitySubdivisionName';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                CitySubdivName := Customer_Rec."City_Subdivision_Name_DSSS";
                            end;
                        }
                        textelement(custCityName)
                        {
                            XmlName = 'CityName';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                custCityName := Customer_Rec.City;
                            end;
                        }
                        textelement(PostZone)
                        {
                            XmlName = 'PostalZone';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //: Integer;
                            begin
                                PostZone := Customer_Rec."Post Code";
                            end;
                        }
                        // textelement(CustCountrySubentity)
                        // {
                        //     XmlName = 'CountrySubentity';
                        //     NamespacePrefix = 'cbc';
                        //     trigger OnBeforePassVariable()
                        //     var
                        //         
                        //     begin
                        //         CustCountrySubentity := 'MappingRequired';
                        //     end;
                        // }
                        // textelement(CustCountrySubentityCode)
                        // {
                        //     XmlName = 'CountrySubentityCode';
                        //     NamespacePrefix = 'cbc';
                        //     trigger OnBeforePassVariable()
                        //     var
                        //         
                        //     begin
                        //         CustCountrySubentityCode := 'MappingRequired';
                        //     end;
                        // }
                        textelement(CustCountry)
                        {
                            XmlName = 'Country';
                            NamespacePrefix = 'cac';
                            textelement(CustIdentificationCode)
                            {
                                XmlName = 'IdentificationCode';
                                NamespacePrefix = 'cbc';
                                trigger OnBeforePassVariable()
                                var
                                // 
                                begin
                                    CustIdentificationCode := Customer_Rec."Country/Region Code";
                                end;
                            }
                        }
                    }
                    textelement(CustPartyTaxScheme)
                    {
                        XmlName = 'PartyTaxScheme';
                        NamespacePrefix = 'cac';
                        textelement(custCompanyID)
                        {
                            XmlName = 'CompanyID';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            // 
                            begin
                                custCompanyID := Customer_Rec.Customer_ID_DSSS;
                            end;
                        }
                        textelement(CustTaxScheme)
                        {
                            XmlName = 'TaxScheme';
                            NamespacePrefix = 'cac';
                            textelement(CusomertID)
                            {
                                XmlName = 'ID';
                                NamespacePrefix = 'cbc';
                                trigger OnBeforePassVariable()
                                var
                                // 
                                begin
                                    CusomertID := 'VAT';
                                end;
                            }
                        }
                    }
                    textelement(CustPartyLegalEntity)
                    {
                        XmlName = 'PartyLegalEntity';
                        NamespacePrefix = 'cac';
                        textelement(CustRegistrationName)
                        {
                            XmlName = 'RegistrationName';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var
                            //
                            begin

                                CustRegistrationName := Customer_Rec.Registration_Name_DSSS;
                            end;
                        }
                    }
                }
            }
            textelement(Delivery)
            {
                XmlName = 'Delivery';
                NamespacePrefix = 'cac';
                textelement(ActualDeliveryDate)
                {
                    XmlName = 'ActualDeliveryDate';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    // 
                    begin

                        ActualDeliveryDate := '2022-09-07';
                    end;
                }

                // textelement(LatestDeliveryDate)
                // {
                //     XmlName = 'LatestDeliveryDate';
                //     NamespacePrefix = 'cbc';
                //     trigger OnBeforePassVariable()
                //     var
                //         
                //     begin

                //         LatestDeliveryDate := 'MappingRequired';
                //     end;
                // }
            }
            textelement(PaymentMeans)
            {
                XmlName = 'PaymentMeans';
                NamespacePrefix = 'cac';
                textelement(PaymentMeansCode)
                {
                    XmlName = 'PaymentMeansCode';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var
                    //
                    begin

                        PaymentMeansCode := '10';
                    end;
                }
            }
            textelement(AllowanceCharge)
            {
                XmlName = 'AllowanceCharge';
                NamespacePrefix = 'cac';
                textelement(ChargeIndicator)
                {
                    XmlName = 'ChargeIndicator';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var

                    begin

                        ChargeIndicator := 'false';
                    end;
                }
                textelement(AllowanceChargeReason)
                {
                    XmlName = 'AllowanceChargeReason';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var

                    begin

                        AllowanceChargeReason := 'discount';
                    end;
                }
                textelement(Amount)
                {
                    XmlName = 'Amount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyID)
                    {
                        trigger OnBeforePassVariable()
                        var

                        begin
                            currencyID := 'SAR';
                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        Amount := '0.00';
                    end;
                }
                textelement(TaxCategor)
                {
                    XmlName = 'TaxCategor';
                    NamespacePrefix = 'cac';
                    textelement(TID)
                    {
                        XmlName = 'ID';
                        NamespacePrefix = 'cbc';
                        textattribute(TaxIdSchemeID)
                        {
                            XmlName = 'SchemeID';
                            trigger OnBeforePassVariable()
                            var
                            begin
                                TaxIdSchemeID := 'UN/ECE 5305';
                            end;
                        }
                        textattribute(schemeAgencyID)
                        {
                            XmlName = 'schemeAgencyID';
                            trigger OnBeforePassVariable()
                            var
                            begin
                                schemeAgencyID := '6';
                            end;
                        }
                        trigger OnBeforePassVariable()
                        var

                        begin

                            TID := 'S';
                        end;
                    }
                    textelement(TCPercent)
                    {
                        XmlName = 'Percent';
                        NamespacePrefix = 'cbc';
                        trigger OnBeforePassVariable()
                        var

                        begin

                            TCPercent := '15';
                        end;
                    }

                    textelement(TaxSchem)
                    {
                        XmlName = 'TaxScheme';
                        NamespacePrefix = 'cac';
                        textelement(TaxSID)
                        {
                            XmlName = 'ID';
                            NamespacePrefix = 'cbc';
                            textattribute(TaxSchemeid)
                            {
                                XmlName = 'SchemeID';
                                trigger OnBeforePassVariable()
                                var
                                begin
                                    TaxSchemeid := 'UN/ECE 5153';
                                end;
                            }
                            textattribute(TschemeAgencyID)
                            {
                                XmlName = 'schemeAgencyID';
                                trigger OnBeforePassVariable()
                                var
                                begin
                                    TschemeAgencyID := '6';
                                end;
                            }
                            trigger OnBeforePassVariable()
                            var

                            begin

                                TaxSID := 'VAT';
                            end;
                        }
                    }
                }
            }

            textelement(TaxTotal)
            {
                XmlName = 'TaxTotal';
                NamespacePrefix = 'cac';
                textelement(TaxAmount)
                {
                    XmlName = 'TaxAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(TaxcurrencyID)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                TaxcurrencyID := SalesInvoiceHeader."Currency Code"
                            else
                                TaxcurrencyID := GeneralLedgerSetup."LCY Code";

                        end;
                    }

                    trigger OnBeforePassVariable()
                    var
                        ExchangeRate: Record "Currency Exchange Rate";
                        GeneralLedgerSetup: Record "General Ledger Setup";
                        convertedAmount: Decimal;
                        ConvertionValue: Decimal;
                    begin

                        if (SalesInvoiceHeader."Currency Code" = GeneralLedgerSetup."LCY Code") or (SalesInvoiceHeader."Currency Code" = '') then
                            TaxAmount := Format(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount)
                        else begin
                            ConvertionValue := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
                            convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvoiceHeader."Currency Code", GeneralLedgerSetup."LCY Code", SalesInvoiceHeader."Posting Date");
                            TaxAmount := Format(convertedAmount);
                        end;
                    end;
                }
            }
            // textelement(TaxTotalCBC)
            // {
            //     XmlName = 'TaxTotal';
            //     NamespacePrefix = 'cac';
            //     textelement(TaxAmountcbc)
            //     {
            //         XmlName = 'TaxAmount';
            //         NamespacePrefix = 'cbc';
            //         textattribute(currencyIDcbc)
            //         {
            //             XmlName = 'currencyID';

            //             trigger OnBeforePassVariable()
            //             var
            //                 
            //             begin
            //                 currencyIDcbc := 'USD';
            //             end;
            //         }
            //         trigger OnBeforePassVariable()
            //         var
            //             
            //         begin

            //             TaxAmountcbc := 'MappingRequired';
            //         end;
            //     }
            // }
            // textelement(TaxTotalCBd)
            // {
            //     XmlName = 'TaxTotal';
            //     NamespacePrefix = 'cac';
            //     textelement(TaxAmountcbd)
            //     {
            //         XmlName = 'TaxAmount';
            //         NamespacePrefix = 'cbc';
            //         textattribute(currencyIDcbd)
            //         {
            //             XmlName = 'currencyID';

            //             trigger OnBeforePassVariable()
            //             var
            //                 
            //             begin
            //                 GeneralLedgerSetup.Get();
            //                 if SalesInvoiceHeader."Currency Code" <> '' then
            //                     currencyIDcbd := SalesInvoiceHeader."Currency Code"
            //                 else
            //                     currencyIDcbd := GeneralLedgerSetup."LCY Code";

            //             end;
            //         }
            //         trigger OnBeforePassVariable()
            //         var
            //             

            //             convertedAmount: Decimal;
            //             ConvertionValue: Decimal;
            //             ExchangeRate: Record "Currency Exchange Rate";
            //             GeneralLedgerSetup: Record "General Ledger Setup";
            //         begin
            //             GeneralLedgerSetup.get();

            //             if (SalesInvoiceHeader."Currency Code" = GeneralLedgerSetup."LCY Code") or (SalesInvoiceHeader."Currency Code" = '') then
            //                 TaxAmountcbd := Format(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount)
            //             else begin
            //                 ConvertionValue := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
            //                 convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvoiceHeader."Currency Code", GeneralLedgerSetup."LCY Code", SalesInvoiceHeader."Posting Date");
            //                 TaxAmountcbd := Format(convertedAmount);
            //             end;

            //         end;
            //     }
            //     textelement(TaxSubtotal)
            //     {
            //         XmlName = 'TaxSubtotal';
            //         NamespacePrefix = 'cac';
            //         textelement(TaxAmountcbe)
            //         {
            //             XmlName = 'TaxAmount';
            //             NamespacePrefix = 'cbc';
            //             textattribute(currencyIDcbe)
            //             {
            //                 XmlName = 'currencyID';

            //                 trigger OnBeforePassVariable()
            //                 var
            //                     
            //                 begin
            //                     //currencyIDcbc := 'SAR';
            //                     TaxAmountcbe := 'SAR';
            //                 end;
            //             }
            //             trigger OnBeforePassVariable()
            //             var
            //                 
            //             begin

            //                 // TaxAmountcbc := 'MappingRequired';
            //                 TaxAmountcbe := 'MappingRequired';

            //             end;
            //         }
            //         textelement(TaxCategory)
            //         {
            //             NamespacePrefix = 'cac';
            //             textelement(Percent)
            //             {
            //                 NamespacePrefix = 'cbc';
            //                 trigger OnBeforePassVariable()
            //                 var
            //                     
            //                 begin
            //                     Percent := Format(SalesInvoiceHeader."VAT Base Discount %");
            //                 end;
            //             }
            //             textelement(TaxSchemedss)
            //             {
            //                 XmlName = 'TaxScheme';
            //                 NamespacePrefix = 'cac';
            //                 textelement(IDdss)
            //                 {
            //                     XmlName = 'ID';
            //                     NamespacePrefix = 'cbc';
            //                     trigger OnBeforePassVariable()
            //                     var
            //                         
            //                     begin
            //                         IDdss := 'VAT';
            //                     end;
            //                 }
            //             }
            //         }
            //     }
            // }
            // textelement(TaxTotaldss)
            // {
            //     XmlName = 'TaxTotal';
            //     NamespacePrefix = 'cac';
            //     textelement(TaxAmountdss)
            //     {
            //         XmlName = 'TaxAmount';
            //         NamespacePrefix = 'cbc';
            //         textattribute(currencyIDdss)
            //         {
            //             XmlName = 'currencyID';

            //             trigger OnBeforePassVariable()
            //             var
            //                 
            //             begin
            //                 GeneralLedgerSetup.Get();
            //                 if SalesInvoiceHeader."Currency Code" <> '' then
            //                     currencyIDdss := SalesInvoiceHeader."Currency Code"
            //                 else
            //                     currencyIDdss := GeneralLedgerSetup."LCY Code";

            //             end;
            //         }
            //         trigger OnBeforePassVariable()
            //         var
            //             

            //             convertedAmount: Decimal;
            //             ConvertionValue: Decimal;
            //             ExchangeRate: Record "Currency Exchange Rate";
            //             GeneralLedgerSetup: Record "General Ledger Setup";
            //         begin
            //             GeneralLedgerSetup.get();

            //             if (SalesInvoiceHeader."Currency Code" = GeneralLedgerSetup."LCY Code") or (SalesInvoiceHeader."Currency Code" = '') then
            //                 TaxAmountdss := Format(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount)
            //             else begin
            //                 ConvertionValue := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
            //                 convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvoiceHeader."Currency Code", GeneralLedgerSetup."LCY Code", SalesInvoiceHeader."Posting Date");
            //                 TaxAmountdss := Format(convertedAmount);
            //             end;

            //         end;
            //     }
            //     textelement(TaxSubtotaldss)
            //     {
            //         XmlName = 'TaxSubtotal';
            //         NamespacePrefix = 'cac';
            //         textelement(TaxAmountdsss)
            //         {
            //             XmlName = 'TaxAmount';
            //             NamespacePrefix = 'cbc';
            //             textattribute(currencyIDdsss)
            //             {
            //                 XmlName = 'currencyID';

            //                 trigger OnBeforePassVariable()
            //                 var
            //                     
            //                 begin
            //                     currencyIDcbc := 'SAR';
            //                 end;
            //             }
            //             trigger OnBeforePassVariable()
            //             var
            //                 
            //             begin

            //                 TaxAmountcbc := 'MappingRequired';
            //             end;
            //         }
            //         textelement(TaxCategorydss)
            //         {
            //             NamespacePrefix = 'cac';
            //             textelement(TaxSchemedsss)
            //             {
            //                 XmlName = 'TaxScheme';
            //                 NamespacePrefix = 'cac';
            //                 textelement(IDdsss)
            //                 {
            //                     XmlName = 'ID';
            //                     NamespacePrefix = 'cbc';
            //                     trigger OnBeforePassVariable()
            //                     var
            //                         
            //                     begin
            //                         IDdss := 'VAT';
            //                     end;
            //                 }
            //             }
            //         }
            //     }
            // }
            textelement(TaxTotaldssd)
            {
                XmlName = 'TaxTotal';
                NamespacePrefix = 'cac';
                textelement(TaxAmountdssd)
                {
                    XmlName = 'TaxAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDdssd)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDdssd := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDdssd := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var
                        // 
                        ExchangeRate: Record "Currency Exchange Rate";
                        GeneralLedgerSetup: Record "General Ledger Setup";
                        convertedAmount: Decimal;
                        ConvertionValue: Decimal;

                    begin
                        GeneralLedgerSetup.get();

                        if (SalesInvoiceHeader."Currency Code" = GeneralLedgerSetup."LCY Code") or (SalesInvoiceHeader."Currency Code" = '') then
                            TaxAmountdssd := Format(SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount)
                        else begin
                            ConvertionValue := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
                            convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvoiceHeader."Currency Code", GeneralLedgerSetup."LCY Code", SalesInvoiceHeader."Posting Date");
                            TaxAmountdssd := Format(convertedAmount);
                        end;

                    end;
                }
                textelement(TaxSubtotaldsss)
                {
                    XmlName = 'TaxSubtotal';
                    NamespacePrefix = 'cac';

                    textelement(TaxableAmount)
                    {
                        XmlName = 'TaxableAmount';
                        NamespacePrefix = 'cbc';
                        textattribute(TaxcurrencyIDdsse)
                        {
                            XmlName = 'currencyID';

                            trigger OnBeforePassVariable()
                            var

                            begin
                                currencyIDdsse := 'SAR';
                            end;
                        }
                        trigger OnBeforePassVariable()
                        var

                        begin

                            TaxableAmount := '4.00';
                        end;
                    }
                    textelement(TaxAmountdsse)
                    {
                        XmlName = 'TaxAmount';
                        NamespacePrefix = 'cbc';
                        textattribute(currencyIDdsse)
                        {
                            XmlName = 'currencyID';

                            trigger OnBeforePassVariable()
                            var

                            begin
                                currencyIDdsse := 'SAR';
                            end;
                        }
                        trigger OnBeforePassVariable()
                        var

                        begin

                            TaxAmountdsse := '0.60';
                        end;
                    }
                    // textelement(TaxCategorydsss)
                    // {
                    //     NamespacePrefix = 'cac';
                    //     textelement(TaxSchemedsse)
                    //     {
                    //         XmlName = 'TaxScheme';
                    //         NamespacePrefix = 'cac';
                    //         textelement(IDdsse)
                    //         {
                    //             XmlName = 'ID';
                    //             NamespacePrefix = 'cbc';
                    //             trigger OnBeforePassVariable()
                    //             var
                    //                 
                    //             begin
                    //                 IDdsse := 'VAT';
                    //             end;
                    //         }
                    //     }
                    // }

                    textelement(TaxCategory)
                    {
                        XmlName = 'TaxCategory';
                        NamespacePrefix = 'cac';
                        textelement(TaID)
                        {
                            XmlName = 'ID';
                            NamespacePrefix = 'cbc';
                            textattribute(TaIdSchemeID)
                            {
                                XmlName = 'SchemeID';
                                trigger OnBeforePassVariable()
                                var
                                begin
                                    TaIdSchemeID := 'UN/ECE 5305';
                                end;
                            }
                            textattribute(scemeAgencyID)
                            {
                                XmlName = 'schemeAgencyID';
                                trigger OnBeforePassVariable()
                                var
                                begin
                                    scemeAgencyID := '6';
                                end;
                            }
                            trigger OnBeforePassVariable()
                            var

                            begin

                                TaID := 'S';
                            end;
                        }
                        textelement(TaCPercent)
                        {
                            XmlName = 'Percent';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var

                            begin

                                TaCPercent := '15.00';
                            end;
                        }

                        textelement(TaSchem)
                        {
                            XmlName = 'TaxScheme';
                            NamespacePrefix = 'cac';
                            textelement(TaSID)
                            {
                                XmlName = 'ID';
                                NamespacePrefix = 'cbc';
                                textattribute(TaSchemeid)
                                {
                                    XmlName = 'SchemeID';
                                    trigger OnBeforePassVariable()
                                    var
                                    begin
                                        TaSchemeid := 'UN/ECE 5153';
                                    end;
                                }
                                textattribute(TscemeAgencyID)
                                {
                                    XmlName = 'schemeAgencyID';
                                    trigger OnBeforePassVariable()
                                    var
                                    begin
                                        TscemeAgencyID := '6';
                                    end;
                                }
                                trigger OnBeforePassVariable()
                                var

                                begin

                                    TaSID := 'VAT';
                                end;
                            }
                        }
                    }

                }
            }
            textelement(LegalMonetaryTotal)
            {
                NamespacePrefix = 'cac';
                textelement(LineExtensionAmount)
                {
                    XmlName = 'LineExtensionAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDlegal)
                    {
                        XmlName = 'currencyID';
                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDlegal := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDlegal := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        LineExtensionAmount := '4.00';
                    end;
                }

                textelement(TaxExclusiveAmount)
                {
                    XmlName = 'TaxExclusiveAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDLaga2)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDLaga := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDLaga2 := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        TaxExclusiveAmount := '4.00';
                    end;
                }
                textelement(TaxInclusiveAmount)
                {
                    XmlName = 'TaxInclusiveAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDLaga3)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDLaga := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDLaga3 := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        TaxInclusiveAmount := '4.60';
                    end;
                }
                textelement(AllowanceTotalAmount)
                {
                    XmlName = 'AllowanceTotalAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDLaga4)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDLaga := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDLaga4 := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        AllowanceTotalAmount := '0.00';
                    end;
                }


                textelement(PrepaidAmount)
                {
                    XmlName = 'PrepaidAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDLeag)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDLeag := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDLeag := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        PrepaidAmount := '0.00';
                    end;
                }
                textelement(PayableAmount)
                {
                    XmlName = 'PayableAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(currencyIDLaga)
                    {
                        XmlName = 'currencyID';

                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                currencyIDLaga := SalesInvoiceHeader."Currency Code"
                            else
                                currencyIDLaga := GeneralLedgerSetup."LCY Code";

                        end;
                    }
                    trigger OnBeforePassVariable()
                    var

                    begin

                        PayableAmount := '4.60';
                    end;
                }
            }

            tableelement("SalesInvoiceLine"; "Sales Invoice Line")
            {
                XmlName = 'InvoiceLine';
                NamespacePrefix = 'cac';
                // textattribute(IDcbc)
                // {
                //     XmlName = 'ID';
                //     NamespacePrefix = 'cbc';
                //     trigger OnBeforePassVariable()
                //     var
                //         
                //     begin
                //         IDcbc := 'MappingRequired';
                //     end;
                // }
                textelement(idinvoice)
                {
                    XmlName = 'ID';
                    NamespacePrefix = 'cbc';
                    trigger OnBeforePassVariable()
                    var

                    begin
                        idinvoice := '1';
                    end;


                }
                textelement(InvoicedQuantity)
                {
                    XmlName = 'InvoicedQuantity';
                    NamespacePrefix = 'cbc';

                    textattribute(unitCode)
                    {
                        XmlName = 'unitCode';
                        NamespacePrefix = 'cbc';
                        trigger OnBeforePassVariable()
                        var

                        begin
                            unitCode := 'PCE';

                        end;

                    }
                    trigger OnBeforePassVariable()
                    var

                    begin
                        InvoicedQuantity := '2.000000';
                    end;

                }
                textelement(LineExtensionAmount2)
                {
                    XmlName = 'LineExtensionAmount';
                    NamespacePrefix = 'cbc';
                    textattribute(Line1currencyID)
                    {
                        XmlName = 'currencyID';
                        NamespacePrefix = 'cbc';
                        trigger OnBeforePassVariable()
                        var

                        begin
                            GeneralLedgerSetup.Get();
                            if SalesInvoiceHeader."Currency Code" <> '' then
                                Line1currencyID := SalesInvoiceHeader."Currency Code"
                            else
                                Line1currencyID := GeneralLedgerSetup."LCY Code";

                        end;

                    }
                    trigger OnBeforePassVariable()
                    var

                    begin
                        LineExtensionAmount2 := Format(SalesInvoiceLine."Line Amount");
                    end;
                }

                textelement(LineTaxTotal)
                {
                    XmlName = 'TaxTotal';
                    NamespacePrefix = 'cac';
                    textelement(LineTaxAmount)
                    {
                        NamespacePrefix = 'cbc';
                        XmlName = 'TaxAmount';
                        textattribute(LinecurrencyID)
                        {
                            XmlName = 'currencyID';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                GeneralLedgerSetup.Get();
                                if SalesInvoiceHeader."Currency Code" <> '' then
                                    LinecurrencyID := SalesInvoiceHeader."Currency Code"
                                else
                                    LinecurrencyID := GeneralLedgerSetup."LCY Code";

                            end;
                        }
                        trigger OnBeforePassVariable()
                        var


                            ExchangeRate: Record "Currency Exchange Rate";
                            GeneralLedgerSetup: Record "General Ledger Setup";
                            convertedAmount: Decimal;
                            ConvertionValue: Decimal;
                        begin
                            GeneralLedgerSetup.get();

                            if (SalesInvoiceHeader."Currency Code" = GeneralLedgerSetup."LCY Code") or (SalesInvoiceHeader."Currency Code" = '') then
                                LineTaxAmount := Format(SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount)
                            else begin
                                ConvertionValue := SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount;
                                convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvoiceHeader."Currency Code", GeneralLedgerSetup."LCY Code", SalesInvoiceHeader."Posting Date");
                                LineTaxAmount := Format(convertedAmount);
                            end;

                        end;
                    }

                    textelement(RoundingAmount)
                    {
                        NamespacePrefix = 'cbc';
                        XmlName = 'RoundingAmount';
                        textattribute(LinecurrencyID2)
                        {
                            XmlName = 'currencyID';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                GeneralLedgerSetup.Get();
                                if SalesInvoiceHeader."Currency Code" <> '' then
                                    LinecurrencyID2 := SalesInvoiceHeader."Currency Code"
                                else
                                    LinecurrencyID2 := GeneralLedgerSetup."LCY Code";

                            end;
                        }
                        trigger OnBeforePassVariable()
                        var

                        begin
                            RoundingAmount := '4.60';
                        end;
                    }

                }
                textelement(LineItem)
                {
                    XmlName = 'Item';
                    NamespacePrefix = 'cac';
                    textelement(LineName)
                    {
                        XmlName = 'Name';
                        NamespacePrefix = 'cbc';
                        trigger OnBeforePassVariable()
                        var

                        begin
                            LineName := SalesInvoiceLine.Description;
                        end;
                    }
                    textelement(LineClassifiedTaxCategory)
                    {
                        XmlName = 'ClassifiedTaxCategory';
                        NamespacePrefix = 'cac';
                        textelement(LineID)
                        {
                            XmlName = 'ID';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                LineID := SalesInvoiceLine."No.";
                            end;
                        }
                        textelement(LinePercent)
                        {
                            XmlName = 'Percent';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                LineID := Format(SalesInvoiceLine."VAT %");
                            end;
                        }
                        textelement(LineTaxScheme)
                        {
                            XmlName = 'TaxScheme';
                            NamespacePrefix = 'cac';
                            textelement(Line2ID)
                            {
                                XmlName = 'ID';
                                NamespacePrefix = 'cbc';
                                trigger OnBeforePassVariable()
                                var

                                begin
                                    Line2ID := 'VAT';
                                end;
                            }
                        }
                    }
                }


                textelement(Price)
                {
                    XmlName = 'Price';
                    NamespacePrefix = 'cac';
                    textelement(PriceAmount)
                    {
                        NamespacePrefix = 'cbc';
                        XmlName = 'PriceAmount';
                        textattribute(LinecurrencyID3)
                        {
                            XmlName = 'currencyID';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                GeneralLedgerSetup.Get();
                                if SalesInvoiceHeader."Currency Code" <> '' then
                                    LinecurrencyID3 := SalesInvoiceHeader."Currency Code"
                                else
                                    LinecurrencyID3 := GeneralLedgerSetup."LCY Code";

                            end;
                        }
                        trigger OnBeforePassVariable()
                        var

                        begin
                            PriceAmount := '2.00';
                        end;
                    }
                    textelement(AllowanceCharge2)
                    {
                        XmlName = 'AllowanceCharge';
                        NamespacePrefix = 'cac';
                        textelement(ChargeIndicator2)
                        {
                            XmlName = 'ChargeIndicator';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                ChargeIndicator2 := 'false';
                            end;
                        }
                        textelement(AllowanceChargeReason2)
                        {
                            XmlName = 'AllowanceChargeReason';
                            NamespacePrefix = 'cbc';
                            trigger OnBeforePassVariable()
                            var

                            begin
                                AllowanceChargeReason2 := 'discount';
                            end;
                        }

                        textelement(Amount2)
                        {
                            NamespacePrefix = 'cbc';
                            XmlName = 'Amount';
                            textattribute(LinecurrencyID4)
                            {
                                XmlName = 'currencyID';
                                trigger OnBeforePassVariable()
                                var

                                begin
                                    GeneralLedgerSetup.Get();
                                    if SalesInvoiceHeader."Currency Code" <> '' then
                                        LinecurrencyID4 := SalesInvoiceHeader."Currency Code"
                                    else
                                        LinecurrencyID4 := GeneralLedgerSetup."LCY Code";

                                end;
                            }
                            trigger OnBeforePassVariable()
                            var

                            begin
                                Amount2 := '0.00';
                            end;
                        }

                    }
                }
                trigger OnPreXmlItem()
                var
                begin
                    SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                    if SalesInvoiceLine.FindSet() then;
                end;

            }

        }
    }
    procedure SetSources(SalesInvoiceHeaders: Record "Sales Invoice Header")
    var
    // SSSS:XmlPort "Sales Invoice - PEPPOL 2.0"
    begin
        if SalesInvoiceHeaders.Get(SalesInvoiceHeaders."No.") then;
        if Customer_Rec.Get(SalesInvoiceHeaders."Sell-to Customer No.") then;
        SalesInvoiceHeaders.CalcFields(Amount, "Amount Including VAT");

    end;

    trigger OnPreXmlPort()
    var
    begin
        if CompanyInformation.get() then;
    end;

    trigger OnPostXmlPort()
    var
    begin
        currXMLport.Filename(Format(CurrentDateTime()) + '.xml');
    end;

    var
        CompanyInformation: Record "Company Information";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer_Rec: Record Customer;
        GeneralLedgerSetup: Record "General Ledger Setup";
    // XML: page 256;
    //signatur: Text;
}