// xmlport 70502 "Tax Invoice XML DSSS"
// {
//     Caption = 'Tax Invoice previous XML';

//     UseRequestPage = false;
//     // DefaultNamespace = 'urn:iso:std:iso:20022:tech:xsd:pain.001.001.03';
//     Direction = Export;
//     Encoding = UTF8;
//     // Format = Xml;
//     // FormatEvaluate = Xml;
//     // XmlVersionNo = V10;
//     // UseDefaultNamespace = false;
//     // Namespaces = xsi = 'xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance xmlns:xsd=http://www.w3.org/2001/XMLSchema xmlns:cac=urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2 xmlns:cbc=urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

//     // Namespaces = "" = 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2 xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance xmlns:xsd=http://www.w3.org/2001/XMLSchema xmlns:cac=urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2 xmlns:cbc=urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

//     Namespaces = "" = 'urn:oasis:names:specification:ubl:schema:xsd:Invoice-2', xsi = 'http://www.w3.org/2001/XMLSchema-instance ', xsd = 'http://www.w3.org/2001/XMLSchema ', cac = 'urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2', cbc = 'urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2';

//     schema
//     {
//         tableelement(invoiceheaderloop; Integer)
//         {
//             MaxOccurs = Once;
//             XmlName = 'Invoice';
//             SourceTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
//             textelement(ProfileID)
//             {
//                 NamespacePrefix = 'cbc';

//                 trigger OnBeforePassVariable()
//                 begin
//                     ProfileID := 'reporting:1.0';
//                 end;
//             }
//             textelement(ID)
//             {
//                 NamespacePrefix = 'cbc';
//                 trigger OnBeforePassVariable()
//                 var
//                 begin
//                     ID := '';
//                 end;
//             }
//             textelement(IssueDate)
//             {
//                 NamespacePrefix = 'cbc';
//                 trigger OnBeforePassVariable()
//                 var
//                 begin
//                     IssueDate := Format(Today());
//                 end;
//             }
//             textelement(IssueTime)
//             {
//                 NamespacePrefix = 'cbc';
//                 trigger OnBeforePassVariable()
//                 var
//                 begin
//                     IssueTime := Format(Time());
//                 end;
//             }
//             textelement(InvoiceTypeCode)
//             {
//                 NamespacePrefix = 'cbc';
//                 textattribute(InvoiceTypeCodename)
//                 {
//                     XmlName = 'name';
//                     trigger OnBeforePassVariable()
//                     var
//                     begin
//                         InvoiceTypeCodename := SalesInvHederRec."Order No.";
//                     end;
//                 }
//                 trigger OnBeforePassVariable()
//                 var
//                 begin
//                     InvoiceTypeCode := SalesInvHederRec."No.";
//                 end;
//             }
//             textelement(DocumentCurrencyCode)
//             {
//                 NamespacePrefix = 'cbc';
//                 trigger OnBeforePassVariable()
//                 var
//                 begin
//                     DocumentCurrencyCode := SalesInvHederRec."Currency Code";
//                 end;
//             }
//             textelement(TaxCurrencyCode)
//             {
//                 NamespacePrefix = 'cbc';
//                 trigger OnBeforePassVariable()
//                 var
//                 begin
//                     TaxCurrencyCode := 'SAR';
//                 end;
//             }
//             textelement(AccountingSupplierParty)
//             {
//                 NamespacePrefix = 'cac';
//                 textelement(Party)
//                 {
//                     NamespacePrefix = 'cac';
//                     textelement(PartyIdentification)
//                     {
//                         NamespacePrefix = 'cac';
//                         //    cbc:ID
//                         textelement(cbcID)
//                         {
//                             XmlName = 'ID';
//                             NamespacePrefix = 'cbc';
//                             textattribute(IdSchemeID)
//                             {
//                                 XmlName = 'SchemeID';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                 begin
//                                     IdSchemeID := '';
//                                 end;
//                             }
//                             trigger OnBeforePassVariable()
//                             var
//                             begin
//                                 cbcID := CompanyInfo_Rec."Scheme_ID_DSSS";
//                             end;
//                         }
//                     }
//                     textelement(PostalAddress)
//                     {
//                         NamespacePrefix = 'cac';
//                         textelement(StreetName)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 StreetName := CompanyInfo_Rec."Street Name_DSSS";
//                             end;
//                         }
//                         textelement(AdditionalStreetName)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 AdditionalStreetName := CompanyInfo_Rec.Additional_Street_Name_DSSS;
//                             end;

