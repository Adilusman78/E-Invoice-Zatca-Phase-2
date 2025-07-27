pageextension 70507 "BusManagerRoleCenter_Dsss" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addlast(Sections)
        {
            group("E-Invoicing ZATCA")
            {
                action("E-Invoicing Zatca Setup")
                {
                    RunObject = page "E-Invoicing Zatca Setup Info.";
                    ApplicationArea = All;
                    ToolTip = 'Open the the page of E-Invoicing Zatca Setup';
                    Caption = 'E-Invoicing Zatca Setup';
                }
                action("Sales Order_dsss")
                {
                    RunObject = page "Sales Order List";
                    ApplicationArea = All;
                    ToolTip = 'Open the list of Sales Order.';
                    Caption = 'Sales Order';
                }
                action("Sales Invoices_1")
                {
                    RunObject = page "Sales Invoice List";
                    ApplicationArea = All;
                    ToolTip = 'Open the list of Sales Invoices';
                    Caption = 'Sales Invoices';
                }
                action("Posted Sales Inv")
                {
                    RunObject = page "Posted Sales Invoices";
                    ApplicationArea = All;
                    ToolTip = 'Open the list of Posted Sales Invoices';
                    Caption = 'Posted Sales Invoices';
                }
                action("Purchase Order List")
                {
                    RunObject = page "Purchase Order List";
                    ApplicationArea = All;
                    ToolTip = 'Open the list of Purchase Order List.';
                    Caption = 'Purchase Order';
                }
            }
        }
    }

    var
        myInt: Integer;
}