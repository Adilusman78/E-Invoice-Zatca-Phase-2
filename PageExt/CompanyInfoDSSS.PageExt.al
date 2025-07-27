pageextension 70500 "CompanyInfo DSSS" extends "Company Information"
{
    layout
    {
        addafter("Address 2")
        {

        }
        addafter(General)
        {

        }
    }

    actions
    {
        addafter(Action1030000)
        {
            action("E-Invoice Comapny Information")
            {
                Caption = 'E-Invoice Comapny Information';
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'E-Invoice Comapny Information';
                Image = Info;
                RunObject = page "Zatca Company Info";
                RunPageLink = Name = field(Name);
            }

        }
    }

    var

}