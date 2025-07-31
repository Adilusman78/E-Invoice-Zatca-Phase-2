table 70502 "E-Invoicing Zatca Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(70501; "E-Invoice Storage Account Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70502; "E-Invoice Contaier Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70503; "E-Invoice Storage Account Access Key"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70504; "E-Invoice HTTP Triger func. URL"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70505; "E-Invoice ZATCA-Core URL"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70506; "E-Invoice ZATCA-Simulation URL"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70507; "E-Invoice ZATCA-File Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70508; "E-Invoice ZATCA-Env. Simulation"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70509; "E-Invoice ZATCA-Env. Production"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70510; "E-Invoice Simulation Production CSID"; Blob)
        {
            DataClassification = ToBeClassified;

        }
        field(70511; "E-Invoice Core Production CSID"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70512; "E-Invoice Simulation Production Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70513; "E-Invoice Core Production Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70514; "E-Invoice Simulation Compliance CSID"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70515; "E-Invoice Core Compliance CSID"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70516; "E-Invoice Simulation Compliance Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70517; "E-Invoice Core Compliance Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70518; "E-Invoice Simulation Private Key"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70519; "E-Invoice Core Private Key"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70520; "E-Invoice Simulation Certificate"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70521; "E-Invoice Core Certificate"; Blob)
        {
            DataClassification = ToBeClassified;
        }


        field(70522; "E-Invoice Organization"; Code[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Company Information".Name;
        }
        field(70523; "E-Invoice LegalEntity"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(70524; "E-Invoice PI Hash"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Previous Invoice Hash';
        }

    }

    keys
    {
        key(Key1; "E-Invoice Storage Account Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
        Var_FieldIDs: Option "70510","70511","70512","70513","70514","70515","70516","70517","70518","70519","70520","70521";

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;



    procedure SetCoreCertificateDescription1(NewBlobDescription: Text; FieldId: Integer)
    var
        OutStream: OutStream;
    begin
        // Message('');
        case FieldId of
            70510:
                begin
                    Clear("E-Invoice Simulation Production CSID");
                    "E-Invoice Simulation Production CSID".CreateOutStream(OutStream, TextEncoding::UTF8);
                end;
            70511:
                begin
                    Clear("E-Invoice Core Production CSID");
                    "E-Invoice Core Production CSID".CreateOutStream(OutStream, TextEncoding::UTF8);
                end;
            70512:
                begin
                    Clear("E-Invoice Simulation Production Secret");
                    "E-Invoice Simulation Production Secret".CreateOutStream(OutStream, TextEncoding::UTF8);
                end;
            70513:
                begin
                    Clear("E-Invoice Core Production Secret");
                    "E-Invoice Core Production Secret".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70514:
                begin
                    Clear("E-Invoice Simulation Compliance CSID");
                    "E-Invoice Simulation Compliance CSID".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70515:
                begin
                    Clear("E-Invoice Core Compliance CSID");
                    "E-Invoice Core Compliance CSID".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70516:
                begin
                    Clear("E-Invoice Simulation Compliance Secret");
                    "E-Invoice Simulation Compliance Secret".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70517:
                begin
                    Clear("E-Invoice Core Compliance Secret");
                    "E-Invoice Core Compliance Secret".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70518:
                begin
                    Clear("E-Invoice Simulation Private Key");
                    "E-Invoice Simulation Private Key".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70519:
                begin
                    Clear("E-Invoice Core Private Key");
                    "E-Invoice Core Private Key".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70520:
                begin
                    Clear("E-Invoice Simulation Certificate");
                    "E-Invoice Simulation Certificate".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70521:
                begin
                    Clear("E-Invoice Core Certificate");
                    "E-Invoice Core Certificate".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
        end;
        OutStream.WriteText(NewBlobDescription);
        Modify();
    end;

    procedure GetCoreCertificateDescription1(FieldId: Integer) Description: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        // Message('get');
        case FieldId of
            70510:
                begin
                    CalcFields(Rec."E-Invoice Simulation Production CSID");
                    Rec."E-invoice Simulation Production CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName(Rec."E-Invoice Simulation Production CSID")));
                end;
            70511:
                begin
                    CalcFields("E-Invoice Core Production CSID");
                    "E-Invoice Core Production CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70512:
                begin
                    CalcFields("E-Invoice Simulation Production Secret");
                    "E-Invoice Simulation Production Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70513:
                begin
                    CalcFields("E-Invoice Core Production Secret");
                    "E-Invoice Core Production Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70514:
                begin
                    CalcFields("E-Invoice Simulation Compliance CSID");
                    "E-Invoice Simulation Compliance CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70515:
                begin
                    CalcFields("E-Invoice Core Compliance CSID");
                    "E-Invoice Core Compliance CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70516:
                begin
                    CalcFields("E-Invoice Simulation Compliance Secret");
                    "E-Invoice Simulation Compliance Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70517:
                begin
                    CalcFields("E-Invoice Core Compliance Secret");
                    "E-Invoice Core Compliance Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70518:
                begin
                    CalcFields("E-Invoice Simulation Private Key");
                    "E-Invoice Simulation Private Key".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70519:
                begin
                    CalcFields("E-Invoice Core Private Key");
                    "E-Invoice Core Private Key".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
            70520:
                begin
                    CalcFields("E-Invoice Simulation Certificate");
                    "E-Invoice Simulation Certificate".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Simulation Certificate")));
                end;
            70521:
                begin
                    CalcFields("E-Invoice Core Certificate");
                    "E-Invoice Core Certificate".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("E-Invoice Core Certificate")));
                end;
        end;

    end;

}