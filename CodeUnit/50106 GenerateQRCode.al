codeunit 70504 "Generate QR Code"
{
    trigger OnRun()
    begin

    end;

    procedure InitArguments(DocNo: text; SalesInvoicHeader: Record "Sales Header"; CompanyInformation: Record "Company Information"): text
    var

        Base64Convert: Codeunit "Base64 Convert";
        Base64ConvertDSSS: Codeunit Base64ConrtDSSS;
        TempBlob: Codeunit "Temp Blob";
        // TypeHelper: Codeunit "Type Helper";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        InStream: InStream;
        QrCodeParameter: Text;
        TLBinaryVal: Text;
        _CuttentDateTime: Text;
    begin
        Clear(HttpClient);
        Clear(InStream);
        Clear(HttpResponseMessage);
        Clear(QrCodeParameter);
        Clear(TLBinaryVal);
        Clear(DocNo);

        SalesInvoicHeader.CalcFields("Amount Including VAT", Amount);
        Clear(QrCodeParameter);
        // TLV - 1
        TLBinaryVal := DecToBinUTF8(1) + DecToBinUTF8(StrLen(CompanyInformation.Name));
        TLBinaryVal := Base64ConvertDSSS.BinaryToText(TLBinaryVal);
        QrCodeParameter := TLBinaryVal + CompanyInformation.Name;
        // TLV - 1 Ends

        // TLV - 2
        TLBinaryVal := DecToBinUTF8(2) + DecToBinUTF8(StrLen(CompanyInformation."VAT Registration No."));
        QrCodeParameter := QrCodeParameter + Base64ConvertDSSS.BinaryToText(TLBinaryVal);
        QrCodeParameter := QrCodeParameter + CompanyInformation."VAT Registration No.";
        // TLV - 2 Ends

        // TLV - 3
        // Clear(_CuttentDateTime);
        _CuttentDateTime := ConvertTdatetime(SalesInvoicHeader);
        TLBinaryVal := DecToBinUTF8(3) + DecToBinUTF8(StrLen(format(_CuttentDateTime)));
        QrCodeParameter := QrCodeParameter + Base64ConvertDSSS.BinaryToText(TLBinaryVal);
        QrCodeParameter := QrCodeParameter + Format(_CuttentDateTime);

        // TLV - 3 Ends

        // TLV - 4
        TLBinaryVal := DecToBinUTF8(4) + DecToBinUTF8(StrLen(Format(SalesInvoicHeader."Amount Including VAT")));
        QrCodeParameter := QrCodeParameter + Base64ConvertDSSS.BinaryToText(TLBinaryVal);
        QrCodeParameter := QrCodeParameter + Format(SalesInvoicHeader."Amount Including VAT");
        // TLV - 4 Ends

        // TLV - 5
        TLBinaryVal := DecToBinUTF8(5) + DecToBinUTF8(StrLen(Format(SalesInvoicHeader."Amount Including VAT" - SalesInvoicHeader.Amount)));
        QrCodeParameter := QrCodeParameter + Base64ConvertDSSS.BinaryToText(TLBinaryVal);
        QrCodeParameter := QrCodeParameter + Format(SalesInvoicHeader."Amount Including VAT" - SalesInvoicHeader.Amount);
        // TLV - 5 Ends

        QrCodeParameter := Base64Convert.ToBase64(QrCodeParameter);

        TempBlob.CreateInStream(InStream);
        HttpResponseMessage.Content().ReadAs(InStream);
        BarCode2 := Base64Convert.ToBase64(InStream);

        exit(QrCodeParameter);
    end;

    procedure ConvertTdatetime(SalesInvoicHeader: Record "Sales Header"): Text
    var
        InvoiceDateTime: Text;
        InvoiceDateTimeRmPM: Text;
        _Date: Date;
        _Josn: JsonValue;
        PostingDateTxt: text[80];
        BarcodeString: Text;
        _Time1: Text;
        _DashDate: Text;
    begin
        Clear(_Time1);
        Clear(_Date);
        Clear(InvoiceDateTime);
        Clear(InvoiceDateTimeRmPM);
        _Time1 := TimeFormat(SalesInvoicHeader.SystemModifiedAt);
        _Date := (SalesInvoicHeader."Posting Date");//calculate Datefrom date
        _DashDate := _DashDate(_Date);
        PostingDateTxt := Format(Date2DMY(_Date, 03)) + '-' + Format(Date2DMY(_Date, 02)) + '-' + Format(Date2DMY(_Date, 01));
        InvoiceDateTime := ((Format(_DashDate) + ' ' + Format(_Time1)));



        // InvoiceDateTime := DELCHR((Format(_DashDate) + 'T' + Format(_Time1)), '=', ' م');
        // IF InvoiceDateTime.Contains('PM') then
        //     InvoiceDateTimeRmPM := DelChr(Format(InvoiceDateTime), '=', 'PM');
        // IF InvoiceDateTime.Contains('AM') then
        //     InvoiceDateTimeRmPM := DelChr(Format(InvoiceDateTime), '=', 'AM');

        InvoiceDateTimeRmPM := InvoiceDateTime;
        InvoiceDateTimeRmPM := Format(InvoiceDateTimeRmPM);
        exit(InvoiceDateTimeRmPM);
    end;

    procedure _DashDate(_date: Date): Text
    begin
        //exit(Format(_date, 0, '<Year4>-<Month,2>-<Day,2>'));
        exit(Format(_date, 0, '<Month,2>-<Day,2>-<Year4>'));
    end;

    procedure TimeFormat(_Tieme: DateTime): Text
    begin
        // exit(Format(_Tieme, 0, '<Hours24,2>:<Minutes,2>:<Seconds,3>'));
        exit(Format(_Tieme, 0, '<Hours24,2>:<Minutes,2>'));
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

    var
        BarCode2: Text;
}