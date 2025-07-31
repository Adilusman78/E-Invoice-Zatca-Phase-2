tableextension 70504 "Posted Sales Invoice_DSSS" extends "Sales Invoice Header"
{

    fields
    {
        field(50500; "E-Invoice Cleared By ZATCA"; Boolean)
        {
            Caption = 'E-Invoice Cleared By ZATCA';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50501; "E-Invoice ZATCA Clearance Status"; Text[35])
        {
            Caption = 'E-Invoice ZATCA Clearance Status';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50502; "E-Invoice ZATCA Invoice Response"; Blob)
        {
            //Caption = 'E-Invoice ZATCA Invoice Response';
            DataClassification = CustomerContent;
        }
        field(50503; "E-Invoice Pih Hash"; Text[250])
        {
            Caption = 'E-Invoice Pih Hash';
            DataClassification = ToBeClassified;

        }
        field(50504; "E-Invoice ZATCA QR Code"; Text[2024])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(50505; "E-Invoice QR Code Media"; MediaSet)
        {
            DataClassification = ToBeClassified;
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
    procedure SetZATCADescription(NewWorkDescription: Text; ZatcaQRCode: text)

    var
        OutStream: OutStream;

    begin

        Clear(Rec."E-Invoice ZATCA Invoice Response");
        Rec."E-Invoice ZATCA Invoice Response".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        Rec."E-Invoice ZATCA QR Code" := ZatcaQRCode;
        OutStream.WriteText(NewWorkDescription);
        Rec."E-Invoice ZATCA QR Code" := ZATCAQRcode;
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

    procedure GetZATCADescription2(SalesInvHeader: Record "Sales Invoice Entity Aggregate") WorkDescription: Text
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