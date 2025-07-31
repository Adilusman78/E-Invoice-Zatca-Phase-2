tableextension 70500 "CompanyInfo DSSS" extends "Company Information"
{
    fields
    {
        field(50501; "E-Invoice Building No"; Text[30])

        {
            Caption = 'Building No';
            DataClassification = CustomerContent;
        }
        field(50502; "E-Invoice Street Name"; Text[50])
        {
            Caption = 'Street Name';
            DataClassification = CustomerContent;
        }
        field(50503; "E-Invoice District"; text[50])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
        }
        field(50504; "E-Invoice Arabic Building No"; Text[30])

        {
            Caption = 'لا للبناء';
            DataClassification = CustomerContent;
        }
        field(50505; "E-Invoice Arabic Street Name"; Text[50])
        {
            Caption = 'اسم الشارع';
            DataClassification = CustomerContent;
        }
        field(50506; "E-Invoice Arabic District"; text[50])
        {
            Caption = 'يصرف';
            DataClassification = CustomerContent;
        }
        field(50507; "E-Invoice Arabic City"; Text[30])
        {
            Caption = 'مدينة';
            DataClassification = CustomerContent;
        }
        field(50508; "E-Invoice Arabic Name"; Text[50])
        {
            Caption = 'اسم';
            DataClassification = CustomerContent;
        }
        field(50509; "E-Invoice Additional No"; Text[30])
        {
            Caption = 'Additional No';
            DataClassification = CustomerContent;
        }
        field(50510; "E-Invoice Other Seller ID"; Text[30])
        {
            Caption = 'Other Seller ID';
            DataClassification = CustomerContent;

        }

        field(50511; "E-Invoice Additional_Street_Name"; Text[50])
        {
            Caption = 'Additional Street Name';
            DataClassification = CustomerContent;

        }
        field(50512; "E-Invoice Plot_Identification"; Text[50])
        {
            Caption = 'Plot Identification';
            DataClassification = CustomerContent;

        }
        field(50513; "E-Invoice Company_ID"; Text[50])
        {
            Caption = 'Company ID';
            DataClassification = CustomerContent;

        }
        field(50514; "E-Invoice Registration_Name"; Text[50])
        {
            Caption = 'Registration Name';
            DataClassification = CustomerContent;

        }
        field(50515; "E-Invoice Scheme_ID"; Text[50])
        {
            Caption = 'Scheme ID';
            DataClassification = CustomerContent;

        }
        field(50516; "E-Invoice City_Subdivision_Name"; Text[50])
        {
            Caption = 'City Subdivision';
            DataClassification = CustomerContent;

        }
        field(50517; "E-Invoice Add. Street_Name_Arabic"; Text[50])
        {
            Caption = 'شارع إضافي';
            DataClassification = CustomerContent;
        }

        field(50518; "E-Invoice Arabic Country"; Text[30])
        {
            Caption = 'البلد';
            DataClassification = CustomerContent;
        }
        field(50519; "E-Invoice Arabic PostalCode"; Text[30])
        {
            Caption = 'الرمز البريدي';
            DataClassification = CustomerContent;
        }
        field(50520; "E-Invoice Arabic Additional No"; Text[30])
        {
            Caption = 'الرقم إضافي للعنوان';
            DataClassification = CustomerContent;
        }
        field(50521; "E-Invoice Arabic VAT No"; Text[20])
        {
            Caption = 'رقم تسجيل ضريبة القيمة المضافة';
            DataClassification = CustomerContent;
        }
        field(50522; "E-Invoice Arabic Other Seller ID"; Text[30])
        {
            Caption = 'معرف آخر';
            DataClassification = CustomerContent;

        }
        field(50123; "E-Invoice NeighbourHood"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'NeighbourHood';
        }

        field(50124; "E-Invoice Arabic NeighbourHood"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'حي';
        }
        field(50525; "E-Invoice Arabic Plot_Iden"; Text[50])
        {
            Caption = 'التحديد المؤامرة';
            DataClassification = CustomerContent;

        }
        field(50526; "E-Invoice Invoice Hash"; Text[250])
        {
            Caption = 'Invoice Hash';
            DataClassification = ToBeClassified;

        }
        field(70500; "E-Invoice Zatca Function"; Boolean)
        {
            Caption = 'Zatca Function';
            DataClassification = ToBeClassified;

        }
        //aDYuZlbAvZAe591Ppq312vS59Dem59+jk4Y+m5HeN1Y= 44
    }

}