//                         }
//                         textelement(BuildingNumber)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 BuildingNumber := CompanyInfo_Rec."Building No_DSSS";
//                             end;

//                         }
//                         textelement(PlotIdentification)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 PlotIdentification := CompanyInfo_Rec.Plot_Identification_DSSS;
//                             end;
//                         }
//                         textelement(CitySubdivisionName)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CitySubdivisionName := CompanyInfo_Rec."City_Subdivision_Name_DSSS";
//                             end;
//                         }
//                         textelement(CityName)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CityName := CompanyInfo_Rec.City;
//                             end;
//                         }
//                         textelement(PostalZone)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 PostalZone := CompanyInfo_Rec."Post Code";
//                             end;
//                         }
//                         textelement(CountrySubentity)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CountrySubentity := 'MappingRequired';
//                             end;
//                         }
//                         textelement(CountrySubentityCode)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CountrySubentityCode := 'MappingRequired';
//                             end;
//                         }
//                         textelement(Country)
//                         {
//                             NamespacePrefix = 'cac';
//                             textelement(IdentificationCode)
//                             {
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     IdentificationCode := CompanyInfo_Rec."Country/Region Code";
//                                 end;
//                             }

//                         }
//                     }
//                     textelement(PartyTaxScheme)
//                     {
//                         NamespacePrefix = 'cac';
//                         textelement(CompanyID)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CompanyID := CompanyInfo_Rec.Company_ID_DSSS;
//                             end;

