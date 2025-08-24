tableextension 70500 "CompanyInfo DSSS" extends "Company Information"
{
    fields
    {
        field(70501; "E-Invoice Building No"; Text[30])

        {
            Caption = 'Building No';
            DataClassification = CustomerContent;
        }
        field(70502; "E-Invoice Street Name"; Text[50])
        {
            Caption = 'Street Name';
            DataClassification = CustomerContent;
        }
        field(70503; "E-Invoice District"; text[50])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
        }
        field(70504; "E-Invoice Arabic Building No"; Text[30])

        {
            Caption = 'لا للبناء';
            DataClassification = CustomerContent;
        }
        field(70505; "E-Invoice Arabic Street Name"; Text[50])
        {
            Caption = 'اسم الشارع';
            DataClassification = CustomerContent;
        }
        field(70506; "E-Invoice Arabic District"; text[50])
        {
            Caption = 'يصرف';
            DataClassification = CustomerContent;
        }
        field(70507; "E-Invoice Arabic City"; Text[30])
        {
            Caption = 'مدينة';
            DataClassification = CustomerContent;
        }
        field(70508; "E-Invoice Arabic Name"; Text[50])
        {
            Caption = 'اسم';
            DataClassification = CustomerContent;
        }
        field(70509; "E-Invoice Additional No"; Text[30])
        {
            Caption = 'Additional No';
            DataClassification = CustomerContent;
        }
        field(70510; "E-Invoice Other Seller ID"; Text[30])
        {
            Caption = 'Other Seller ID';
            DataClassification = CustomerContent;

        }

        field(70511; "E-Invoice Additional_Street_Name"; Text[50])
        {
            Caption = 'Additional Street Name';
            DataClassification = CustomerContent;

        }
        field(70512; "E-Invoice Plot_Identification"; Text[50])
        {
            Caption = 'Plot Identification';
            DataClassification = CustomerContent;

        }
        field(70513; "E-Invoice Company_ID"; Text[50])
        {
            Caption = 'Company ID';
            DataClassification = CustomerContent;

        }
        field(70514; "E-Invoice Registration_Name"; Text[50])
        {
            Caption = 'Registration Name';
            DataClassification = CustomerContent;

        }
        field(70515; "E-Invoice Scheme_ID"; Text[50])
        {
            Caption = 'Scheme ID';
            DataClassification = CustomerContent;

        }
        field(70516; "E-Invoice City_Subdivision_Name"; Text[50])
        {
            Caption = 'City Subdivision';
            DataClassification = CustomerContent;

        }
        field(70517; "E-Invoice Add. Street_Name_Arabic"; Text[50])
        {
            Caption = 'شارع إضافي';
            DataClassification = CustomerContent;
        }

        field(70518; "E-Invoice Arabic Country"; Text[30])
        {
            Caption = 'البلد';
            DataClassification = CustomerContent;
        }
        field(70519; "E-Invoice Arabic PostalCode"; Text[30])
        {
            Caption = 'الرمز البريدي';
            DataClassification = CustomerContent;
        }
        field(70520; "E-Invoice Arabic Additional No"; Text[30])
        {
            Caption = 'الرقم إضافي للعنوان';
            DataClassification = CustomerContent;
        }
        field(70521; "E-Invoice Arabic VAT No"; Text[20])
        {
            Caption = 'رقم تسجيل ضريبة القيمة المضافة';
            DataClassification = CustomerContent;
        }
        field(70522; "E-Invoice Arabic Other Seller ID"; Text[30])
        {
            Caption = 'معرف آخر';
            DataClassification = CustomerContent;

        }
        field(70523; "E-Invoice NeighbourHood"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'NeighbourHood';

        }

        field(70524; "E-Invoice Arabic NeighbourHood"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'حي';
        }
        field(70525; "E-Invoice Arabic Plot_Iden"; Text[50])
        {
            Caption = 'التحديد المؤامرة';
            DataClassification = CustomerContent;

        }
        field(70526; "E-Invoice Invoice Hash"; Text[250])
        {
            Caption = 'Invoice Hash';
            DataClassification = CustomerContent;

        }
        field(70500; "E-Invoice Zatca Function"; Boolean)
        {
            Caption = 'Zatca Function';
            DataClassification = CustomerContent;

        }
        //aDYuZlbAvZAe591Ppq312vS59Dem59+jk4Y+m5HeN1Y= 44
    }

}