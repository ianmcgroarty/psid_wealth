
#delimit ;

**************************************************************************
   Label           : fim11421_gid_BA_3_UBL_wide
   Rows            : 83897
   Columns         : 42
   ASCII File Date : May 25, 2021
*************************************************************************;


infix 
         ER30001               1 - 4    
         ER30002               5 - 7    
         ER30001_P_AF          8 - 11   
         ER30002_P_AF         12 - 14   
         ER30001_P_AM         15 - 18   
         ER30002_P_AM         19 - 21   
         ER30001_P_F          22 - 25   
         ER30002_P_F          26 - 28   
         ER30001_P_M          29 - 32   
         ER30002_P_M          33 - 35   
         ER30001_GP_AFAF      36 - 39   
         ER30002_GP_AFAF      40 - 42   
         ER30001_GP_AFAM      43 - 46   
         ER30002_GP_AFAM      47 - 49   
         ER30001_GP_AFF       50 - 53   
         ER30002_GP_AFF       54 - 56   
         ER30001_GP_AFM       57 - 60   
         ER30002_GP_AFM       61 - 63   
         ER30001_GP_AMAF      64 - 67   
         ER30002_GP_AMAF      68 - 70   
         ER30001_GP_AMAM      71 - 74   
         ER30002_GP_AMAM      75 - 77   
         ER30001_GP_AMF       78 - 81   
         ER30002_GP_AMF       82 - 84   
         ER30001_GP_AMM       85 - 88   
         ER30002_GP_AMM       89 - 91   
         ER30001_GP_FAF       92 - 95   
         ER30002_GP_FAF       96 - 98   
         ER30001_GP_FAM       99 - 102  
         ER30002_GP_FAM      103 - 105  
         ER30001_GP_FF       106 - 109  
         ER30002_GP_FF       110 - 112  
         ER30001_GP_FM       113 - 116  
         ER30002_GP_FM       117 - 119  
         ER30001_GP_MAF      120 - 123  
         ER30002_GP_MAF      124 - 126  
         ER30001_GP_MAM      127 - 130  
         ER30002_GP_MAM      131 - 133  
         ER30001_GP_MF       134 - 137  
         ER30002_GP_MF       138 - 140  
         ER30001_GP_MM       141 - 144  
         ER30002_GP_MM       145 - 147  
using D:/Veronika/psid_cleanup/data/untouched/fims2.txt, clear 
;
label variable  ER30001              "1968 INTERVIEW NUMBER" ;
label variable  ER30002              "PERSON NUMBER 68" ;
label variable  ER30001_P_AF         "1968 INTERVIEW NUMBER /PARENT /ADOPTIVE FATHER" ;
label variable  ER30002_P_AF         "PERSON NUMBER 68 /PARENT /ADOPTIVE FATHER" ;
label variable  ER30001_P_AM         "1968 INTERVIEW NUMBER /PARENT /ADOPTIVE MOTHER" ;
label variable  ER30002_P_AM         "PERSON NUMBER 68 /PARENT /ADOPTIVE MOTHER" ;
label variable  ER30001_P_F          "1968 INTERVIEW NUMBER /PARENT /FATHER" ;
label variable  ER30002_P_F          "PERSON NUMBER 68 /PARENT /FATHER" ;
label variable  ER30001_P_M          "1968 INTERVIEW NUMBER /PARENT /MOTHER" ;
label variable  ER30002_P_M          "PERSON NUMBER 68 /PARENT /MOTHER" ;
label variable  ER30001_GP_AFAF      "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE FATHER'S ADOPTIVE FATHER" ;
label variable  ER30002_GP_AFAF      "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE FATHER'S ADOPTIVE FATHER" ;
label variable  ER30001_GP_AFAM      "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE FATHER'S ADOPTIVE MOTHER" ;
label variable  ER30002_GP_AFAM      "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE FATHER'S ADOPTIVE MOTHER" ;
label variable  ER30001_GP_AFF       "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE FATHER'S FATHER" ;
label variable  ER30002_GP_AFF       "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE FATHER'S FATHER" ;
label variable  ER30001_GP_AFM       "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE FATHER'S MOTHER" ;
label variable  ER30002_GP_AFM       "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE FATHER'S MOTHER" ;
label variable  ER30001_GP_AMAF      "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE MOTHER'S ADOPTIVE FATHER" ;
label variable  ER30002_GP_AMAF      "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE MOTHER'S ADOPTIVE FATHER" ;
label variable  ER30001_GP_AMAM      "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE MOTHER'S ADOPTIVE MOTHER" ;
label variable  ER30002_GP_AMAM      "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE MOTHER'S ADOPTIVE MOTHER" ;
label variable  ER30001_GP_AMF       "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE MOTHER'S FATHER" ;
label variable  ER30002_GP_AMF       "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE MOTHER'S FATHER" ;
label variable  ER30001_GP_AMM       "1968 INTERVIEW NUMBER /GRANDPARENT /ADOPTIVE MOTHER'S MOTHER" ;
label variable  ER30002_GP_AMM       "PERSON NUMBER 68 /GRANDPARENT /ADOPTIVE MOTHER'S MOTHER" ;
label variable  ER30001_GP_FAF       "1968 INTERVIEW NUMBER /GRANDPARENT /FATHER'S ADOPTIVE FATHER" ;
label variable  ER30002_GP_FAF       "PERSON NUMBER 68 /GRANDPARENT /FATHER'S ADOPTIVE FATHER" ;
label variable  ER30001_GP_FAM       "1968 INTERVIEW NUMBER /GRANDPARENT /FATHER'S ADOPTIVE MOTHER" ;
label variable  ER30002_GP_FAM       "PERSON NUMBER 68 /GRANDPARENT /FATHER'S ADOPTIVE MOTHER" ;
label variable  ER30001_GP_FF        "1968 INTERVIEW NUMBER /GRANDPARENT /FATHER'S FATHER" ;
label variable  ER30002_GP_FF        "PERSON NUMBER 68 /GRANDPARENT /FATHER'S FATHER" ;
label variable  ER30001_GP_FM        "1968 INTERVIEW NUMBER /GRANDPARENT /FATHER'S MOTHER" ;
label variable  ER30002_GP_FM        "PERSON NUMBER 68 /GRANDPARENT /FATHER'S MOTHER" ;
label variable  ER30001_GP_MAF       "1968 INTERVIEW NUMBER /GRANDPARENT /MOTHER'S ADOPTIVE FATHER" ;
label variable  ER30002_GP_MAF       "PERSON NUMBER 68 /GRANDPARENT /MOTHER'S ADOPTIVE FATHER" ;
label variable  ER30001_GP_MAM       "1968 INTERVIEW NUMBER /GRANDPARENT /MOTHER'S ADOPTIVE MOTHER" ;
label variable  ER30002_GP_MAM       "PERSON NUMBER 68 /GRANDPARENT /MOTHER'S ADOPTIVE MOTHER" ;
label variable  ER30001_GP_MF        "1968 INTERVIEW NUMBER /GRANDPARENT /MOTHER'S FATHER" ;
label variable  ER30002_GP_MF        "PERSON NUMBER 68 /GRANDPARENT /MOTHER'S FATHER" ;
label variable  ER30001_GP_MM        "1968 INTERVIEW NUMBER /GRANDPARENT /MONTHER'S MOTHER" ;
label variable  ER30002_GP_MM        "PERSON NUMBER 68 /GRANDPARENT /MONTHER'S MOTHER" ;
