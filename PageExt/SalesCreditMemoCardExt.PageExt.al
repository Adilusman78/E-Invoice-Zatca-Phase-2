pageextension 70508 SalesCreditMemoCardExt extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("E-Invoice Cleared By ZATCA"; Rec."E-Invoice Cleared By ZATCA")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Credit Memo")
        {
            // action("Export Order XML")
            // {
            //     Caption = 'Export Order XML';
            //     ApplicationArea = all;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Process;
            //     ToolTip = 'Export Order XML';
            //     Visible = false;
            //     Image = Export;
            //     trigger OnAction()
            //     var
            //         TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
            //         CreateXML: Codeunit CreateXMLOfSalesOrder;
            //     begin
            //         CreateXML.CreateXmlDemoOfSalesOrder(Rec);
            //     end;
            // }
            // action("Updated Posting No_DSSS")
            // {
            //     Caption = 'Updated Posting No';
            //     ApplicationArea = all;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     Visible = Zatcavisibility;
            //     PromotedCategory = Process;
            //     ToolTip = 'Updated Posting No';
            //     Image = Refresh;
            //     trigger OnAction()
            //     var
            //         NoseriesManagement: Codeunit NoSeriesManagementi;
            //         LastNoUsed: Code[20];
            //         LastNoUsed2: Code[20];
            //         NoSeriesLine: Record "No. Series Line";
            //         NewNumber: Code[20];
            //         NewNumber2: Code[20];
            //         NewNumber3: Code[20];
            //         CurrentDocNumber: Code[20];
            //         NonDigitValue1: Code[20];
            //         NonDigitValu2: Code[20];
            //     begin
            //         Clear(LastNoUsed);
            //         Clear(LastNoUsed2);
            //         Clear(NewNumber);
            //         Clear(NewNumber2);
            //         Clear(NewNumber3);
            //         Clear(NonDigitValue1);
            //         Clear(NonDigitValu2);
            //         NoSeriesLine.Reset();
            //         NoSeriesLine.SetCurrentKey("Series Code", "Starting Date");
            //         NoSeriesLine.SetRange("Series Code", Rec."Posting No. Series");
            //         NoSeriesLine.SetRange("Starting Date", 0D, Rec."Posting Date");
            //         if NoSeriesLine.FindLast() then begin
            //             if NoSeriesLine."Last No. Used" = '' then begin
            //                 LastNoUsed2 := NoSeriesLine."Starting No.";
            //             end
            //             else
            //                 LastNoUsed2 := NoSeriesLine."Last No. Used";
            //             if NoSeriesLine."Last No. Used" <> '' then begin
            //                 Rec.IncrementNoText(LastNoUsed2, NoSeriesLine."Increment-by No.", NewNumber3, NonDigitValue1);
            //                 //Message(Txt01, Rec."Document No.", LastNoUsed2);
            //             end;
            //             if Rec."Posting No." <> '' then
            //                 exit;
            //             Rec."Posting No." := LastNoUsed2;
            //             Message('Posting No Generated');
            //             CurrPage.Update();
            //             NoSeriesLine.Reset();
            //             NoSeriesLine.SetCurrentKey("Series Code", "Starting Date");
            //             NoSeriesLine.SetRange("Series Code", Rec."Posting No. Series");
            //             NoSeriesLine.SetRange("Starting Date", 0D, Rec."Posting Date");
            //             if NoSeriesLine.FindLast() then begin
            //                 NoSeriesLine."Last No. Used" := LastNoUsed2;
            //                 NoSeriesLine.Modify();
            //             end;
            //             exit;
            //         end;
            //     end;
            // }
            action("E-Invoice Order Information")
            {
                Caption = 'E-Invoice Order Information';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'E-Invoice Order Information';
                Image = Info;
                RunObject = page "Zatca Sales Credit Memo Info";
                RunPageLink = "Document Type" = field("Document Type"), "No." = field("No.");
            }
            action("Send XML - ZATCA")
            {
                Caption = 'E-Invoice Send - ZATCA';
                ApplicationArea = all;
                //Visible=false;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Zatcavisibility;
                ToolTip = 'Send XML - ZATCA';
                Image = Export;
                trigger OnAction()
                var
                    TaxInvXmlPort: XmlPort "Tax Invoice Final XML DSSS";
                    CreateXML: Codeunit CreateXMLOfSalesOrder;
                    UUID: Text;
                    UUIDPos: Integer;
                begin
                    if Rec."Posting No." = '' then begin
                        Error('Updated Posting No');
                    end
                    else
                        // if Rec."ZATCA Clearance Status_DSSS" = 'CLEARED' then
                        //     exit
                        //else
                        if Confirm('Do you want to send Invoice XML to ZATCA for clearance?', false) then begin
                            CreateXML.CreateXmlDemoOfSalesOrder(Rec);
                            ZATCAResponseTxt := Rec.GetZATCADescription();
                        end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        ZATCAResponseTxt := Rec.GetZATCADescription();
        if Companyinfo_gRec.Get() then
            if Companyinfo_gRec."E-Invoice Zatca Function" = true then begin
                Zatcavisibility := true;
            end
            else
                Zatcavisibility := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if Companyinfo_gRec.Get() then
            if Companyinfo_gRec."E-Invoice Zatca Function" = true then begin
                Zatcavisibility := true;
            end
            else
                Zatcavisibility := false;
    end;

    var
        ZATCAResponseTxt: Text;
        Companyinfo_gRec: Record "Company Information";
        Zatcavisibility: Boolean;

}