#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 235509                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 63                                
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 128                               
   DATE & TIME      : November 10, 2017 @ 11:13:56
*************************************************************************
;

infix
      ER30000           1 - 1       ER30001           2 - 5       ER30002           6 - 8    
      ER25001           9 - 9       ER25017          10 - 12      ER25018          13 - 13   
      ER25023          14 - 14      ER27393          15 - 15      ER28047          16 - 17   
      ER28048          18 - 19      ER33801          20 - 24      ER33802          25 - 26   
      ER33803          27 - 28      ER36001          29 - 29      ER36017          30 - 32   
      ER36018          33 - 33      ER36023          34 - 34      ER40565          35 - 35   
      ER41037          36 - 37      ER41038          38 - 39      ER33901          40 - 44   
      ER33902          45 - 46      ER33903          47 - 48      ER42001          49 - 49   
      ER42017          50 - 52      ER42018          53 - 53      ER42023          54 - 54   
      ER46543          55 - 55      ER46981          56 - 57      ER46982          58 - 59   
      ER34001          60 - 64      ER34002          65 - 66      ER34003          67 - 68   
      ER47301          69 - 69      ER47317          70 - 72      ER47318          73 - 73   
      ER47323          74 - 74      ER51904          75 - 75      ER52405          76 - 77   
      ER52406          78 - 79      ER34101          80 - 84      ER34102          85 - 86   
      ER34103          87 - 88      ER53001          89 - 89      ER53017          90 - 92   
      ER53018          93 - 93      ER53023          94 - 94      ER57659          95 - 95   
      ER58223          96 - 97      ER58224          98 - 99      ER34201         100 - 104  
      ER34202         105 - 106     ER34203         107 - 108     ER60001         109 - 109  
      ER60017         110 - 112     ER60018         113 - 113     ER60024         114 - 114  
      ER64810         115 - 115     ER65459         116 - 117     ER65460         118 - 119  
      ER34301         120 - 124     ER34302         125 - 126     ER34303         127 - 128  

using \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\untouched\J235509.txt, clear 
;
label variable ER30000       "RELEASE NUMBER"                           ;
label variable ER30001       "1968 INTERVIEW NUMBER"                    ;
label variable ER30002       "PERSON NUMBER                         68" ;
label variable ER25001       "RELEASE NUMBER"                           ;
label variable ER25017       "AGE OF HEAD"                              ;
label variable ER25018       "SEX OF HEAD"                              ;
label variable ER25023       "HEAD MARITAL STATUS"                      ;
label variable ER27393       "L40 RACE OF HEAD-MENTION 1"               ;
label variable ER28047       "COMPLETED ED-HD"                          ;
label variable ER28048       "COMPLETED ED-WF"                          ;
label variable ER33801       "2005 INTERVIEW NUMBER"                    ;
label variable ER33802       "SEQUENCE NUMBER                       05" ;
label variable ER33803       "RELATION TO HEAD                      05" ;
label variable ER36001       "RELEASE NUMBER"                           ;
label variable ER36017       "AGE OF HEAD"                              ;
label variable ER36018       "SEX OF HEAD"                              ;
label variable ER36023       "HEAD MARITAL STATUS"                      ;
label variable ER40565       "L40 RACE OF HEAD-MENTION 1"               ;
label variable ER41037       "COMPLETED ED-HD"                          ;
label variable ER41038       "COMPLETED ED-WF"                          ;
label variable ER33901       "2007 INTERVIEW NUMBER"                    ;
label variable ER33902       "SEQUENCE NUMBER                       07" ;
label variable ER33903       "RELATION TO HEAD                      07" ;
label variable ER42001       "RELEASE NUMBER"                           ;
label variable ER42017       "AGE OF HEAD"                              ;
label variable ER42018       "SEX OF HEAD"                              ;
label variable ER42023       "HEAD MARITAL STATUS"                      ;
label variable ER46543       "L40 RACE OF HEAD-MENTION 1"               ;
label variable ER46981       "COMPLETED ED-HD"                          ;
label variable ER46982       "COMPLETED ED-WF"                          ;
label variable ER34001       "2009 INTERVIEW NUMBER"                    ;
label variable ER34002       "SEQUENCE NUMBER                       09" ;
label variable ER34003       "RELATION TO HEAD                      09" ;
label variable ER47301       "RELEASE NUMBER"                           ;
label variable ER47317       "AGE OF HEAD"                              ;
label variable ER47318       "SEX OF HEAD"                              ;
label variable ER47323       "HEAD MARITAL STATUS"                      ;
label variable ER51904       "L40 RACE OF HEAD-MENTION 1"               ;
label variable ER52405       "COMPLETED ED-HD"                          ;
label variable ER52406       "COMPLETED ED-WF"                          ;
label variable ER34101       "2011 INTERVIEW NUMBER"                    ;
label variable ER34102       "SEQUENCE NUMBER                       11" ;
label variable ER34103       "RELATION TO HEAD                      11" ;
label variable ER53001       "RELEASE NUMBER"                           ;
label variable ER53017       "AGE OF HEAD"                              ;
label variable ER53018       "SEX OF HEAD"                              ;
label variable ER53023       "HEAD MARITAL STATUS"                      ;
label variable ER57659       "L40 RACE OF HEAD-MENTION 1"               ;
label variable ER58223       "COMPLETED ED-HD"                          ;
label variable ER58224       "COMPLETED ED-WF"                          ;
label variable ER34201       "2013 INTERVIEW NUMBER"                    ;
label variable ER34202       "SEQUENCE NUMBER                       13" ;
label variable ER34203       "RELATION TO HEAD                      13" ;
label variable ER60001       "RELEASE NUMBER"                           ;
label variable ER60017       "AGE OF HEAD"                              ;
label variable ER60018       "SEX OF HEAD"                              ;
label variable ER60024       "HEAD MARITAL STATUS"                      ;
label variable ER64810       "L40 RACE OF HEAD-MENTION 1"               ;
label variable ER65459       "COMPLETED ED-HD"                          ;
label variable ER65460       "COMPLETED ED-SP"                          ;
label variable ER34301       "2015 INTERVIEW NUMBER"                    ;
label variable ER34302       "SEQUENCE NUMBER                       15" ;
label variable ER34303       "RELATION TO HEAD                      15" ;
save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\demographics_psid_raw.dta,replace ;
