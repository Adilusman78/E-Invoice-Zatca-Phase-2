codeunit 70500 "ArabicInvoiceManagment_DSSS"
{
    trigger OnRun()
    begin

    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    //DecimalPosition: Decimal;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        // NoText[1] := '****';
        NoText[1] := '';
        GeneralLedgerSetup.Get();


        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026Lbl)
        else
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;

                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    if (Tens > 0) or (ones > 0) then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, Text027Lbl + ' و')
                    else
                        AddToNoText(NoText, NoTextIndex, PrintExponent, Text027Lbl);
                end;
                if Tens >= 2 then begin
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones] + ' و');
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);


                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);

                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent] + ' و');
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

        // AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        // DecimalPosition := GetAmtDecimalPosition;
        // AddToNoText(NoText, NoTextIndex, PrintExponent, (Format(No * DecimalPosition) + '/' + Format(DecimalPosition)));

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

        OnAfterFormatNoText(NoText, No, CurrencyCode);
    end;

    // local procedure GetAmtDecimalPosition(): Decimal
    // var
    //     Currency: Record Currency;
    // begin
    //     if GLSetup.Get() then;

    //     exit(1 / GLSetup."Amount Rounding Precision");
    // end;

    local procedure AddToNoText(var NoText: array[2] of Text; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text029Lbl, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text032Lbl;
        OnesText[2] := Text033Lbl;
        OnesText[3] := Text034Lbl;
        OnesText[4] := Text035Lbl;
        OnesText[5] := Text036Lbl;
        OnesText[6] := Text037Lbl;
        OnesText[7] := Text038Lbl;
        OnesText[8] := Text039Lbl;
        OnesText[9] := Text040Lbl;
        OnesText[10] := Text041Lbl;
        OnesText[11] := Text042Lbl;
        OnesText[12] := Text043Lbl;
        OnesText[13] := Text044Lbl;
        OnesText[14] := Text045Lbl;
        OnesText[15] := Text046Lbl;
        OnesText[16] := Text047Lbl;
        OnesText[17] := Text048Lbl;
        OnesText[18] := Text049Lbl;
        OnesText[19] := Text050Lbl;

        TensText[1] := '';
        TensText[2] := Text051Lbl;
        TensText[3] := Text052Lbl;
        TensText[4] := Text053Lbl;
        TensText[5] := Text054Lbl;
        TensText[6] := Text055Lbl;
        TensText[7] := Text056Lbl;
        TensText[8] := Text057Lbl;
        TensText[9] := Text058Lbl;

        ExponentText[1] := '';
        ExponentText[2] := Text059Lbl;
        ExponentText[3] := Text060Lbl;
        ExponentText[4] := Text061Lbl;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    begin
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        Text026Lbl: Label 'صفر';
        Text027Lbl: Label 'مائة';
        // Text028Lbl: Label 'و';
        Text029Lbl: Label '%1 results in a written number that is too long.', Comment = '%1=results in a written';
        Text032Lbl: Label 'واحد';
        Text033Lbl: Label 'اثنين';
        Text034Lbl: Label 'ثلاثة';
        Text035Lbl: Label 'أربعة';
        Text036Lbl: Label 'خمسة';
        Text037Lbl: Label 'ستة';
        Text038Lbl: Label 'سبعة';
        Text039Lbl: Label 'ثمانية';
        Text040Lbl: Label 'تسع';
        Text041Lbl: Label 'عشرة';
        Text042Lbl: Label 'أحد عشر';
        Text043Lbl: Label 'اثني عشر';
        Text044Lbl: Label 'ثلاثة عشر';
        Text045Lbl: Label 'أربعة عشرة';
        Text046Lbl: Label 'خمسة عشر';
        Text047Lbl: Label 'السادس عشر';
        Text048Lbl: Label 'سبعة عشر';
        Text049Lbl: Label 'الثامنة عشر';
        Text050Lbl: Label 'تسعة عشر';
        Text051Lbl: Label 'عشرين';
        Text052Lbl: Label 'ثلاثون';
        Text053Lbl: Label 'أربعين';
        Text054Lbl: Label 'خمسون';
        Text055Lbl: Label 'ستون';
        Text056Lbl: Label 'سبعون';
        Text057Lbl: Label 'ثمانون';
        Text058Lbl: Label 'تسعين';
        Text059Lbl: Label 'ألف';
        Text060Lbl: Label 'مليون';
        Text061Lbl: Label 'مليار';
        OnesText: array[20] of Text[30];



        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
}