pageextension 70504 AreaDSSS extends Areas
{
    layout
    {
        addafter(Text)
        {
            field("E-Invoice Arabic Text"; rec."E-Invoice Arabic Text")
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