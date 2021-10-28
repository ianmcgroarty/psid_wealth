#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 246082                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 33                                
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 86                                
   DATE & TIME      : June 20, 2018 @ 8:52:30
*************************************************************************
;

infix
      ER30000              1 - 1           ER30001              2 - 5           ER30002              6 - 8     
      ER25001              9 - 9           ER25019             10 - 12          ER33801             13 - 17    
      ER33802             18 - 19          ER33803             20 - 21          ER36001             22 - 22    
      ER36019             23 - 25          ER33901             26 - 30          ER33902             31 - 32    
      ER33903             33 - 34          ER42001             35 - 35          ER42019             36 - 38    
      ER34001             39 - 43          ER34002             44 - 45          ER34003             46 - 47    
      ER47301             48 - 48          ER47319             49 - 51          ER34101             52 - 56    
      ER34102             57 - 58          ER34103             59 - 60          ER53001             61 - 61    
      ER53019             62 - 64          ER34201             65 - 69          ER34202             70 - 71    
      ER34203             72 - 73          ER60001             74 - 74          ER60019             75 - 77    
      ER34301             78 - 82          ER34302             83 - 84          ER34303             85 - 86    
using \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\untouched\J246082.txt, clear 
;
label variable ER30000       "RELEASE NUMBER"                           ;
label variable ER30001       "1968 INTERVIEW NUMBER"                    ;
label variable ER30002       "PERSON NUMBER                         68" ;
label variable ER25001       "RELEASE NUMBER"                           ;
label variable ER25019       "AGE OF WIFE"                              ;
label variable ER33801       "2005 INTERVIEW NUMBER"                    ;
label variable ER33802       "SEQUENCE NUMBER                       05" ;
label variable ER33803       "RELATION TO HEAD                      05" ;
label variable ER36001       "RELEASE NUMBER"                           ;
label variable ER36019       "AGE OF WIFE"                              ;
label variable ER33901       "2007 INTERVIEW NUMBER"                    ;
label variable ER33902       "SEQUENCE NUMBER                       07" ;
label variable ER33903       "RELATION TO HEAD                      07" ;
label variable ER42001       "RELEASE NUMBER"                           ;
label variable ER42019       "AGE OF WIFE"                              ;
label variable ER34001       "2009 INTERVIEW NUMBER"                    ;
label variable ER34002       "SEQUENCE NUMBER                       09" ;
label variable ER34003       "RELATION TO HEAD                      09" ;
label variable ER47301       "RELEASE NUMBER"                           ;
label variable ER47319       "AGE OF WIFE"                              ;
label variable ER34101       "2011 INTERVIEW NUMBER"                    ;
label variable ER34102       "SEQUENCE NUMBER                       11" ;
label variable ER34103       "RELATION TO HEAD                      11" ;
label variable ER53001       "RELEASE NUMBER"                           ;
label variable ER53019       "AGE OF WIFE"                              ;
label variable ER34201       "2013 INTERVIEW NUMBER"                    ;
label variable ER34202       "SEQUENCE NUMBER                       13" ;
label variable ER34203       "RELATION TO HEAD                      13" ;
label variable ER60001       "RELEASE NUMBER"                           ;
label variable ER60019       "AGE OF SPOUSE"                            ;
label variable ER34301       "2015 INTERVIEW NUMBER"                    ;
label variable ER34302       "SEQUENCE NUMBER                       15" ;
label variable ER34303       "RELATION TO HEAD                      15" ;

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\wife_psid_raw.dta,replace ;
