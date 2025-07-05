pageextension 70503 "ItemDSSS" extends "Item Card"
{
    layout
    {
        addafter(Description)
        {
            field("Arabic Description DSSS"; rec."Arabic Description DSSS")
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