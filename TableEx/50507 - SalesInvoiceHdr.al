tableextension 70504 "Posted Sales Invoice_DSSS" extends "Sales Invoice Header"
{

    fields
    {
        field(50500; "Cleared By ZATCA_DSSS"; Boolean)
        {
            Caption = 'Cleared By ZATCA';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50501; "ZATCA Clearance Status_DSSS"; Text[35])
        {
            Caption = 'ZATCA Clearance Status';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50502; "ZATCA Invoice Response_DSSS"; Blob)
        {
            //Caption = 'ZATCA Invoice Response';
            DataClassification = CustomerContent;
        }
        field(50503; "Pih Hash_DSSS"; Text[250])
        {
            Caption = 'Pih Hash';
            DataClassification = ToBeClassified;

        }
        field(50504; "ZATCA QR Code"; Text[2024])
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(50505; "QR Code Media"; MediaSet)
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

        Clear(Rec."ZATCA Invoice Response_DSSS");
        Rec."ZATCA Invoice Response_DSSS".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        Rec."ZATCA QR Code" := ZatcaQRCode;
        OutStream.WriteText(NewWorkDescription);
        Rec."ZATCA QR Code" := ZATCAQRcode;
        Rec.Modify();
    end;

    procedure GetZATCADescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Rec."ZATCA Invoice Response_DSSS");
        Rec."ZATCA Invoice Response_DSSS".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("ZATCA Invoice Response_DSSS")));
    end;

    procedure GetZATCADescription2(SalesInvHeader: Record "Sales Invoice Entity Aggregate") WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields(Rec."ZATCA Invoice Response_DSSS");
        Rec."ZATCA Invoice Response_DSSS".CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("ZATCA Invoice Response_DSSS")));
    end;

    var
        myInt: Integer;

}