tableextension 70500 "CompanyInfo DSSS" extends "Company Information"
{
    fields
    {
        field(50501; "Building No_DSSS"; Text[30])

        {
            Caption = 'Building No';
            DataClassification = CustomerContent;
        }
        field(50502; "Street Name_DSSS"; Text[50])
        {
            Caption = 'Street Name';
            DataClassification = CustomerContent;
        }
        field(50503; "District_DSSS"; text[50])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
        }
        field(50504; "Arabic Building No_DSSS"; Text[30])

        {
            Caption = 'لا للبناء';
            DataClassification = CustomerContent;
        }
        field(50505; "Arabic Street Name_DSSS"; Text[50])
        {
            Caption = 'اسم الشارع';
            DataClassification = CustomerContent;
        }
        field(50506; "Arabic District_DSSS"; text[50])
        {
            Caption = 'يصرف';
            DataClassification = CustomerContent;
        }
        field(50507; "Arabic City_DSSS"; Text[30])
        {
            Caption = 'مدينة';
            DataClassification = CustomerContent;
        }
        field(50508; "Arabic Name_DSSS"; Text[50])
        {
            Caption = 'اسم';
            DataClassification = CustomerContent;
        }
        field(50509; "Additional No_DSSS"; Text[30])
        {
            Caption = 'Additional No';
            DataClassification = CustomerContent;
        }
        field(50510; "Other Seller ID_DSSS"; Text[30])
        {
            Caption = 'Other Seller ID';
            DataClassification = CustomerContent;

        }

        field(50511; "Additional_Street_Name_DSSS"; Text[50])
        {
            Caption = 'Additional Street Name';
            DataClassification = CustomerContent;

        }
        field(50512; "Plot_Identification_DSSS"; Text[50])
        {
            Caption = 'Plot Identification';
            DataClassification = CustomerContent;

        }
        field(50513; "Company_ID_DSSS"; Text[50])
        {
            Caption = 'Company ID';
            DataClassification = CustomerContent;

        }
        field(50514; "Registration_Name_DSSS"; Text[50])
        {
            Caption = 'Registration Name';
            DataClassification = CustomerContent;

        }
        field(50515; "Scheme_ID_DSSS"; Text[50])
        {
            Caption = 'Scheme ID';
            DataClassification = CustomerContent;

        }
        field(50516; "City_Subdivision_Name_DSSS"; Text[50])
        {
            Caption = 'City Subdivision';
            DataClassification = CustomerContent;

        }
        field(50517; "Add. Street_Name_Arabic_DSSS"; Text[50])
        {
            Caption = 'شارع إضافي';
            DataClassification = CustomerContent;
        }

        field(50518; "Arabic Country_DSSS"; Text[30])
        {
            Caption = 'البلد';
            DataClassification = CustomerContent;
        }
        field(50519; "Arabic PostalCode_DSSS"; Text[30])
        {
            Caption = 'الرمز البريدي';
            DataClassification = CustomerContent;
        }
        field(50520; "Arabic Additional No_DSSS"; Text[30])
        {
            Caption = 'الرقم إضافي للعنوان';
            DataClassification = CustomerContent;
        }
        field(50521; "Arabic VAT No_DSSS"; Text[20])
        {
            Caption = 'رقم تسجيل ضريبة القيمة المضافة';
            DataClassification = CustomerContent;
        }
        field(50522; "Arabic Other Seller ID_DSSS"; Text[30])
        {
            Caption = 'معرف آخر';
            DataClassification = CustomerContent;

        }
        field(50123; "NeighbourHood_DSSS"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'NeighbourHood';
        }

        field(50124; "Arabic NeighbourHood_DSSS"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'حي';
        }
        field(50525; "Arabic Plot_Iden_DSSS"; Text[50])
        {
            Caption = 'التحديد المؤامرة';
            DataClassification = CustomerContent;

        }
        field(50526; "Invoice Hash_DSSS"; Text[250])
        {
            Caption = 'Invoice Hash';
            DataClassification = ToBeClassified;

        }
        field(70500; "Zatca Function_DSSS"; Boolean)
        {
            Caption = 'Zatca Function';
            DataClassification = ToBeClassified;

        }
        //aDYuZlbAvZAe591Ppq312vS59Dem59+jk4Y+m5HeN1Y= 44
    }

}