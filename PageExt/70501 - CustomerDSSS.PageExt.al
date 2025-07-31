pageextension 70501 "Customer DSSS" extends "Customer Card"
{
    layout
    {
        addafter("Address 2")
        {
            field("E-Invoice Building No"; rec."E-Invoice Building No")
            {
                ApplicationArea = all;
                ToolTip = 'Building';

            }
            field("E-Invoice District"; rec."E-Invoice District")
            {
                ApplicationArea = all;
                ToolTip = 'District';

            }
            field("E-Invoice Street Name"; rec."E-Invoice Street Name")
            {
                ApplicationArea = all;
                ToolTip = 'Street Name';

            }
            field("E-Invoice Additional No"; rec."E-Invoice Additional No")
            {
                ApplicationArea = all;
                ToolTip = 'Additional No';

            }
            field("E-Invoice Other Buyer ID"; rec."E-Invoice Other Buyer ID")
            {
                ApplicationArea = all;
                ToolTip = 'Other Seller ID';

            }
            field("E-Invoice Additional_Street_Name"; rec."E-Invoice Additional_Street_Name")
            {
                ApplicationArea = all;
                ToolTip = 'Additional_Street_Name';

            }
            field("E-InvoicePlot_Identification"; rec."E-InvoicePlot_Identification")
            {
                ApplicationArea = all;
                ToolTip = 'Plot_Identification';

            }
            field("E-Invoice Customer_ID"; rec."E-Invoice Customer_ID")
            {
                ApplicationArea = all;
                ToolTip = 'Company_ID';

            }
            field("E-Invoice Registration_Name"; rec."E-Invoice Registration_Name")
            {
                ApplicationArea = all;
                ToolTip = 'Registration_Name';

            }
            field("E-Invoice City_Subdivision_Name"; rec."E-Invoice City_Subdivision_Name")
            {
                ApplicationArea = all;
                ToolTip = 'City_Subdivision_Name';


            }
            field("E-Invoice NeighbourHood"; rec."E-Invoice NeighbourHood")
            {
                ApplicationArea = All;
                ToolTip = 'NeighbourHood';

            }
            field("E-Invoice Scheme_ID"; rec."E-Invoice Scheme_ID")
            {
                ApplicationArea = all;
                ToolTip = 'Scheme_ID';
            }
            field("E-Invoice Company Type"; rec."E-Invoice Company Type")
            {
                ApplicationArea = All;
                ToolTip = 'Company Type';


            }
        }
        addafter(General)
        {
            group("E-Invoice Arabic Information")
            {
                Caption = 'Arabic Information';
                field("E-Invoice Arabic Name"; rec."E-Invoice Arabic Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic Information';

                }
                field("E-Invoice Arabic Street Name"; rec."E-Invoice Arabic Street Name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic Street Name';

                }
                field("E-Invoice Add. Street_Name_Arabic"; Rec."E-Invoice Add. Street_Name_Arabic")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add. Street_Name_Arabic';

                }
                field("E-Invoice Arabic Building No"; rec."E-Invoice Arabic Building No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic Building No';

                }
                field("E-Invoice Arabic City"; rec."E-Invoice Arabic City")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic City';

                }
                field("E-Invoice Arabic District"; rec."E-Invoice Arabic District")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic District';

                }
                field("E-Invoice Arabic Country"; rec."E-Invoice Arabic Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Country';

                }
                field("E-Invoice Arabic PostalCode"; rec."E-Invoice Arabic PostalCode")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic PostalCode';

                }
                field("E-Invoice Arabic Additional No"; rec."E-Invoice Arabic Additional No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Additional No';

                }
                field("E-Invoice Arabic VAT No"; rec."E-Invoice Arabic VAT No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic VAT No';

                }
                field("E-Invoice Arabic Other Buyer ID"; rec."E-Invoice Arabic Other Buyer ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Other Seller ID';

                }
                field("E-Invoice Arabic NeighbourHood"; rec."E-Invoice Arabic NeighbourHood")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic NeighbourHood';

                }
                field("E-Invoice Arabic Plot_Iden"; rec."E-Invoice Arabic Plot_Iden")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Plot_Iden';

                }

            }
        }
    }

    actions
    {

    }

    var
}