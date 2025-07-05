codeunit 70505 "XML XMLReader"
{

    procedure GetEmbeddedDocumentBinaryObjectValue(ZatcaxmlString: Text): Text
    var
        startTag: Text;
        endTag: Text;
        startPos: Integer;
        endPos: Integer;
        endPos2: Integer;
        endPos3: Integer;
        tagValue: Text;
        _Counter: Integer;
        ZatcaxmlString2: Text;
        ZatcaxmlString3: Text;
        QRtagPosition: Integer;
    begin
        startTag := '<cbc:EmbeddedDocumentBinaryObject mimeCode="text/plain">';
        endTag := '</cbc:EmbeddedDocumentBinaryObject>';
        repeat
            _Counter += 01;
            case _Counter of
                1:
                    begin
                        startPos := StrPos(ZatcaxmlString, '<cbc:EmbeddedDocumentBinaryObject mimeCode="text/plain">');
                        ZatcaxmlString := ReplaceCharacterInText(ZatcaxmlString, startPos, '1');

                        endPos := StrPos(ZatcaxmlString, '</cbc:EmbeddedDocumentBinaryObject>');
                        ZatcaxmlString := ReplaceCharacterInText(ZatcaxmlString, endPos, '1');

                        // endPos := StrPos(ZatcaxmlString, '</cbc:EmbeddedDocumentBinaryObject>');
                        // ZatcaxmlString := ReplaceCharacterInText(ZatcaxmlString, endPos, '1');

                    end;
                2:
                    begin
                        QRtagPosition := StrPos(ZatcaxmlString, '<cbc:EmbeddedDocumentBinaryObject mimeCode="text/plain">');
                        endPos2 := StrPos(ZatcaxmlString, '</cbc:EmbeddedDocumentBinaryObject>');
                    end;
            end;
        until _Counter = 2;

        if QRtagPosition > 0 then begin

            QRtagPosition := QRtagPosition + StrLen(startTag);
            //   endPos := StrPos(ZatcaxmlString2, endTag);
            if endPos2 > QRtagPosition then
                tagValue := CopyStr(ZatcaxmlString, QRtagPosition, endPos2 - QRtagPosition);
        end;
        exit(tagValue);
    end;

    procedure ReplaceCharacterInText(var inputText: Text; position: Integer; newChar: Text): Text
    var
        resultText: Text;
    begin
        if (position > 0) and (position <= STRLEN(inputText)) then begin
            resultText := COPYSTR(inputText, 1, position - 1) + FORMAT(newChar) + COPYSTR(inputText, position + 1);
            inputText := resultText;
            exit(inputText)
        end else
            Error('Position is out of range.');
    end;
}