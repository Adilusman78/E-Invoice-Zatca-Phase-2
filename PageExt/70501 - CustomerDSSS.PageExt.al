pageextension 70501 "Customer DSSS" extends "Customer Card"
{
    layout
    {
        addafter("Address 2")
        {
            field("Building No_DSSS"; rec."Building No_DSSS")
            {
                ApplicationArea = all;
                ToolTip = 'Building';

            }
            field(District_DSSS; rec.District_DSSS)
            {
                ApplicationArea = all;
                ToolTip = 'District';

            }
            field("Street Name_DSSS"; rec."Street Name_DSSS")
            {
                ApplicationArea = all;
                ToolTip = 'Street Name';

            }
            field("Additional No_DSSS"; rec."Additional No_DSSS")
            {
                ApplicationArea = all;
                ToolTip = 'Additional No';

            }
            field("Other Buyer ID_DSSS"; rec."Other Buyer ID_DSSS")
            {
                ApplicationArea = all;
                ToolTip = 'Other Seller ID';

            }
            field(Additional_Street_Name_DSSS; rec.Additional_Street_Name_DSSS)
            {
                ApplicationArea = all;
                ToolTip = 'Additional_Street_Name';

            }
            field(Plot_Identification_DSSS; rec.Plot_Identification_DSSS)
            {
                ApplicationArea = all;
                ToolTip = 'Plot_Identification';

            }
            field(Customer_ID_DSSS; rec.Customer_ID_DSSS)
            {
                ApplicationArea = all;
                ToolTip = 'Company_ID';

            }
            field(Registration_Name_DSSS; rec.Registration_Name_DSSS)
            {
                ApplicationArea = all;
                ToolTip = 'Registration_Name';

            }
            field("City_Subdivision_Name_DSSS"; rec."City_Subdivision_Name_DSSS")
            {
                ApplicationArea = all;
                ToolTip = 'City_Subdivision_Name';


            }
            field(NeighbourHood_DSSS; rec.NeighbourHood_DSSS)
            {
                ApplicationArea = All;
                ToolTip = 'NeighbourHood';

            }
            field("Scheme_ID_DSSS"; rec."Scheme_ID_DSSS")
            {
                ApplicationArea = all;
                ToolTip = 'Scheme_ID';
            }
            field("Company Type_DSSS"; rec."Company Type_DSSS")
            {
                ApplicationArea = All;
                ToolTip = 'Company Type';


            }
        }
        addafter(General)
        {
            group("Arabic Information_DSSS")
            {
                Caption = 'Arabic Information';
                field("Arabic Name_DSSS"; rec."Arabic Name_DSSS")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic Information';

                }
                field("Arabic Street Name_DSSS"; rec."Arabic Street Name_DSSS")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic Street Name';

                }
                field("Add. Street_Name_Arabic_DSSS"; Rec."Add. Street_Name_Arabic_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add. Street_Name_Arabic';

                }
                field("Arabic Building No_DSSS"; rec."Arabic Building No_DSSS")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic Building No';

                }
                field("Arabic City_DSSS"; rec."Arabic City_DSSS")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic City';

                }
                field("Arabic District_DSSS"; rec."Arabic District_DSSS")
                {
                    ApplicationArea = all;
                    ToolTip = 'Arabic District';

                }
                field("Arabic Country_DSSS"; rec."Arabic Country_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Country';

                }
                field("Arabic PostalCode_DSSS"; rec."Arabic PostalCode_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic PostalCode';

                }
                field("Arabic Additional No_DSSS"; rec."Arabic Additional No_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Additional No';

                }
                field("Arabic VAT No_DSSS"; rec."Arabic VAT No_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic VAT No';

                }
                field("Arabic Other Buyer ID_DSSS"; rec."Arabic Other Buyer ID_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic Other Seller ID';

                }
                field("Arabic NeighbourHood_DSSS"; rec."Arabic NeighbourHood_DSSS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Arabic NeighbourHood';

                }
                field("Arabic Plot_Iden_DSSS"; rec."Arabic Plot_Iden_DSSS")
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