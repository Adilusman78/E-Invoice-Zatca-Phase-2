pageextension 70503 "ItemDSSS" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("E-Invoice Arabic Description"; rec."E-Invoice Arabic Description")
            {
                ApplicationArea = All;
                ToolTip = 'Arabic Description';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}