//                         }
//                         textelement(TaxScheme)
//                         {
//                             NamespacePrefix = 'cac';
//                             textelement(CompanyinfoID)
//                             {
//                                 XmlName = 'ID';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     CompanyinfoID := 'VAT';
//                                 end;
//                             }
//                         }
//                     }
//                     textelement(PartyLegalEntity)
//                     {
//                         NamespacePrefix = 'cac';
//                         textelement(RegistrationName)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 RegistrationName := CompanyInfo_Rec.Registration_Name_DSSS;
//                             end;
//                         }
//                     }
//                 }
//             }
//             textelement(AccountingCustomerParty)
//             {
//                 NamespacePrefix = 'cac';
//                 textelement(CustParty)
//                 {
//                     XmlName = 'Party';
//                     NamespacePrefix = 'cac';
//                     textelement(PartyIdent)
//                     {
//                         XmlName = 'PartyIdentification';
//                         NamespacePrefix = 'cac';
//                         textelement(CustID)
//                         {
//                             XmlName = 'ID';
//                             NamespacePrefix = 'cbc';
//                             textattribute(SchemeId)
//                             {
//                                 XmlName = 'SchemeID';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     SchemeId := '';
//                                 end;
//                             }
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CustID := Customer_Rec."Scheme_ID_DSSS";
//                             end;
//                         }
//                     }
//                     textelement(PostalAddres)
//                     {
//                         XmlName = 'PostalAddress';
//                         NamespacePrefix = 'cac';
//                         textelement(StreetNames)
//                         {
//                             XmlName = 'StreetName';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 StreetNames := Customer_Rec."Street Name_DSSS";
//                             end;
//                         }
//                         textelement(AdditionalStName)
//                         {
//                             XmlName = 'AdditionalStreetName';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 AdditionalStName := Customer_Rec.Additional_Street_Name_DSSS;
//                             end;
//                         }
//                         textelement(BuildNumber)
//                         {
//                             XmlName = 'BuildingNumber';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 BuildNumber := Customer_Rec."Building No_DSSS";
//                             end;
//                         }
//                         textelement(PlotIdentifi)
//                         {
//                             XmlName = 'PlotIdentification';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 PlotIdentifi := Customer_Rec.Plot_Identification_DSSS;
//                             end;
//                         }
//                         textelement(CitySubdivName)
//                         {
//                             XmlName = 'CitySubdivisionName';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CitySubdivName := Customer_Rec."City_Subdivision_Name_DSSS";
//                             end;
//                         }
//                         textelement(custCityName)
//                         {
//                             XmlName = 'CityName';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 custCityName := Customer_Rec.City;
//                             end;
//                         }
//                         textelement(PostZone)
//                         {
//                             XmlName = 'PostalZone';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 PostZone := Customer_Rec."Post Code";
//                             end;
//                         }
//                         textelement(CustCountrySubentity)
//                         {
//                             XmlName = 'CountrySubentity';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CustCountrySubentity := 'MappingRequired';
//                             end;
//                         }
//                         textelement(CustCountrySubentityCode)
//                         {
//                             XmlName = 'CountrySubentityCode';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 CustCountrySubentityCode := 'MappingRequired';
//                             end;
//                         }
//                         textelement(CustCountry)
//                         {
//                             XmlName = 'Country';
//                             NamespacePrefix = 'cac';
//                             textelement(CustIdentificationCode)
//                             {
//                                 XmlName = 'IdentificationCode';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     CustIdentificationCode := Customer_Rec."Country/Region Code";
//                                 end;
//                             }
//                         }
//                     }
//                     textelement(CustPartyTaxScheme)
//                     {
//                         XmlName = 'PartyTaxScheme';
//                         NamespacePrefix = 'cac';
//                         textelement(custCompanyID)
//                         {
//                             XmlName = 'CompanyID';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 custCompanyID := Customer_Rec.Customer_ID_DSSS;
//                             end;
//                         }
//                         textelement(CustTaxScheme)
//                         {
//                             XmlName = 'TaxScheme';
//                             NamespacePrefix = 'cac';
//                             textelement(CusomertID)
//                             {
//                                 XmlName = 'ID';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     CusomertID := 'VAT';
//                                 end;
//                             }
//                         }
//                     }
//                     textelement(CustPartyLegalEntity)
//                     {
//                         XmlName = 'PartyLegalEntity';
//                         NamespacePrefix = 'cac';
//                         textelement(CustRegistrationName)
//                         {
//                             XmlName = 'RegistrationName';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin

//                                 CustRegistrationName := Customer_Rec.Registration_Name_DSSS;
//                             end;
//                         }
//                     }
//                 }
//             }
//             textelement(Delivery)
//             {
//                 XmlName = 'Delivery';
//                 NamespacePrefix = 'cac';
//                 textelement(ActualDeliveryDate)
//                 {
//                     XmlName = 'ActualDeliveryDate';
//                     NamespacePrefix = 'cbc';
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         ActualDeliveryDate := 'MappingRequired';
//                     end;
//                 }
//                 textelement(LatestDeliveryDate)
//                 {
//                     XmlName = 'LatestDeliveryDate';
//                     NamespacePrefix = 'cbc';
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         LatestDeliveryDate := 'MappingRequired';
//                     end;
//                 }
//             }
//             textelement(AllowanceCharge)
//             {
//                 XmlName = 'AllowanceCharge';
//                 NamespacePrefix = 'cac';
//                 textelement(ChargeIndicator)
//                 {
//                     XmlName = 'ChargeIndicator';
//                     NamespacePrefix = 'cbc';
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         ChargeIndicator := 'False';
//                     end;
//                 }
//                 textelement(Amount)
//                 {
//                     XmlName = 'Amount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyID)
//                     {
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             currencyID := 'SAR';
//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         Amount := '0.00';
//                     end;
//                 }
//             }

