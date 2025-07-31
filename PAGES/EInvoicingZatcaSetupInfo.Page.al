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
                field("E-Invoice LegalEntity"; Rec."E-Invoice LegalEntity")
                {
                    ApplicationArea = All;
                }
                field("E-Invoice Organization"; Rec."E-Invoice Organization")
                {
                    ApplicationArea = All;
                }
                field("E-Invoice Storage Account Name"; Rec."E-Invoice Storage Account Name")
                {
                    ApplicationArea = All;

                }
                field("E-Invoice Access Key"; Rec."E-Invoice Storage Account Access Key")
                {
                    ApplicationArea = All;
                }
                field("E-Invoice Contaier Name"; Rec."E-Invoice Contaier Name")
                {
                    ApplicationArea = All;
                }

            }
            group("HTTP Function Info")
            {

                field("E-Invoice HTTP Triger func. URL"; Rec."E-Invoice HTTP Triger func. URL")
                {
                    ApplicationArea = All;
                    Caption = 'Http Trigger URL';//we will use defult function key

                }
            }
            group("Payload Setup")
            {
                field("E-Invoice Simulation Production CSID"; Rec."E-Invoice Simulation Production CSID")
                {
                    ApplicationArea = All;
                    Editable = true;
                    trigger OnValidate()
                    begin
                        rec.SetCoreCertificateDescription1(Simulation_Production_CSID, Rec.FieldNo("E-Invoice Simulation Production CSID"));
                    end;
                }
                field("E-Invoice Core Production CSID"; Rec."E-Invoice Core Production CSID")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.SetCoreCertificateDescription1(Core_Production_CSID, Rec.FieldNo("E-Invoice Core Production CSID"));

                    end;
                }

                field("E-Invoice Simulation Production Secret"; Rec."E-Invoice Simulation Production Secret")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.SetCoreCertificateDescription1(Simulation_Production_Secret, Rec.FieldNo("E-Invoice Simulation Production Secret"));
                    end;
                }
                field("E-Invoice Core Production Secret"; Rec."E-Invoice Core Production Secret")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        rec.SetCoreCertificateDescription1(Core_Production_Secret, Rec.FieldNo("E-Invoice Core Production Secret"));

                    end;
                }
                group(Compliance)
                {
                    field("E-Invoice Simulation Compliance CSID"; Rec."E-Invoice Simulation Compliance CSID")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Compliance_CSID, Rec.FieldNo("E-Invoice Simulation Compliance CSID"));

                        end;
                    }
                    field("E-Invoice Core Compliance CSID"; Rec."E-Invoice Core Compliance CSID")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()

                        begin
                            rec.SetCoreCertificateDescription1(Core_Compliance_CSID, Rec.FieldNo("E-Invoice Core Compliance CSID"));

                        end;
                    }
                    field("E-Invoice Simulation Compliance Secret"; Rec."E-Invoice Simulation Compliance Secret")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Compliance_Secret, Rec.FieldNo("E-Invoice Simulation Compliance Secret"));

                        end;
                    }
                    field("E-Invoice Core Compliance Secret"; Rec."E-Invoice Core Compliance Secret")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Core_Compliance_Secret, Rec.FieldNo("E-Invoice Core Compliance Secret"));

                        end;
                    }
                    field("E-Invoice Simulation Private Key"; Rec."E-Invoice Simulation Private Key")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Private_Key, Rec.FieldNo("E-Invoice Simulation Private Key"));

                        end;
                    }
                    field("E-Invoice Core Private Key"; Rec."E-Invoice Core Private Key")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Core_Private_Key, Rec.FieldNo("E-Invoice Core Private Key"));

                        end;
                    }
                    field("E-Invoice Simulation Certificate"; Rec."E-Invoice Simulation Certificate")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Simulation_Certificate, Rec.FieldNo("E-Invoice Simulation Certificate"));

                        end;
                    }
                    field("E-Invoice Core Certificate"; Rec."E-Invoice Core Certificate")
                    {
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            rec.SetCoreCertificateDescription1(Core_Certificate, Rec.FieldNo("E-Invoice Core Certificate"));
                        end;
                    }

                }
            }
            group("Environment")
            {
                field("E-Invoice ZATCA-Env. Sandbox"; Rec."E-Invoice ZATCA-Env. Simulation")
                {
                    ApplicationArea = All;
                }

                field("E-Invoice ZATCA-Env. Production"; Rec."E-Invoice ZATCA-Env. Production")
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
        Simulation_Production_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Simulation Production CSID"));
        Core_Compliance_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Core Compliance Secret"));
        Core_Compliance_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Core Certificate"));
        Core_Production_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Core Production CSID"));
        Simulation_Compliance_CSID := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Simulation Compliance CSID"));
        Simulation_Production_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Simulation Production Secret"));
        Core_Production_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Core Production Secret"));
        Core_Certificate := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Core Certificate"));
        Simulation_Private_Key := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Simulation Private Key"));
        // ZATCAEnvTxt := Rec.GetZATCAEnvDescription();
        Simulation_Certificate := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Simulation Certificate"));
        Core_Private_Key := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Core Private Key"));
        Simulation_Compliance_Secret := Rec.GetCoreCertificateDescription1(Rec.FieldNo("E-Invoice Simulation Compliance Secret"));
    end;
}