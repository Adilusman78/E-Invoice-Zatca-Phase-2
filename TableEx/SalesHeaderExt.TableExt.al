tableextension 70506 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(70500; "E-Invoice Cleared By ZATCA"; Boolean)
        {
            Caption = 'E-Invoice Cleared By ZATCA';
            DataClassification = CustomerContent;
        }
        field(70501; "E-Invoice Clearance Status"; Text[35])
        {
            Caption = 'E-Invoice ZATCA Clearance Status';
            DataClassification = CustomerContent;
        }

        field(70502; "E-Invoice ZATCA Response"; Blob)
        {
            Caption = 'E-Invoice ZATCA Response';
            DataClassification = CustomerContent;
        }
        field(70503; "E-Invoice ZATCA Pih Hash"; Text[250])
        {
            Caption = 'E-Invoice ZATCA Pih Hash';
            DataClassification = CustomerContent;

        }
        field(70504; "E-Invoice ZATCA QR Code"; Text[2024])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    var

    procedure SetZATCADescription(NewWorkDescription: Text; ZATCAQRcode: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."E-Invoice ZATCA Response");
        Rec."E-Invoice ZATCA Response".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Rec."E-Invoice ZATCA QR Code" := ZATCAQRcode;
        Rec.Modify();
    end;

    procedure GetZATCADescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Rec."E-Invoice ZATCA Response");
        Rec."E-Invoice ZATCA Response".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice ZATCA Response")));
    end;

    procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal; var NewNumber: Code[20]; NonDigitValue: Code[20])
    var
        BigIntNo: BigInteger;
        BigIntIncByNo: BigInteger;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
        NonDigitVal: Code[20];
    begin
        GetIntegerPos(No, StartPos, EndPos);
        Evaluate(BigIntNo, CopyStr(No, StartPos, EndPos - StartPos + 1));
        BigIntIncByNo := IncrementByNo;
        NewNo := Format(BigIntNo + BigIntIncByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos, NonDigitVal);
        NewNumber := NewNo;
        NonDigitValue := NonDigitVal;
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        if No <> '' then begin
            i := StrLen(No);
            repeat
                IsDigit := No[i] in ['0' .. '9'];
                if IsDigit then begin
                    if EndPos = 0 then
                        EndPos := i;
                    StartPos := i;
                end;
                i := i - 1;
            until (i = 0) or (StartPos <> 0) and not IsDigit;
        end;
    end;


    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer; NonDigitValue: Code[20])
    var
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        if StartPos > 1 then
            StartNo := CopyStr(No, 1, StartPos - 1);
        if EndPos < StrLen(No) then
            EndNo := CopyStr(No, EndPos + 1);
        NewLength := StrLen(NewNo);
        OldLength := EndPos - StartPos + 1;
        if FixedLength > OldLength then
            OldLength := FixedLength;
        if OldLength > NewLength then
            ZeroNo := PadStr('', OldLength - NewLength, '0');
        if StrLen(StartNo) + StrLen(ZeroNo) + StrLen(NewNo) + StrLen(EndNo) > 20 then
            Error(
              Text010,
              No);
        No := StartNo + ZeroNo + NewNo + EndNo;
        NonDigitValue := StartNo;
    end;

    var
        Text010: Label 'The number %1 cannot be extended to more than 20 characters.';
}