//             textelement(TaxTotal)
//             {
//                 XmlName = 'TaxTotal';
//                 NamespacePrefix = 'cac';
//                 textelement(TaxAmount)
//                 {
//                     XmlName = 'TaxAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(TaxcurrencyID)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 TaxcurrencyID := SalesInvHederRec."Currency Code"
//                             else
//                                 TaxcurrencyID := GLSetup."LCY Code";

//                         end;
//                     }

//                     trigger OnBeforePassVariable()
//                     var
//                         convertedAmount: Decimal;
//                         ConvertionValue: Decimal;
//                         ExchangeRate: Record "Currency Exchange Rate";
//                         GLSetup: Record "General Ledger Setup";
//                     begin

//                         if (SalesInvHederRec."Currency Code" = GLSetup."LCY Code") or (SalesInvHederRec."Currency Code" = '') then
//                             TaxAmount := Format(SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount)
//                         else begin
//                             ConvertionValue := SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount;
//                             convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvHederRec."Currency Code", GLSetup."LCY Code", SalesInvHederRec."Posting Date");
//                             TaxAmount := Format(convertedAmount);
//                         end;
//                     end;
//                 }
//             }
//             textelement(TaxTotalCBC)
//             {
//                 XmlName = 'TaxTotal';
//                 NamespacePrefix = 'cac';
//                 textelement(TaxAmountcbc)
//                 {
//                     XmlName = 'TaxAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDcbc)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             currencyIDcbc := 'USD';
//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         TaxAmountcbc := 'MappingRequired';
//                     end;
//                 }
//             }
//             textelement(TaxTotalCBd)
//             {
//                 XmlName = 'TaxTotal';
//                 NamespacePrefix = 'cac';
//                 textelement(TaxAmountcbd)
//                 {
//                     XmlName = 'TaxAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDcbd)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 currencyIDcbd := SalesInvHederRec."Currency Code"
//                             else
//                                 currencyIDcbd := GLSetup."LCY Code";

//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;

//                         convertedAmount: Decimal;
//                         ConvertionValue: Decimal;
//                         ExchangeRate: Record "Currency Exchange Rate";
//                         GLSetup: Record "General Ledger Setup";
//                     begin
//                         GLSetup.get();

//                         if (SalesInvHederRec."Currency Code" = GLSetup."LCY Code") or (SalesInvHederRec."Currency Code" = '') then
//                             TaxAmountcbd := Format(SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount)
//                         else begin
//                             ConvertionValue := SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount;
//                             convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvHederRec."Currency Code", GLSetup."LCY Code", SalesInvHederRec."Posting Date");
//                             TaxAmountcbd := Format(convertedAmount);
//                         end;

//                     end;
//                 }
//                 textelement(TaxSubtotal)
//                 {
//                     XmlName = 'TaxSubtotal';
//                     NamespacePrefix = 'cac';
//                     textelement(TaxAmountcbe)
//                     {
//                         XmlName = 'TaxAmount';
//                         NamespacePrefix = 'cbc';
//                         textattribute(currencyIDcbe)
//                         {
//                             XmlName = 'currencyID';

//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 currencyIDcbc := 'SAR';
//                             end;
//                         }
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin

//                             TaxAmountcbc := 'MappingRequired';
//                         end;
//                     }
//                     textelement(TaxCategory)
//                     {
//                         NamespacePrefix = 'cac';
//                         textelement(Percent)
//                         {
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 Percent := Format(SalesInvHederRec."VAT Base Discount %");
//                             end;
//                         }
//                         textelement(TaxSchemedss)
//                         {
//                             XmlName = 'TaxScheme';
//                             NamespacePrefix = 'cac';
//                             textelement(IDdss)
//                             {
//                                 XmlName = 'ID';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     IDdss := 'VAT';
//                                 end;
//                             }
//                         }
//                     }
//                 }
//             }
//             textelement(TaxTotaldss)
//             {
//                 XmlName = 'TaxTotal';
//                 NamespacePrefix = 'cac';
//                 textelement(TaxAmountdss)
//                 {
//                     XmlName = 'TaxAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDdss)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 currencyIDdss := SalesInvHederRec."Currency Code"
//                             else
//                                 currencyIDdss := GLSetup."LCY Code";

