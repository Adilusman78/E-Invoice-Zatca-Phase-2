report 70500 "Arabic Invoice DSSS"
{
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Arbic Invoice';
    RDLCLayout = './ReportsLayout/Arabic Invoice1.rdl';

    dataset
    {
        dataitem(SalesInvoicHeader; "Sales Invoice Header")
        {

            RequestFilterFields = "No.", "No. Printed", "Sell-to Customer No.";

            column(CompanyInfo_Picture; CompanyInformation.Picture)
            {

            }
            column(BarcodeStr; BarcodeStr) { }
            column(Your_Reference; "Your Reference")
            {

            }
            column(Cust_CompanyType; Customer."Company Type_DSSS")
            {

            }
            column(Cust_Arabic_Country; Customer."Arabic Country_DSSS")
            {

            }
            column(Cust_Country; Customer.Name)
            {

            }
            column(Cust_Arabic_PostCode; Customer."Arabic PostalCode_DSSS")
            {

            }
            column(Cust_Arabic_AdditionalNo; Customer."Arabic Additional No_DSSS")
            {

            }
            column(Cust_Arabic_VAT; Customer."Arabic VAT No_DSSS")
            {

            }
            column(Cust_Arabic_OBuyerID; Customer."Arabic Other Buyer ID_DSSS")
            {

            }
            column(Company_ArabicCountry; CompanyInformation."Arabic Country_DSSS")
            {

            }
            column(Company_Arabic_PostCode; CompanyInformation."Arabic PostalCode_DSSS")
            {

            }
            column(Company_ArabicAdditionalNo; CompanyInformation."Arabic Additional No_DSSS")
            {

            }
            column(Company_ArabicVAtNo; CompanyInformation."Arabic VAT No_DSSS")
            {

            }
            column(Company_Arabic_OtherSeller;
            CompanyInformation."Arabic Other Seller ID_DSSS")
            {

            }
            column(ConvertedTotalExclVat; ConvertedTotalExclVat)
            {

            }

            column(ConvertedTotalVATAmt; ConvertedTotalVATAmt)
            {

            }
            column(ConvertedTotalNetAmt; ConvertedTotalNetAmt)
            {

            }

            column(ConvertedTotalDiscAmt; ConvertedTotalDiscAmt)
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            // column(CheckThisAmt; notext[1] + ' ' + notext[2])
            // {
            // }
            column(CheckThisAmt; TotalAmountInWords)
            {
            }
            column(TotalAmountInWordsENG; TotalAmountInWordsENG)
            {

            }
            column(temptext; temptext)
            {

            }
            column(AreaDesc; AreaDesc.Text)
            {

            }
            column("Area_ArabicDesc"; AreaDesc."Arabic Text DSSS")
            {

            }
            column(PaymntDesc; PaymentMethod.Description)
            {

            }
            column(Order_Date; Format("Order Date"))
            {
            }
            column(Posting_Date; Format("Posting Date"))
            {
            }

            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {

            }
            column(Amount; Amount)
            {

            }
            column(Invoice_Discount_Amount; "Invoice Discount Amount")
            {

            }
            column(TotalVAT_VATSSS; "Amount Including VAT" - Amount)
            {

            }
            column(ToatlAmount_Due_VAT; "Amount Including VAT")
            {

            }

            column(Cust_District; Customer.District_DSSS)
            {

            }
            column(Cust_StreetName; Customer."Street Name_DSSS")
            {

            }
            column(Cust_BuildinNo; Customer."Building No_DSSS")
            {

            }

            column(Sell_to_City; "Sell-to City")
            {

            }
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {

            }
            column(Sell_to_Post_Code; "Sell-to Post Code")
            {

            }
            column(Cust_Vat; Customer."VAT Registration No.")
            {

            }

            column(SalespersonPurchaser; SalespersonPurchaser.Name)
            {

            }

            column(TransSpec; TransactionSpecification.Text)
            {

            }
            column(Salesperson_Code; "Salesperson Code")
            {

            }


            column(TrnspMethod; TransportMethod.Description)
            {

            }
            column(TtypeDesc; TransactionType.Description)
            {

            }

            column(ShipMthdDesc; ShipmentMethod.Description)
            {

            }
            column(PaymentTermsDesc; PaymentTermsDesc.Description)
            {

            }
            column(No_; "No.")
            {

            }
            column(CustArabic_Street; Customer."Arabic Street Name_DSSS")
            {

            }
            column(CustArabic_Name; Customer."Arabic Name_DSSS")
            {

            }
            column(CustArabic_Dist; Customer."Arabic District_DSSS")
            {

            }
            column(CustArabic_City; Customer."Arabic City_DSSS")
            {

            }
            column(CustArabic_Building; Customer."Arabic Building No_DSSS")
            {

            }
            column(Cust_AdditionalNo; Customer."Additional No_DSSS")
            {

            }
            column(Cust_OtherBuyer; Customer."Other Buyer ID_DSSS")
            {

            }
            column(Document_Date; "Document Date")
            {

            }

            column(CompanyName; CompanyInformation.Name)
            {

            }
            column(Company_Phone; CompanyInformation."Phone No.")
            {

            }
            column(Company_PostCode; CompanyInformation."Post Code")
            {

            }
            column(CompanyBuilding; CompanyInformation."Building No_DSSS")
            {

            }
            column(CompanyStreet; CompanyInformation."Street Name_DSSS")
            {

            }
            column(CompanyDistrict; CompanyInformation.District_DSSS)
            {

            }
            column(CompanyCity; CompanyInformation.City)
            {

            }
            column(CompanyCountry; CountryRegion.Name)
            {

            }
            column(CompanyCountryCode; CompanyInformation."Country/Region Code")
            {

            }
            column(CompanyPostalCode; CompanyInformation."Post Code")
            {

            }
            column(CompanyVAt_Number; CompanyInformation."VAT Registration No.")
            {

            }
            column(CompanyArabic_Building; CompanyInformation."Arabic Building No_DSSS")
            {

            }
            column(CompanyArabic_City; CompanyInformation."Arabic City_DSSS")
            {

            }
            column(CompanyArabic_Dist; CompanyInformation."Arabic District_DSSS")
            {

            }
            column(CompanyArabic_Name; CompanyInformation."Arabic Name_DSSS")
            {

            }
            column(CompanyArabic_Street; CompanyInformation."Arabic Street Name_DSSS")
            {

            }
            column(CompanyAdditionalNo; CompanyInformation."Additional No_DSSS")
            {


            }
            column(CompanyOtherSellerID; CompanyInformation."Other Seller ID_DSSS")
            {

            }
            column(temp; barcode2)
            {

            }


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = SalesInvoicHeader;
                DataItemTableView = sorting("Document No.", "Line No.");

                column(SalesLine_Quantity; Quantity)
                {

                }
                column(SerialNo; SerialNo)
                {

                }
                column(Description; Description)
                {

                }
                column(Arabic_Desc; item_lRec."Arabic Description DSSS")
                {

                }
                column(SalesLine_Unit_Price; "Unit Price")
                {

                }
                column(SalesLine_Line_Discount_Amount; "Line Discount Amount")
                {

                }
                column(SalesLine_Amount; "Line Amount")
                {

                }
                column(SalesLine_VAT_Base_Amount; "Amount Including VAT" - "Line Amount")
                {

                }
                column(SalesLine_Amount_Including_VAT; "Amount Including VAT")
                {

                }
                column(SalesLine_No_; "No.")
                {

                }
                column(SalesLineLine_No_; "Line No.")
                {

                }
                column(SalesLine_VAT__; "VAT %")
                {

                }
                column(TotalLineDiscount_Amot; TotalLineDiscount_Amot)
                {

                }
                column(ConvertedTotalLineDiscount_Amot; ConvertedTotalLineDiscount_Amot)
                {

                }
                column(ConvertedLineDiscount_Amot; ConvertedLineDiscount_Amot)
                {

                }
                trigger OnAfterGetRecord()
                var
                    // myInt: Integer;
                    txtCRLF: Text[2];
                begin

                    clear(itemDesc);
                    item_lRec.Reset();
                    if item_lRec.Get("Sales Invoice Line"."No.") then begin
                        txtCRLF := 'xx';
                        txtCRLF[1] := 13;
                        txtCRLF[2] := 10;
                        itemDesc := "Sales Invoice Line".Description + txtCRLF + item_lRec."Arabic Description DSSS";
                    end
                    else
                        itemDesc := "Sales Invoice Line".Description;

                    TotalLineDiscount_Amot += "Line Discount Amount";
                    if "Line Discount Amount" <> 0 then begin
                        CurrencyExchangeRate.FindCurrency(SalesInvoicHeader."Posting Date", 'SAR', 1);
                        CurrencyConverter := CurrencyExchangeRate."Exchange Rate Amount" / CurrencyExchangeRate."Relational Exch. Rate Amount";
                        IF (SalesInvoicHeader."Currency Code" = 'SAR') then
                            convertedTotalLineDiscount_Amot += "Line Discount Amount"
                        else
                            convertedTotalLineDiscount_Amot += ("Line Discount Amount" * CurrencyConverter);
                    end;

                    if lastcate = '' then begin
                        lastcate := "Sales Invoice Line"."Item Category Code";
                        temptext := "Sales Invoice Line"."Item Category Code";
                    end;


                    if lastcate <> "Sales Invoice Line"."Item Category Code" then begin
                        temptext += ' / ' + "Sales Invoice Line"."Item Category Code";
                        lastcate := "Sales Invoice Line"."Item Category Code";
                    end;
                    IF ItemCont.GET("Sales Invoice Line"."No.") then; //begin

                    IF ItemCategory.get(ItemCont."Item Category Code") then;
                    // else begin

                    // temptext := "Sales Invoice Line"."Item Category Code";

                    //end;
                    IF (("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) OR ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") OR ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Fixed Asset") OR ("Sales Invoice Line".Type = "Sales Invoice Line".Type::Resource) OR ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)")) and ("Sales Invoice Line".Quantity <> 0) THEN
                        SerialNo := SerialNo + 1;

                end;

            }
            trigger OnPreDataItem()
            var
            // myInt: Integer;
            begin
                //Check.InitTextVariable();
                Clear(SerialNo);
            end;

            trigger OnAfterGetRecord()
            var
                CheckReportENG: Report Check;
                NumberInText: array[2] of Text[250];
                NumberInTextENG: array[2] of Text;
                DecimalNumber: Decimal;
                DecimalNumberENG: Decimal;
            begin
                Clear(DecimalNumber);
                Clear(DecimalNumberENG);
                CountryRegion.Reset();
                CountryRegion.Reset();
                IF SalespersonPurchaser.get(SalesInvoicHeader."Salesperson Code") then;
                if TransactionType.Get(SalesInvoicHeader."Transaction Type") THEN;
                if PaymentMethod.get(SalesInvoicHeader."Payment Method Code") THEN;
                IF TransactionSpecification.Get(SalesInvoicHeader."Transaction Specification") THEN;
                IF AreaDesc.GET(SalesInvoicHeader."Area") THEN;
                IF TransportMethod.GET(SalesInvoicHeader."Transport Method") THEN;
                IF ShipmentMethod.get(SalesInvoicHeader."Shipment Method Code") THEN;
                IF PaymentTermsDesc.Get(SalesInvoicHeader."Payment Terms Code") then;

                CALCFIELDS("Work Description");
                ShowWorkDescription := "Work Description".HASVALUE;


                Customer.Reset();
                if Customer.Get("Sell-to Customer No.") then;
                if Customer."Company Type_DSSS" = Customer."Company Type_DSSS"::Individual then
                    DesignQRCode(SalesInvoicHeader);

                if CompanyInformation.Get() then
                    CompanyInformation.CalcFields(Picture);

                if CountryRegion.Get(CompanyInformation."Country/Region Code") then;
                if CountryRegion.Get(Customer."Country/Region Code") then;
                CALCFIELDS(SalesInvoicHeader."Amount Including VAT");
                CalcFields(SalesInvoicHeader.Amount);
                IF (SalesInvoicHeader."Currency Code" = 'SAR') then begin
                    // CurrencyConverter := CurrencyExchangeRate."Exchange Rate Amount" / CurrencyExchangeRate."Relational Exch. Rate Amount";
                    ConvertedTotalExclVat := SalesInvoicHeader.Amount;
                    ConvertedTotalDiscAmt := SalesInvoicHeader."Invoice Discount Amount";
                    ConvertedTotalNetAmt := SalesInvoicHeader."Amount Including VAT";
                    ConvertedTotalVATAmt := (SalesInvoicHeader."Amount Including VAT" - SalesInvoicHeader.Amount);
                end
                else begin

                    CurrencyExchangeRate.FindCurrency(SalesInvoicHeader."Posting Date", 'SAR', 1);
                    //IF CurrencyExchangeRate."Exchange Rate Amount" > 1 then begin
                    CurrencyConverter := CurrencyExchangeRate."Exchange Rate Amount" / CurrencyExchangeRate."Relational Exch. Rate Amount";
                    ConvertedTotalExclVat := SalesInvoicHeader.Amount * CurrencyConverter;
                    ConvertedTotalDiscAmt := SalesInvoicHeader."Invoice Discount Amount" * CurrencyConverter;
                    ConvertedTotalNetAmt := SalesInvoicHeader."Amount Including VAT" * CurrencyConverter;
                    ConvertedTotalVATAmt := (SalesInvoicHeader."Amount Including VAT" - SalesInvoicHeader.Amount) * CurrencyConverter;
                end;
                // CheckReportENG.InitTextVariable();
                // CheckReportENG.FormatNoText(NumberInTextENG, ConvertedTotalNetAmt, 'HALALA');
                if NumberInTextENG[2] <> '' then //Mesam 24.2.2020 if there is value in [2] then concatenate.
                    TotalAmountInWordsENG := CopyStr(NumberInTextENG[1] + ' ' + NumberInTextENG[2], 6)
                else
                    TotalAmountInWordsENG := CopyStr(NumberInTextENG[1], 6); //Mesam 24.2.2020 if not then let go as it is.
                TotalAmountInWordsENG := InsStr(TotalAmountInWordsENG, ' RIYAL', StrPos(TotalAmountInWordsENG, ' AND')); //Mesam 24.2.2020 Changed from US Dollars to Dollars with Jaydeep.
                if (StrPos(TotalAmountInWordsENG, '/')) <> 0 then //Mesam 24.2.2020 if you found / make the code work as originally written.
                    Evaluate(DecimalNumberENG, DelChr(CopyStr(TotalAmountInWordsENG, StrPos(TotalAmountInWordsENG, ' AND'), (StrPos(TotalAmountInWordsENG, '/') - StrPos(TotalAmountInWordsENG, ' AND'))), '=', ' AND '));
              //  CheckReportENG.FormatNoText(NumberInTextENG, DecimalNumberENG, '');
                if (StrPos(TotalAmountInWordsENG, ' HALALA')) <> 0 then begin
                    TotalAmountInWordsENG := DelStr(TotalAmountInWordsENG, (StrPos(TotalAmountInWordsENG, ' AND') + 5), (StrPos(TotalAmountInWordsENG, ' HALALA') - (StrPos(TotalAmountInWordsENG, ' AND') + 5)));
                    TotalAmountInWordsENG := InsStr(TotalAmountInWordsENG, CopyStr(NumberInTextENG[1], 6, (StrPos(NumberInTextENG[1], ' AND') - 6)), StrPos(TotalAmountInWordsENG, ' HALALA'));
                end;
                if (StrPos(TotalAmountInWordsENG, ' HALALA')) = 0 then
                    TotalAmountInWordsENG := TotalAmountInWordsENG;

                /* 
                                CheckReportENG.FormatNoText(NumberInTextENG, ConvertedTotalNetAmt, 'HALALA');
                                TotalAmountInWordsENG := CopyStr(NumberInTextENG[1], 6);
                                TotalAmountInWordsENG := InsStr(TotalAmountInWordsENG, ' RIYAL', StrPos(TotalAmountInWordsENG, ' AND'));
                                Evaluate(DecimalNumberENG, DelChr(CopyStr(TotalAmountInWordsENG, StrPos(TotalAmountInWordsENG, ' AND'), (StrPos(TotalAmountInWordsENG, '/') - StrPos(TotalAmountInWordsENG, ' AND'))), '=', ' AND '));
                                CheckReportENG.FormatNoText(NumberInTextENG, DecimalNumberENG, '');
                                if (StrPos(TotalAmountInWordsENG, ' HALALA')) <> 0 then begin

                                    TotalAmountInWordsENG := DelStr(TotalAmountInWordsENG, (StrPos(TotalAmountInWordsENG, ' AND') + 5), (StrPos(TotalAmountInWordsENG, ' HALALA') - (StrPos(TotalAmountInWordsENG, ' AND') + 5)));

                                    TotalAmountInWordsENG := InsStr(TotalAmountInWordsENG, CopyStr(NumberInTextENG[1], 6, (StrPos(NumberInTextENG[1], ' AND') - 6)), StrPos(TotalAmountInWordsENG, ' HALALA'));
                                end;
                                if (StrPos(TotalAmountInWordsENG, ' HALALA')) = 0 then
                                    TotalAmountInWordsENG := TotalAmountInWordsENG;
                 */


                DecimalNumber := Round(ConvertedTotalNetAmt - Round(ConvertedTotalNetAmt, 1, '<'), 0.01, '=');
                DecimalNumber := DecimalNumber * 100;
                ArabicInvoiceManagmentDSSS.InitTextVariable();
                ArabicInvoiceManagmentDSSS.FormatNoText(NumberInText, Round(ConvertedTotalNetAmt, 1, '<'), ' ريال');
                // TotalAmountInWords := CopyStr(NumberInText[1], 6);
                TotalAmountInWords := NumberInText[1];

                if TotalAmountInWords.Contains('و ريال') then
                    TotalAmountInWords := TotalAmountInWords.Replace('و ريال', 'ريال');

                // TotalAmountInWords := InsStr(TotalAmountInWords, ' ريال', StrPos(TotalAmountInWords, 'و ريال'));
                // Evaluate(DecimalNumber, DelChr(CopyStr(TotalAmountInWords, StrPos(TotalAmountInWords, ' و'), (StrPos(TotalAmountInWords, '/') - StrPos(TotalAmountInWords, ' و'))), '=', ' و '));
                if DecimalNumber > 0 then begin
                    ArabicInvoiceManagmentDSSS.FormatNoText(NumberInText, DecimalNumber, '');
                    TotalAmountInWords := TotalAmountInWords + ' و ' + NumberInText[1] + ' هللة ';
                end;
                // if (StrPos(TotalAmountInWords, ' ملفات')) <> 0 then begin

                //     TotalAmountInWords := DelStr(TotalAmountInWords, (StrPos(TotalAmountInWords, ' و') + 5), (StrPos(TotalAmountInWords, ' ملفات') - (StrPos(TotalAmountInWords, ' و') + 5)));

                //     TotalAmountInWords := InsStr(TotalAmountInWords, CopyStr(NumberInText[1], 6, (StrPos(NumberInText[1], ' و') - 6)), StrPos(TotalAmountInWords, ' ملفات'));
                // end;
                // if (StrPos(TotalAmountInWords, ' ملفات')) = 0 then
                //     TotalAmountInWords := TotalAmountInWords;
                // end;
                // end;
            end;
        }
        dataitem(WorkDescriptionLines; "Integer")
        {
            column(WorkDescriptionLineNumber; Number)
            {
            }
            column(WorkDescriptionLine; WorkDescriptionLine)
            {
            }

            trigger OnAfterGetRecord();
            begin
                // if not TempBlobWorkDescription.MoreTextLines then
                //     CurrReport.BREAK;
                // WorkDescriptionLine := TempBlobWorkDescription.ReadTextLine;

                WorkDescriptionLine := SalesInvoicHeader.GetWorkDescription();
            end;

            trigger OnPostDataItem();
            begin
                // CLEAR(TempBlobWorkDescription);
            end;

            trigger OnPreDataItem();
            begin
                if not ShowWorkDescription then
                    CurrReport.BREAK();
                // TempBlobWorkDescription.Blob := SalesInvoicHeader."Work Description";
            end;
        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                //         ApplicationArea = All;

                //     }
                // }

            }
        }

        actions
        {
            area(processing)
            {
                // action(ActionName)
                // {
                //     ApplicationArea = All;

                // }
            }
        }
    }
    trigger OnInitReport();
    begin
        CompanyInformation.SETAUTOCALCFIELDS(Picture);
        if CompanyInformation.GET() then;
    end;

    var
        CountryRegion: Record "Country/Region";
        // CountryRegion: Record "Country/Region";
        ItemCategory: Record "Item Category";
        ItemCont: Record Item;
        TransactionType: Record "Transaction Type";
        PaymentMethod: Record "Payment Method";
        TransactionSpecification: Record "Transaction Specification";
        AreaDesc: Record "Area";
        TransportMethod: Record "Transport Method";
        ShipmentMethod: Record "Shipment Method";
        Customer: Record Customer;
        CompanyInformation: Record "Company Information";
        item_lRec: Record Item;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        PaymentTermsDesc: Record "Payment Terms";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        Check: Report Check;
        ArabicInvoiceManagmentDSSS: Codeunit ArabicInvoiceManagment_DSSS;
        // SARAmount: Decimal;
        TotalAmountInWords: Text;
        TotalAmountInWordsENG: text;
        temptext: Text[100];
        SerialNo: Integer;

        BarCode2: text;
        lastcate: Code[20];
        // Loltext: Text[100];
        // LastCat: Code[20];
        WorkDescriptionLine: Text;
        ShowWorkDescription: Boolean;
        TotalLineDiscount_Amot: Decimal;
        ConvertedTotalLineDiscount_Amot: Decimal;
        ConvertedLineDiscount_Amot: Decimal;

        CurrencyConverter: Decimal;
        // notext: array[2] of Text[80];


        itemDesc: Text;
        ConvertedTotalExclVat: Decimal;
        ConvertedTotalDiscAmt: Decimal;
        ConvertedTotalVATAmt: Decimal;
        ConvertedTotalNetAmt: Decimal;
        BarcodeStr: Text;


    procedure DesignQRCode(_SalesInvoiceHeader: Record "Sales Invoice Header");
    var
        OutStream: OutStream;
        BarcodeSym: Enum "Barcode Symbology 2D";
        barcodeProvider: Interface "Barcode Font Provider 2D";
        Base64: Codeunit "Base64 Convert";
        text1: Text;
    begin
        // VATAmt2 := Format(VATInput, 0, 2);
        barcodeProvider := enum::"Barcode Font Provider 2D"::IDAutomation2D;
        BarcodeSym := Enum::"Barcode Symbology 2D"::"QR-Code";
        BarcodeStr := barcodeProvider.EncodeFont(_SalesInvoiceHeader."ZATCA QR Code", BarcodeSym);
    end;

    procedure DecToBinUTF8(DecVal: Decimal) BinVal: Text
    var
    begin
        case DecVal of
            0:
                BinVal := '00000000';
            1:
                BinVal := '00000001';
            2:
                BinVal := '00000010';
            3:
                BinVal := '00000011';
            4:
                BinVal := '00000100';
            5:
                BinVal := '00000101';
            6:
                BinVal := '00000110';
            7:
                BinVal := '00000111';
            8:
                BinVal := '00001000';
            9:
                BinVal := '00001001';
            10:
                BinVal := '00001010';
            11:
                BinVal := '00001011';
            12:
                BinVal := '00001100';
            13:
                BinVal := '00001101';
            14:
                BinVal := '00001110';
            15:
                BinVal := '00001111';
            16:
                BinVal := '00010000';
            17:
                BinVal := '00010001';
            18:
                BinVal := '00010010';
            19:
                BinVal := '00010011';
            20:
                BinVal := '00010100';
            21:
                BinVal := '00010101';
            22:
                BinVal := '00010110';
            23:
                BinVal := '00010111';
            24:
                BinVal := '00011000';
            25:
                BinVal := '00011001';
            26:
                BinVal := '00011010';
            27:
                BinVal := '00011011';
            28:
                BinVal := '00011100';
            29:
                BinVal := '00011101';
            30:
                BinVal := '00011110';
            31:
                BinVal := '00011111';
            32:
                BinVal := '00100000';
            33:
                BinVal := '00100001';
            34:
                BinVal := '00100010';
            35:
                BinVal := '00100011';
            36:
                BinVal := '00100100';
            37:
                BinVal := '00100101';
            38:
                BinVal := '00100110';
            39:
                BinVal := '00100111';
            40:
                BinVal := '00101000';
            41:
                BinVal := '00101001';
            42:
                BinVal := '00101010';
            43:
                BinVal := '00101011';
            44:
                BinVal := '00101100';
            45:
                BinVal := '00101101';
            46:
                BinVal := '00101110';
            47:
                BinVal := '00101111';
            48:
                BinVal := '00110000';
            49:
                BinVal := '00110001';
            50:
                BinVal := '00110010';
            51:
                BinVal := '00110011';
            52:
                BinVal := '00110100';
            53:
                BinVal := '00110101';
            54:
                BinVal := '00110110';
            55:
                BinVal := '00110111';
            56:
                BinVal := '00111000';
            57:
                BinVal := '00111001';
            58:
                BinVal := '00111010';
            59:
                BinVal := '00111011';
            60:
                BinVal := '00111100';
        end;
    end;
}