#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 235312                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 81                                
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 170                               
   DATE & TIME      : November 7, 2017 @ 15:21:13
*************************************************************************
;

infix
      ER30000           1 - 1       ER30001           2 - 5       ER30002           6 - 8    
      ER25001           9 - 9       ER25104          10 - 11      ER25105          12 - 13   
      ER25106          14 - 15      ER25311          16 - 17      ER25362          18 - 19   
      ER25363          20 - 21      ER25364          22 - 23      ER25569          24 - 25   
      ER33801          26 - 30      ER33802          31 - 32      ER33803          33 - 34   
      ER33813          35 - 35      ER36001          36 - 36      ER36109          37 - 38   
      ER36110          39 - 40      ER36111          41 - 42      ER36316          43 - 44   
      ER36367          45 - 46      ER36368          47 - 48      ER36369          49 - 50   
      ER36574          51 - 52      ER33901          53 - 57      ER33902          58 - 59   
      ER33903          60 - 61      ER33913          62 - 62      ER42001          63 - 63   
      ER42140          64 - 65      ER42141          66 - 67      ER42142          68 - 69   
      ER42343          70 - 71      ER42392          72 - 73      ER42393          74 - 75   
      ER42394          76 - 77      ER42595          78 - 79      ER34001          80 - 84   
      ER34002          85 - 86      ER34003          87 - 88      ER34016          89 - 89   
      ER47301          90 - 90      ER47448          91 - 92      ER47449          93 - 94   
      ER47450          95 - 96      ER47656          97 - 98      ER47705          99 - 100  
      ER47706         101 - 102     ER47707         103 - 104     ER47913         105 - 106  
      ER34101         107 - 111     ER34102         112 - 113     ER34103         114 - 115  
      ER34116         116 - 116     ER53001         117 - 117     ER53148         118 - 119  
      ER53149         120 - 121     ER53150         122 - 123     ER53356         124 - 125  
      ER53411         126 - 127     ER53412         128 - 129     ER53413         130 - 131  
      ER53619         132 - 133     ER34201         134 - 138     ER34202         139 - 140  
      ER34203         141 - 142     ER34216         143 - 143     ER60001         144 - 144  
      ER60163         145 - 146     ER60164         147 - 148     ER60165         149 - 150  
      ER60371         151 - 152     ER60426         153 - 154     ER60427         155 - 156  
      ER60428         157 - 158     ER60634         159 - 160     ER34301         161 - 165  
      ER34302         166 - 167     ER34303         168 - 169     ER34317         170 - 170  
using \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\untouched\J235312.txt, clear 
;
label variable ER30000       "RELEASE NUMBER"                           ;
label variable ER30001       "1968 INTERVIEW NUMBER"                    ;
label variable ER30002       "PERSON NUMBER                         68" ;
label variable ER25001       "RELEASE NUMBER"                           ;
label variable ER25104       "BC1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER25105       "BC1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER25106       "BC1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER25311       "BC8 MONTHS UNEMPLOYED"                    ;
label variable ER25362       "DE1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER25363       "DE1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER25364       "DE1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER25569       "DE8 MONTHS UNEMPLOYED"                    ;
label variable ER33801       "2005 INTERVIEW NUMBER"                    ;
label variable ER33802       "SEQUENCE NUMBER                       05" ;
label variable ER33803       "RELATION TO HEAD                      05" ;
label variable ER33813       "EMPLOYMENT STATUS                     05" ;
label variable ER36001       "RELEASE NUMBER"                           ;
label variable ER36109       "BC1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER36110       "BC1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER36111       "BC1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER36316       "BC8 MONTHS UNEMPLOYED"                    ;
label variable ER36367       "DE1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER36368       "DE1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER36369       "DE1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER36574       "DE8 MONTHS UNEMPLOYED"                    ;
label variable ER33901       "2007 INTERVIEW NUMBER"                    ;
label variable ER33902       "SEQUENCE NUMBER                       07" ;
label variable ER33903       "RELATION TO HEAD                      07" ;
label variable ER33913       "EMPLOYMENT STATUS                     07" ;
label variable ER42001       "RELEASE NUMBER"                           ;
label variable ER42140       "BC1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER42141       "BC1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER42142       "BC1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER42343       "BC8 MONTHS UNEMPLOYED"                    ;
label variable ER42392       "DE1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER42393       "DE1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER42394       "DE1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER42595       "DE8 MONTHS UNEMPLOYED"                    ;
label variable ER34001       "2009 INTERVIEW NUMBER"                    ;
label variable ER34002       "SEQUENCE NUMBER                       09" ;
label variable ER34003       "RELATION TO HEAD                      09" ;
label variable ER34016       "EMPLOYMENT STATUS                     09" ;
label variable ER47301       "RELEASE NUMBER"                           ;
label variable ER47448       "BC1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER47449       "BC1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER47450       "BC1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER47656       "BC8 MONTHS UNEMPLOYED"                    ;
label variable ER47705       "DE1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER47706       "DE1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER47707       "DE1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER47913       "DE8 MONTHS UNEMPLOYED"                    ;
label variable ER34101       "2011 INTERVIEW NUMBER"                    ;
label variable ER34102       "SEQUENCE NUMBER                       11" ;
label variable ER34103       "RELATION TO HEAD                      11" ;
label variable ER34116       "EMPLOYMENT STATUS                     11" ;
label variable ER53001       "RELEASE NUMBER"                           ;
label variable ER53148       "BC1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER53149       "BC1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER53150       "BC1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER53356       "BC8 MONTHS UNEMPLOYED"                    ;
label variable ER53411       "DE1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER53412       "DE1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER53413       "DE1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER53619       "DE8 MONTHS UNEMPLOYED"                    ;
label variable ER34201       "2013 INTERVIEW NUMBER"                    ;
label variable ER34202       "SEQUENCE NUMBER                       13" ;
label variable ER34203       "RELATION TO HEAD                      13" ;
label variable ER34216       "EMPLOYMENT STATUS                     13" ;
label variable ER60001       "RELEASE NUMBER"                           ;
label variable ER60163       "BC1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER60164       "BC1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER60165       "BC1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER60371       "BC8 MONTHS UNEMPLOYED"                    ;
label variable ER60426       "DE1 EMPLOYMENT STATUS-1ST MENTION"        ;
label variable ER60427       "DE1 EMPLOYMENT STATUS-2ND MENTION"        ;
label variable ER60428       "DE1 EMPLOYMENT STATUS-3RD MENTION"        ;
label variable ER60634       "DE8 MONTHS UNEMPLOYED"                    ;
label variable ER34301       "2015 INTERVIEW NUMBER"                    ;
label variable ER34302       "SEQUENCE NUMBER                       15" ;
label variable ER34303       "RELATION TO HEAD                      15" ;
label variable ER34317       "EMPLOYMENT STATUS                     15" ;

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\unemploy_psid_raw.dta,replace ;
