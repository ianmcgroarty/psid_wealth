#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 293921                            
   DATA_DOMAIN      : FAM                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : NULL                              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 34                                
   N_OF_OBSERVATIONS: 25673                             
   MAX_REC_LENGTH   : 199                               
   DATE & TIME      : June 3, 2021 @ 9:47:05
*************************************************************************
;

infix
      V10002               1 - 4      long S117                 5 - 13          V16302              14 - 17    
 long S217                18 - 26          ER2002              27 - 31     long S317                32 - 40    
      ER13002             41 - 45     long S417                46 - 54          ER17002             55 - 58    
 long S517                59 - 67          ER21002             68 - 72     long S617                73 - 81    
      ER25002             82 - 86     long S717                87 - 95          ER36002             96 - 100   
 long S817               101 - 109         ER42001            110 - 110         ER42002            111 - 115   
 long ER46970            116 - 124         ER47301            125 - 125         ER47302            126 - 130   
 long ER52394            131 - 139         ER53001            140 - 140         ER53002            141 - 145   
 long ER58211            146 - 154         ER60001            155 - 155         ER60002            156 - 160   
 long ER65408            161 - 169         ER66001            170 - 170         ER66002            171 - 175   
 long ER71485            176 - 184         ER72001            185 - 185         ER72002            186 - 190   
 long ER77511            191 - 199   
using "$path/psid_cleanup/data/untouched/J293921.txt", clear 
;
label variable V10002          "1984 INTERVIEW NUMBER"                    ;
label variable S117            "IMP WEALTH W/ EQUITY (WEALTH2) 84"        ;
label variable V16302          "1989 INTERVIEW NUMBER"                    ;
label variable S217            "IMP WEALTH W/ EQUITY (WEALTH2) 89"        ;
label variable ER2002          "1994 INTERVIEW #"                         ;
label variable S317            "IMP WEALTH W/ EQUITY (WEALTH2) 94"        ;
label variable ER13002         "1999 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S417            "IMP WEALTH W/ EQUITY (WEALTH2) 99"        ;
label variable ER17002         "2001 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S517            "IMP WEALTH W/ EQUITY (WEALTH2) 01"        ;
label variable ER21002         "2003 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S617            "IMP WEALTH W/ EQUITY (WEALTH2) 03"        ;
label variable ER25002         "2005 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S717            "IMP WEALTH W/ EQUITY (WEALTH2) 05"        ;
label variable ER36002         "2007 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable S817            "IMP WEALTH W/ EQUITY (WEALTH2) 07"        ;
label variable ER42001         "RELEASE NUMBER"                           ;
label variable ER42002         "2009 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER46970         "IMP WEALTH W/ EQUITY (WEALTH2) 09"        ;
label variable ER47301         "RELEASE NUMBER"                           ;
label variable ER47302         "2011 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER52394         "IMP WEALTH W/ EQUITY (WEALTH2) 11"        ;
label variable ER53001         "RELEASE NUMBER"                           ;
label variable ER53002         "2013 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER58211         "IMP WEALTH W/ EQUITY (WEALTH2) 2013"      ;
label variable ER60001         "RELEASE NUMBER"                           ;
label variable ER60002         "2015 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER65408         "IMP WEALTH W/ EQUITY (WEALTH2) 2015"      ;
label variable ER66001         "RELEASE NUMBER"                           ;
label variable ER66002         "2017 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER71485         "IMP WEALTH W/ EQUITY (WEALTH2) 2017"      ;
label variable ER72001         "RELEASE NUMBER"                           ;
label variable ER72002         "2019 FAMILY INTERVIEW (ID) NUMBER"        ;
label variable ER77511         "IMP WEALTH W/ EQUITY (WEALTH2) 2019"      ;
