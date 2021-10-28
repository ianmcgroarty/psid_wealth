#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 235362                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 39                                
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 91                                
   DATE & TIME      : November 8, 2017 @ 13:39:36
*************************************************************************
;

infix
      ER30000           1 - 1       ER30001           2 - 5       ER30002           6 - 8    
      ER25001           9 - 9       ER25004          10 - 11      ER28043A         12 - 13   
      ER33801          14 - 18      ER33802          19 - 20      ER33803          21 - 22   
      ER36001          23 - 23      ER36004          24 - 25      ER41033A         26 - 27   
      ER33901          28 - 32      ER33902          33 - 34      ER33903          35 - 36   
      ER42001          37 - 37      ER42004          38 - 39      ER46975A         40 - 41   
      ER34001          42 - 46      ER34002          47 - 48      ER34003          49 - 50   
      ER47301          51 - 51      ER47304          52 - 53      ER52399A         54 - 55   
      ER34101          56 - 60      ER34102          61 - 62      ER34103          63 - 64   
      ER53001          65 - 65      ER53004          66 - 67      ER58216          68 - 69   
      ER34201          70 - 74      ER34202          75 - 76      ER34203          77 - 78   
      ER60001          79 - 79      ER60004          80 - 81      ER65452          82 - 82   
      ER34301          83 - 87      ER34302          88 - 89      ER34303          90 - 91   
using \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\untouched\J235362.txt, clear 
;
label variable ER30000       "RELEASE NUMBER"                           ;
label variable ER30001       "1968 INTERVIEW NUMBER"                    ;
label variable ER30002       "PERSON NUMBER                         68" ;
label variable ER25001       "RELEASE NUMBER"                           ;
label variable ER25004       "CURRENT STATE"                            ;
label variable ER28043A      "RURAL-URBAN CODE (BEALE-COLLAPSED)"       ;
label variable ER33801       "2005 INTERVIEW NUMBER"                    ;
label variable ER33802       "SEQUENCE NUMBER                       05" ;
label variable ER33803       "RELATION TO HEAD                      05" ;
label variable ER36001       "RELEASE NUMBER"                           ;
label variable ER36004       "CURRENT STATE"                            ;
label variable ER41033A      "RURAL-URBAN CODE (BEALE-COLLAPSED)"       ;
label variable ER33901       "2007 INTERVIEW NUMBER"                    ;
label variable ER33902       "SEQUENCE NUMBER                       07" ;
label variable ER33903       "RELATION TO HEAD                      07" ;
label variable ER42001       "RELEASE NUMBER"                           ;
label variable ER42004       "CURRENT STATE"                            ;
label variable ER46975A      "RURAL-URBAN CODE (BEALE-COLLAPSED)"       ;
label variable ER34001       "2009 INTERVIEW NUMBER"                    ;
label variable ER34002       "SEQUENCE NUMBER                       09" ;
label variable ER34003       "RELATION TO HEAD                      09" ;
label variable ER47301       "RELEASE NUMBER"                           ;
label variable ER47304       "CURRENT STATE"                            ;
label variable ER52399A      "RURAL-URBAN CODE (BEALE-COLLAPSED)"       ;
label variable ER34101       "2011 INTERVIEW NUMBER"                    ;
label variable ER34102       "SEQUENCE NUMBER                       11" ;
label variable ER34103       "RELATION TO HEAD                      11" ;
label variable ER53001       "RELEASE NUMBER"                           ;
label variable ER53004       "CURRENT STATE"                            ;
label variable ER58216       "RURAL-URBAN CODE (BEALE-COLLAPSED)"       ;
label variable ER34201       "2013 INTERVIEW NUMBER"                    ;
label variable ER34202       "SEQUENCE NUMBER                       13" ;
label variable ER34203       "RELATION TO HEAD                      13" ;
label variable ER60001       "RELEASE NUMBER"                           ;
label variable ER60004       "CURRENT STATE"                            ;
label variable ER65452       "METRO/NONMETRO INDICATOR"                 ;
label variable ER34301       "2015 INTERVIEW NUMBER"                    ;
label variable ER34302       "SEQUENCE NUMBER                       15" ;
label variable ER34303       "RELATION TO HEAD                      15" ;

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\state_metro_psid_raw, replace; 