//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;

//                         convertedAmount: Decimal;
//                         ConvertionValue: Decimal;
//                         ExchangeRate: Record "Currency Exchange Rate";
//                         GLSetup: Record "General Ledger Setup";
//                     begin
//                         GLSetup.get();

//                         if (SalesInvHederRec."Currency Code" = GLSetup."LCY Code") or (SalesInvHederRec."Currency Code" = '') then
//                             TaxAmountdss := Format(SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount)
//                         else begin
//                             ConvertionValue := SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount;
//                             convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvHederRec."Currency Code", GLSetup."LCY Code", SalesInvHederRec."Posting Date");
//                             TaxAmountdss := Format(convertedAmount);
//                         end;

//                     end;
//                 }
//                 textelement(TaxSubtotaldss)
//                 {
//                     XmlName = 'TaxSubtotal';
//                     NamespacePrefix = 'cac';
//                     textelement(TaxAmountdsss)
//                     {
//                         XmlName = 'TaxAmount';
//                         NamespacePrefix = 'cbc';
//                         textattribute(currencyIDdsss)
//                         {
//                             XmlName = 'currencyID';

//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 currencyIDcbc := 'SAR';
//                             end;
//                         }
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin

//                             TaxAmountcbc := 'MappingRequired';
//                         end;
//                     }
//                     textelement(TaxCategorydss)
//                     {
//                         NamespacePrefix = 'cac';
//                         textelement(TaxSchemedsss)
//                         {
//                             XmlName = 'TaxScheme';
//                             NamespacePrefix = 'cac';
//                             textelement(IDdsss)
//                             {
//                                 XmlName = 'ID';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     IDdss := 'VAT';
//                                 end;
//                             }
//                         }
//                     }
//                 }
//             }
//             textelement(TaxTotaldssd)
//             {
//                 XmlName = 'TaxTotal';
//                 NamespacePrefix = 'cac';
//                 textelement(TaxAmountdssd)
//                 {
//                     XmlName = 'TaxAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDdssd)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 currencyIDdssd := SalesInvHederRec."Currency Code"
//                             else
//                                 currencyIDdssd := GLSetup."LCY Code";

//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;

//                         convertedAmount: Decimal;
//                         ConvertionValue: Decimal;
//                         ExchangeRate: Record "Currency Exchange Rate";
//                         GLSetup: Record "General Ledger Setup";
//                     begin
//                         GLSetup.get();

//                         if (SalesInvHederRec."Currency Code" = GLSetup."LCY Code") or (SalesInvHederRec."Currency Code" = '') then
//                             TaxAmountdssd := Format(SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount)
//                         else begin
//                             ConvertionValue := SalesInvHederRec."Amount Including VAT" - SalesInvHederRec.Amount;
//                             convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvHederRec."Currency Code", GLSetup."LCY Code", SalesInvHederRec."Posting Date");
//                             TaxAmountdssd := Format(convertedAmount);
//                         end;

//                     end;
//                 }
//                 textelement(TaxSubtotaldsss)
//                 {
//                     XmlName = 'TaxSubtotal';
//                     NamespacePrefix = 'cac';
//                     textelement(TaxAmountdsse)
//                     {
//                         XmlName = 'TaxAmount';
//                         NamespacePrefix = 'cbc';
//                         textattribute(currencyIDdsse)
//                         {
//                             XmlName = 'currencyID';

//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 currencyIDcbc := 'SAR';
//                             end;
//                         }
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin

