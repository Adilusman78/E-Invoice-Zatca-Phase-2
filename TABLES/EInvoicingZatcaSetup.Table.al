table 70502 "E-Invoicing Zatca Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(70501; "Storage Account Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70502; "Contaier Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70503; "Storage Account Access Key"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70504; "HTTP Triger func. URL"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70505; "ZATCA-Core URL"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70506; "ZATCA-Simulation URL"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70507; "ZATCA-File Name"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70508; "ZATCA-Env. Simulation"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70509; "ZATCA-Env. Production"; Text[2024])
        {
            DataClassification = ToBeClassified;
        }
        field(70510; "Simulation Production CSID"; Blob)
        {
            DataClassification = ToBeClassified;

        }
        field(70511; "Core Production CSID"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70512; "Simulation Production Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70513; "Core Production Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70514; "Simulation Compliance CSID"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70515; "Core Compliance CSID"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70516; "Simulation Compliance Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70517; "Core Compliance Secret"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70518; "Simulation Private Key"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70519; "Core Private Key"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70520; "Simulation Certificate"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(70521; "Core Certificate"; Blob)
        {
            DataClassification = ToBeClassified;
        }


        field(70522; "Organization"; Code[100])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = "Company Information".Name;
        }
        field(70523; "LegalEntity"; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(70524; "PI Hash"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Previous Invoice Hash';
        }

    }

    keys
    {
        key(Key1; "Storage Account Name")
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
                    Clear("Simulation Production CSID");
                    "Simulation Production CSID".CreateOutStream(OutStream, TextEncoding::UTF8);
                end;
            70511:
                begin
                    Clear("Core Production CSID");
                    "Core Production CSID".CreateOutStream(OutStream, TextEncoding::UTF8);
                end;
            70512:
                begin
                    Clear("Simulation Production Secret");
                    "Simulation Production Secret".CreateOutStream(OutStream, TextEncoding::UTF8);
                end;
            70513:
                begin
                    Clear("Core Production Secret");
                    "Core Production Secret".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70514:
                begin
                    Clear("Simulation Compliance CSID");
                    "Simulation Compliance CSID".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70515:
                begin
                    Clear("Core Compliance CSID");
                    "Core Compliance CSID".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70516:
                begin
                    Clear("Simulation Compliance Secret");
                    "Simulation Compliance Secret".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70517:
                begin
                    Clear("Core Compliance Secret");
                    "Core Compliance Secret".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70518:
                begin
                    Clear("Simulation Private Key");
                    "Simulation Private Key".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70519:
                begin
                    Clear("Core Private Key");
                    "Core Private Key".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70520:
                begin
                    Clear("Simulation Certificate");
                    "Simulation Certificate".CreateOutStream(OutStream, TEXTENCODING::UTF8);
                end;
            70521:
                begin
                    Clear("Core Certificate");
                    "Core Certificate".CreateOutStream(OutStream, TEXTENCODING::UTF8);
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
                    CalcFields(Rec."Simulation Production CSID");
                    Rec."Simulation Production CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName(Rec."Simulation Production CSID")));
                end;
            70511:
                begin
                    CalcFields("Core Production CSID");
                    "Core Production CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70512:
                begin
                    CalcFields("Simulation Production Secret");
                    "Simulation Production Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70513:
                begin
                    CalcFields("Core Production Secret");
                    "Core Production Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70514:
                begin
                    CalcFields("Simulation Compliance CSID");
                    "Simulation Compliance CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70515:
                begin
                    CalcFields("Core Compliance CSID");
                    "Core Compliance CSID".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70516:
                begin
                    CalcFields("Simulation Compliance Secret");
                    "Simulation Compliance Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70517:
                begin
                    CalcFields("Core Compliance Secret");
                    "Core Compliance Secret".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70518:
                begin
                    CalcFields("Simulation Private Key");
                    "Simulation Private Key".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70519:
                begin
                    CalcFields("Core Private Key");
                    "Core Private Key".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
            70520:
                begin
                    CalcFields("Simulation Certificate");
                    "Simulation Certificate".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Simulation Certificate")));
                end;
            70521:
                begin
                    CalcFields("Core Certificate");
                    "Core Certificate".CreateInStream(InStream, TEXTENCODING::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Core Certificate")));
                end;
        end;

    end;

}