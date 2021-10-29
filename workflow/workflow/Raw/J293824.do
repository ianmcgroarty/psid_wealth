#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 293824                            
   DATA_DOMAIN      : FAM                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : NULL                              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 28                                
   N_OF_OBSERVATIONS: 17489                             
   MAX_REC_LENGTH   : 159                               
   DATE & TIME      : May 31, 2021 @ 21:30:17
*************************************************************************
;

infix
      ER13002              1 - 5      long S416                 6 - 14          ER17002             15 - 18    
 long S516                19 - 27          ER21002             28 - 32     long S616                33 - 41    
      ER25002             42 - 46     long S716                47 - 55          ER36002             56 - 60    
 long S816                61 - 69          ER42001             70 - 70          ER42002             71 - 75    
 long ER46968             76 - 84          ER47301             85 - 85          ER47302             86 - 90    
 long ER52392             91 - 99          ER53001            100 - 100         ER53002            101 - 105   
 long ER58209            106 - 114         ER60001            115 - 115         ER60002            116 - 120   
 long ER65406            121 - 129         ER66001            130 - 130         ER66002            131 - 135   
 long ER71483            136 - 144         ER72001            145 - 145         ER72002            146 - 150   
 long ER77509            151 - 159   
using D:/Veronika/psid_cleanup/data/untouched/J293824.txt, clear 
;
label variable ER13002         "1999 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S416            "IMP WEALTH W/O EQUITY (WEALTH1) 99"       ;
label variable ER17002         "2001 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S516            "IMP WEALTH W/O EQUITY (WEALTH1) 01"       ;
label variable ER21002         "2003 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S616            "IMP WEALTH W/O EQUITY (WEALTH1) 03"       ;
label variable ER25002         "2005 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S716            "IMP WEALTH W/O EQUITY (WEALTH1) 05"       ;
label variable ER36002         "2007 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S816            "IMP WEALTH W/O EQUITY (WEALTH1) 07"       ;
label variable ER42001         "RELEASE NUMBER"                           ;
label variable ER42002         "2009 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER46968         "IMP WEALTH W/O EQUITY (WEALTH1) 09"       ;
label variable ER47301         "RELEASE NUMBER"                           ;
label variable ER47302         "2011 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER52392         "IMP WEALTH W/O EQUITY (WEALTH1) 11"       ;
label variable ER53001         "RELEASE NUMBER"                           ;
label variable ER53002         "2013 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER58209         "IMP WEALTH W/O EQUITY (WEALTH1) 2013"     ;
label variable ER60001         "RELEASE NUMBER"                           ;
label variable ER60002         "2015 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER65406         "IMP WEALTH W/O EQUITY (WEALTH1) 2015"     ;
label variable ER66001         "RELEASE NUMBER"                           ;
label variable ER66002         "2017 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER71483         "IMP WEALTH W/O EQUITY (WEALTH1) 2017"     ;
label variable ER72001         "RELEASE NUMBER"                           ;
label variable ER72002         "2019 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER77509         "IMP WEALTH W/O EQUITY (WEALTH1) 2019"     ;
