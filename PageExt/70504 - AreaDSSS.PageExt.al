pageextension 70504 AreaDSSS extends Areas
{
    layout
    {
        addafter(Text)
        {
            field("Arabic Text DSSS"; rec."Arabic Text DSSS")
            {
                ApplicationArea = All;
                ToolTip = 'Arabic Text';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}