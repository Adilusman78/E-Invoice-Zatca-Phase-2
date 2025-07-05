
codeunit 70501 Base64ConrtDSSS
{
    procedure TextToBase64String(Value: Text) ReturnValue: Text;
    var
        BinaryValue: text;
        Length: Integer;
    begin
        // Divide value into blocks of 3 bytes
        Length := StrLen(Value);
        BinaryValue := TextToBinary(Value, 8);
        ReturnValue := ConvertBinaryValueToBase64String(BinaryValue, Length);
    end;

    procedure StreamToBase64String(InStreamv: InStream) ReturnValue: Text;
    var
        SingleByte: Byte;
        Length: Integer;
        BinaryValue: Text;
    begin
        while not InStreamv.EOS do begin
            InStreamv.Read(SingleByte, 1);
            Length += 1;
            BinaryValue += ByteToBinary(SingleByte, 8);
        end;

        ReturnValue := ConvertBinaryValueToBase64String(BinaryValue, Length);
    end;

    procedure FromBase64StringToText(Value: Text) ReturnValue: Text;
    var
        BinaryValue: Text;
    begin
        BinaryValue := ConvertBase64StringToBinaryValue(Value);
        ReturnValue := BinaryToText(BinaryValue);
    end;

    procedure FromBase64StringToStream(Value: Text; var OutStreamre: OutStream);
    var
        BinaryValue: Text;
    begin
        BinaryValue := ConvertBase64StringToBinaryValue(Value);
        BinaryToStream(BinaryValue, OutStreamre);
    end;

    procedure ConvertBinaryValueToBase64String(Value: Text; Length: Integer) ReturnValue: Text;
    var
        Length2: Integer;
        PaddingCount: Integer;
        //BlockCount: Integer;
        Pos: Integer;
        CurrentByte: text;
        i: Integer;
    begin
        if Length MOD 3 = 0 then
            PaddingCount := 0
        // BlockCount := Length / 3;
        else
            PaddingCount := 3 - (Length MOD 3);
        //BlockCount := (Length + PaddingCount) / 3;


        Length2 := Length + PaddingCount;
        Value := PadStr(Value, Length2 * 8, '0');

        // Loop through bytes in groups of 6 bits
        Pos := 1;
        while Pos < Length2 * 8 do begin
            CurrentByte := CopyStr(Value, Pos, 6);
            ReturnValue += GetBase64Char(BinaryToInt(CurrentByte));
            pos += 6;
        end;

        // Replace last characters with '='
        for i := 1 to PaddingCount do begin
            Pos := StrLen(ReturnValue) - i + 1;
            ReturnValue[Pos] := '=';
        end;

    end;

    procedure ConvertBase64StringToBinaryValue(Value: Text) ReturnValue: Text;
    var
        BinaryValue: Text;
        i: Integer;
        IntValue: Integer;
        PaddingCount: Integer;
    begin
        for i := 1 to StrLen(Value) do begin
            if Value[i] = '=' then
                PaddingCount += 1;

            IntValue := GetBase64Number(Value[i]);
            BinaryValue += IncreaseStringLength(IntToBinary(IntValue), 6);
        end;

        for i := 1 to PaddingCount do
            BinaryValue := CopyStr(BinaryValue, 1, StrLen(BinaryValue) - 8);

        ReturnValue := BinaryValue;
    end;

    procedure TextToBinary(Value: text; ByteLength: Integer) ReturnValue: text;
    var
        IntValue: Integer;
        i: Integer;
        BinaryValue: text;
    begin
        for i := 1 to StrLen(value) do begin
            IntValue := value[i];
            BinaryValue := IntToBinary(IntValue);
            BinaryValue := IncreaseStringLength(BinaryValue, ByteLength);
            ReturnValue += BinaryValue;
        end;
    end;

    procedure BinaryToText(Value: Text) ReturnValue: Text;
    var
        Buffer: BigText;
        Pos: Integer;
        SingleByte: Text;
        CharValue: Text;
    begin
        Buffer.AddText(Value);

        Pos := 1;
        while Pos < Buffer.Length do begin
            Buffer.GetSubText(SingleByte, Pos, 8);
            CharValue[1] := BinaryToInt(SingleByte);
            ReturnValue += CharValue;
            Pos += 8;
        end;
    end;

    procedure BinaryToStream(Value: Text; var OutStreamre: OutStream);
    var
        Buffer: BigText;
        Pos: Integer;
        SingleByte: Text;
        ByteValue: Byte;
    begin
        Buffer.AddText(Value);

        Pos := 1;
        while Pos < Buffer.Length do begin
            Buffer.GetSubText(SingleByte, Pos, 8);
            ByteValue := BinaryToInt(SingleByte);
            OutStreamre.Write(ByteValue, 1);
            Pos += 8;
        end;
    end;

    procedure ByteToBinary(Value: Byte; ByteLenght: Integer) ReturnValue: Text;
    var
        BinaryValue: Text;
    begin
        BinaryValue := IntToBinary(Value);
        BinaryValue := IncreaseStringLength(BinaryValue, ByteLenght);
        ReturnValue := BinaryValue;
    end;

    procedure IntToBinary(Value: integer) ReturnValue: text;
    begin
        while Value >= 1 do begin
            ReturnValue := Format(Value MOD 2) + ReturnValue;
            Value := Value DIV 2;
        end;
    end;

    procedure BinaryToInt(Value: Text) ReturnValue: Integer;
    var
        Multiplier: BigInteger;
        IntValue: Integer;
        i: Integer;
    begin
        Multiplier := 1;
        for i := StrLen(Value) downto 1 do begin
            Evaluate(IntValue, CopyStr(Value, i, 1));
            ReturnValue += IntValue * Multiplier;
            Multiplier *= 2;
        end;
    end;

    procedure IncreaseStringLength(Value: Text; ToLength: Integer) ReturnValue: Text;
    var
        ExtraLength: Integer;
        ExtraText: Text;
    begin
        ExtraLength := ToLength - StrLen(Value);

        if ExtraLength < 0 then
            exit;

        ExtraText := PadStr(ExtraText, ExtraLength, '0');
        ReturnValue := ExtraText + Value;
    end;

    procedure GetBase64Char(Value: Integer): text;
    var
        chars: text;

    begin
        chars := Base64Chars();
        exit(chars[Value + 1]);
    end;

    procedure GetBase64Number(Value: text): Integer;
    var
        chars: text;
    begin
        if Value = '=' then
            exit(0);

        chars := Base64Chars();
        exit(StrPos(chars, Value) - 1);
    end;

    procedure Base64Chars(): text;
    begin
        exit('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/');
    end;

    procedure MyProcedure(hexStr: Text)
    var
        intVal: Integer;
    begin
        hexStr := '010C'; // int value = 2607
        intVal := HexToInt(hexStr);
        Message(hexStr + ' = ' + format(intVal));
    end;


    procedure HexToInt(hexStr: Text): Integer
    var
        len, base, decVal, i, j : integer;
    begin
        base := 1;
        decVal := 0;
        len := strlen(hexStr);

        for i := 0 to len - 1 do begin
            j := len - i;
            if (hexStr[j] >= '0') and (hexStr[j] <= '9') then begin
                decVal += (hexStr[j] - 48) * base;
                base := base * 16;
            end else
                if (hexStr[j] >= 'A') and (hexStr[j] <= 'F') then begin
                    decVal += (hexStr[j] - 55) * base;
                    base := base * 16;
                end;
        end;

        exit(decVal);
    end;
}