//                             TaxAmountcbc := 'MappingRequired';
//                         end;
//                     }
//                     textelement(TaxCategorydsss)
//                     {
//                         NamespacePrefix = 'cac';
//                         textelement(TaxSchemedsse)
//                         {
//                             XmlName = 'TaxScheme';
//                             NamespacePrefix = 'cac';
//                             textelement(IDdsse)
//                             {
//                                 XmlName = 'ID';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     IDdsse := 'VAT';
//                                 end;
//                             }
//                         }
//                     }
//                 }
//             }
//             textelement(LegalMonetaryTotal)
//             {
//                 NamespacePrefix = 'cac';
//                 textelement(TaxInclusiveAmount)
//                 {
//                     XmlName = 'TaxAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDlegal)
//                     {
//                         XmlName = 'currencyID';
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 currencyIDlegal := SalesInvHederRec."Currency Code"
//                             else
//                                 currencyIDlegal := GLSetup."LCY Code";

//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         TaxInclusiveAmount := 'MappingRequired';
//                     end;
//                 }
//                 textelement(PrepaidAmount)
//                 {
//                     XmlName = 'PrepaidAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDLeag)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 currencyIDLeag := SalesInvHederRec."Currency Code"
//                             else
//                                 currencyIDLeag := GLSetup."LCY Code";

//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         PrepaidAmount := 'MappingRequired';
//                     end;
//                 }
//                 textelement(PayableAmount)
//                 {
//                     XmlName = 'PayableAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(currencyIDLaga)
//                     {
//                         XmlName = 'currencyID';

//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 currencyIDLaga := SalesInvHederRec."Currency Code"
//                             else
//                                 currencyIDLaga := GLSetup."LCY Code";

//                         end;
//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin

//                         PayableAmount := 'MappingRequired';
//                     end;
//                 }
//             }

//             tableelement("SalesInvoiceLine"; "Sales Invoice Line")
//             {
//                 XmlName = 'InvoiceLine';
//                 NamespacePrefix = 'cac';
//                 // textattribute(IDcbc)
//                 // {
//                 //     XmlName = 'ID';
//                 //     NamespacePrefix = 'cbc';
//                 //     trigger OnBeforePassVariable()
//                 //     var
//                 //         myInt: Integer;
//                 //     begin
//                 //         IDcbc := 'MappingRequired';
//                 //     end;
//                 // }
//                 fieldelement(IDcbc; SalesInvoiceLine."No.")
//                 {
//                     XmlName = 'ID';
//                     NamespacePrefix = 'cbc';
//                     trigger OnBeforePassField()
//                     var
//                         myInt: Integer;
//                     begin

//                     end;


//                 }
//                 fieldelement(InvoicedQuantity; SalesInvoiceLine.Quantity)
//                 {
//                     XmlName = 'InvoicedQuantity';
//                     NamespacePrefix = 'cbc';
//                 }
//                 textelement(LineExtensionAmount)
//                 {
//                     XmlName = 'LineExtensionAmount';
//                     NamespacePrefix = 'cbc';
//                     textattribute(Line1currencyID)
//                     {
//                         XmlName = 'currencyID';
//                         NamespacePrefix = 'cbc';
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             GLSetup.Get();
//                             if SalesInvHederRec."Currency Code" <> '' then
//                                 Line1currencyID := SalesInvHederRec."Currency Code"
//                             else
//                                 Line1currencyID := GLSetup."LCY Code";

//                         end;

//                     }
//                     trigger OnBeforePassVariable()
//                     var
//                         myInt: Integer;
//                     begin
//                         LineExtensionAmount := Format(SalesInvoiceLine."Line Amount");
//                     end;
//                 }

//                 textelement(LineTaxTotal)
//                 {
//                     XmlName = 'TaxTotal';
//                     NamespacePrefix = 'cac';
//                     textelement(LineTaxAmount)
//                     {
//                         NamespacePrefix = 'cbc';
//                         XmlName = 'TaxAmount';
//                         textattribute(LinecurrencyID)
//                         {
//                             XmlName = 'currencyID';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 GLSetup.Get();
//                                 if SalesInvHederRec."Currency Code" <> '' then
//                                     LinecurrencyID := SalesInvHederRec."Currency Code"
//                                 else
//                                     LinecurrencyID := GLSetup."LCY Code";

