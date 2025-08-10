tableextension 70505 "Posted Sale Credit Memo_DSSS" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(70500; "E-Invoice Cleared By ZATCA"; Boolean)
        {
            Caption = 'Cleared By ZATCA';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70501; "E-Invoice ZATCA Clearance Status"; Text[35])
        {
            Caption = 'ZATCA Clearance Status';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(70502; "E-Invoice ZATCA Invoice Response"; Blob)
        {
            //Caption = 'ZATCA Invoice Response';
            DataClassification = CustomerContent;
        }
        field(70503; "E-Invoice Pih Hash"; Text[250])
        {
            Caption = 'Pih Hash';
            DataClassification = CustomerContent;
        }
        field(70504; "E-Invoice ZATCA QR Code"; Text[2024])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    procedure SetZATCADescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."E-Invoice ZATCA Invoice Response");
        Rec."E-Invoice ZATCA Invoice Response".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Rec.Modify();
    end;

    procedure GetZATCADescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Rec."E-Invoice ZATCA Invoice Response");
        Rec."E-Invoice ZATCA Invoice Response".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice ZATCA Invoice Response")));
    end;

    var
        myInt: Integer;
}