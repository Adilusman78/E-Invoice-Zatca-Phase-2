page 70501 "E-Invoicing Zatca Setup Info."
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "E-Invoicing Zatca Setup";
    // DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("Azure Information")
            {
                field(LegalEntity; Rec.LegalEntity)
                {
                    ApplicationArea = All;
                }
                field(Organization; Rec.Organization)
                {
                    ApplicationArea = All;
                }
                field("Storage Account Name"; Rec."Storage Account Name")
                {
                    ApplicationArea = All;

                }
                field("Access Key"; Rec."Storage Account Access Key")
                {
                    ApplicationArea = All;
                }
                field("Contaier Name"; Rec."Contaier Name")
                {
                    ApplicationArea = All;
                }

            }
            group("HTTP Function Info")
            {

                field("HTTP Triger func. URL"; Rec."HTTP Triger func. URL")
                {
                    ApplicationArea = All;
                    Caption = 'Http Trigger URL';//we will use defult function key

                }
            }
            group("Payload Setup")
            {
                field("Simulation Production CSID"; Simulation_Production_CSID)
                {
                    ApplicationArea = All;
                    Editable = true;
                    trigger OnValidate()
                    begin
                        rec.SetCoreCertificateDescription1(Simulation_Production_CSID, Rec.FieldNo("Simulation Production CSID"));
                    end;
                }
                field("Core Production CSID"; Core_Production_CSID)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.SetCoreCertificateDescription1(Core_Production_CSID, Rec.FieldNo("Core Production CSID"));

                    end;
                }

                field("Simulation Production Secret"; Simulation_Production_Secret)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.SetCoreCertificateDescription1(Simulation_Production_Secret, Rec.FieldNo("Simulation Production Secret"));
                    end;
                }
                field("Core Production Secret"; Core_Production_Secret)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        rec.SetCoreCertificateDescription1(Core_Production_Secret, Rec.FieldNo("Core Production Secret"));

                    end;
                }
                group(Compliance)
                {
                    field("Simulation Compliance CSID"; Simulation_Compliance_CSID)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Compliance_CSID, Rec.FieldNo("Simulation Compliance CSID"));

                        end;
                    }
                    field("Core Compliance CSID"; Core_Compliance_CSID)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()

                        begin
                            rec.SetCoreCertificateDescription1(Core_Compliance_CSID, Rec.FieldNo("Core Compliance CSID"));

                        end;
                    }
                    field("Simulation Compliance Secret"; Simulation_Compliance_Secret)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Compliance_Secret, Rec.FieldNo("Simulation Compliance Secret"));

                        end;
                    }
                    field("Core Compliance Secret"; Core_Compliance_Secret)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Core_Compliance_Secret, Rec.FieldNo("Core Compliance Secret"));

                        end;
                    }
                    field("Simulation Private Key"; Simulation_Private_Key)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Private_Key, Rec.FieldNo("Simulation Private Key"));

                        end;
                    }
                    field("Core Private Key"; Core_Private_Key)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Core_Private_Key, Rec.FieldNo("Core Private Key"));

                        end;
                    }
                    field("Simulation Certificate"; Simulation_Certificate)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Certificate, Rec.FieldNo("Simulation Certificate"));

                        end;
                    }
                    field("Core Certificate"; Core_Certificate)
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Core_Certificate, Rec.FieldNo("Core Certificate"));
                        end;
                    }

                }
            }
            group("Environment")
            {
                field("ZATCA-Env. Sandbox"; Rec."ZATCA-Env. Simulation")
                {
                    ApplicationArea = All;
                }

                field("ZATCA-Env. Production"; Rec."ZATCA-Env. Production")
                {
                    ApplicationArea = All;
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        ClearAll();
        GetBlobValue();
    end;

    var
        acc: Page "Acc. Schedule Overview";
        ZATCAhTTPTxt: Text;
        Simulation_Production_CSID: Text;
        ZATCAEnvProductionTxt: Text;
        ZATCACoreTxt: Text;
        ZATCASimulationTxt: Text;
        Core_Production_CSID: Text;
        ZATCAComplianceSecretTxt: Text;
        Simulation_Compliance_Secret: Text;
        Core_Compliance_CSID: Text;
        Simulation_Production_Secret: Text;
        Simulation_Compliance_CSID: Text;
        Core_Production_Secret: Text;
        Core_Certificate: Text;
        Simulation_Certificate: Text;
        Core_Private_Key: Text;
        Simulation_Private_Key: Text;
        ZATCAEnvTxt: Text;
        Core_Compliance_Secret: Text;
        accrec: Record "Acc. Schedule Line";

    procedure GetBlobValue()
    var
        myInt: Integer;
    begin
        Simulation_Production_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Simulation Production CSID"));
        Core_Compliance_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Core Compliance Secret"));
        Core_Compliance_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Core Certificate"));
        Core_Production_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Core Production CSID"));
        Simulation_Compliance_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Simulation Compliance CSID"));
        Simulation_Production_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Simulation Production Secret"));
        Core_Production_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Core Production Secret"));
        Core_Certificate := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Core Certificate"));
        Simulation_Private_Key := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Simulation Private Key"));
        // ZATCAEnvTxt := Rec.GetZATCAEnvDescription();
        Simulation_Certificate := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Simulation Certificate"));
        Core_Private_Key := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Core Private Key"));
        Simulation_Compliance_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("Simulation Compliance Secret"));
    end;
}