//                             end;
//                         }
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;

//                             convertedAmount: Decimal;
//                             ConvertionValue: Decimal;
//                             ExchangeRate: Record "Currency Exchange Rate";
//                             GLSetup: Record "General Ledger Setup";
//                         begin
//                             GLSetup.get();

//                             if (SalesInvHederRec."Currency Code" = GLSetup."LCY Code") or (SalesInvHederRec."Currency Code" = '') then
//                                 LineTaxAmount := Format(SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount)
//                             else begin
//                                 ConvertionValue := SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount;
//                                 convertedAmount := ExchangeRate.ExchangeAmount(ConvertionValue, SalesInvHederRec."Currency Code", GLSetup."LCY Code", SalesInvHederRec."Posting Date");
//                                 LineTaxAmount := Format(convertedAmount);
//                             end;

//                         end;
//                     }

//                 }
//                 textelement(LineItem)
//                 {
//                     XmlName = 'Item';
//                     NamespacePrefix = 'cac';
//                     textelement(LineName)
//                     {
//                         XmlName = 'Name';
//                         NamespacePrefix = 'cbc';
//                         trigger OnBeforePassVariable()
//                         var
//                             myInt: Integer;
//                         begin
//                             LineName := SalesInvoiceLine.Description;
//                         end;
//                     }
//                     textelement(LineClassifiedTaxCategory)
//                     {
//                         XmlName = 'ClassifiedTaxCategory';
//                         NamespacePrefix = 'cac';
//                         textelement(LineID)
//                         {
//                             XmlName = 'ID';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 LineID := SalesInvoiceLine."No.";
//                             end;
//                         }
//                         textelement(LinePercent)
//                         {
//                             XmlName = 'Percent';
//                             NamespacePrefix = 'cbc';
//                             trigger OnBeforePassVariable()
//                             var
//                                 myInt: Integer;
//                             begin
//                                 LineID := Format(SalesInvoiceLine."VAT %");
//                             end;
//                         }
//                         textelement(LineTaxScheme)
//                         {
//                             XmlName = 'TaxScheme';
//                             NamespacePrefix = 'cac';
//                             textelement(Line2ID)
//                             {
//                                 XmlName = 'ID';
//                                 NamespacePrefix = 'cbc';
//                                 trigger OnBeforePassVariable()
//                                 var
//                                     myInt: Integer;
//                                 begin
//                                     Line2ID := 'VAT';
//                                 end;
//                             }
//                         }
//                     }
//                 }
//                 trigger OnPreXmlItem()
//                 var
//                 begin
//                     SalesInvoiceLine.Reset();
//                     SalesInvoiceLine.SetRange("Document No.", SalesInvHederRec."No.");
//                     if SalesInvoiceLine.FindSet() then;
//                 end;

//             }

//         }
//     }
//     procedure SetSources(InvHdrRec: Record "Sales Invoice Header")
//     var
//     // SSSS:XmlPort "Sales Invoice - PEPPOL 2.0"
//     begin
//         if SalesInvHederRec.Get(InvHdrRec."No.") then;
//         if Customer_Rec.Get(SalesInvHederRec."Sell-to Customer No.") then;
//         SalesInvHederRec.CalcFields(Amount, "Amount Including VAT");

//     end;

//     trigger OnPreXmlPort()
//     var
//     begin
//         if CompanyInfo_Rec.get() then;
//     end;

//     trigger OnPostXmlPort()
//     var
//     begin
//         currXMLport.Filename(Format(CurrentDateTime()) + '.xml');
//     end;

//     var
//         CompanyInfo_Rec: Record "Company Information";
//         SalesInvHederRec: Record "Sales Invoice Header";
//         Customer_Rec: Record Customer;
//         GLSetup: Record "General Ledger Setup";
// }