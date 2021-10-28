#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 231427                            
   DATA_DOMAIN      : PSID                              
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 90                                
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 180                               
   DATE & TIME      : August 13, 2017 @ 14:48:49
*************************************************************************
;

infix
      ER30000         1 - 1         ER30001         2 - 5         ER30002         6 - 8    
      ER25001         9 - 9         ER27058        10 - 11        ER27181        12 - 13   
      ER27237        14 - 14        ER27346        15 - 16        ER27442        17 - 18   
      ER28047        19 - 20        ER28048        21 - 22        ER33801        23 - 27   
      ER33802        28 - 29        ER33803        30 - 31        ER36001        32 - 32   
      ER38269        33 - 34        ER39366        35 - 36        ER40402        37 - 38   
      ER40409        39 - 39        ER40521        40 - 41        ER40614        42 - 43   
      ER41037        44 - 45        ER41038        46 - 47        ER33901        48 - 52   
      ER33902        53 - 54        ER33903        55 - 56        ER42001        57 - 57   
      ER42053        58 - 59        ER42058        60 - 60        ER42072        61 - 62   
      ER42077        63 - 63        ER44242        64 - 65        ER45339        66 - 67   
      ER46375        68 - 69        ER46382        70 - 70        ER46498        71 - 72   
      ER46592        73 - 74        ER46981        75 - 76        ER46982        77 - 78   
      ER34001        79 - 83        ER34002        84 - 85        ER34003        86 - 87   
      ER47301        88 - 88        ER47360        89 - 90        ER47365        91 - 91   
      ER47381        92 - 93        ER47386        94 - 94        ER49580        95 - 96   
      ER50698        97 - 98        ER51736        99 - 100       ER51743       101 - 101  
      ER51859       102 - 103       ER51953       104 - 105       ER52405       106 - 107  
      ER52406       108 - 109       ER34101       110 - 114       ER34102       115 - 116  
      ER34103       117 - 118       ER53001       119 - 119       ER53060       120 - 121  
      ER53065       122 - 122       ER53081       123 - 124       ER53086       125 - 125  
      ER55328       126 - 127       ER56444       128 - 129       ER57482       130 - 131  
      ER57484       132 - 132       ER57599       133 - 134       ER57709       135 - 136  
      ER58223       137 - 138       ER58224       139 - 140       ER34201       141 - 145  
      ER34202       146 - 147       ER34203       148 - 149       ER60001       150 - 150  
      ER60061       151 - 152       ER60066       153 - 153       ER60082       154 - 155  
      ER60087       156 - 156       ER62450       157 - 158       ER63566       159 - 160  
      ER64604       161 - 162       ER64606       163 - 163       ER64730       164 - 165  
      ER64869       166 - 167       ER65459       168 - 169       ER65460       170 - 171  
      ER34301       172 - 176       ER34302       177 - 178       ER34303       179 - 180  
using Y:\PSID_Jessica\data\Untouched\J231427.txt, clear 
;
label variable ER30000    "RELEASE NUMBER"                           ;
label variable ER30001    "1968 INTERVIEW NUMBER"                    ;
label variable ER30002    "PERSON NUMBER                         68" ;
label variable ER25001    "RELEASE NUMBER"                           ;
label variable ER27058    "H8A # WEEKS IN HOSPITAL-HEAD"             ;
label variable ER27181    "H32A # WEEKS HOSPITALIZED-WIFE"           ;
label variable ER27237    "H60 WTR FU MEMBER W/HLTH INS LAST 2 YRS"  ;
label variable ER27346    "K61 RELIGIOUS PREFERENCE-WF"              ;
label variable ER27442    "L68 RELIGIOUS PREFERENCE-HD"              ;
label variable ER28047    "COMPLETED ED-HD"                          ;
label variable ER28048    "COMPLETED ED-WF"                          ;
label variable ER33801    "2005 INTERVIEW NUMBER"                    ;
label variable ER33802    "SEQUENCE NUMBER                       05" ;
label variable ER33803    "RELATION TO HEAD                      05" ;
label variable ER36001    "RELEASE NUMBER"                           ;
label variable ER38269    "H8A # WEEKS IN HOSPITAL-HEAD"             ;
label variable ER39366    "H8A # WEEKS HOSPITALIZED-WIFE"            ;
label variable ER40402    "K-6 NON-SPEC PSYCHOL DISTRESS SCALE"      ;
label variable ER40409    "H60 WTR FU MEMBER W/HLTH INS LAST 2 YRS"  ;
label variable ER40521    "K68 RELIGIOUS PREFERENCE-WF"              ;
label variable ER40614    "L68 RELIGIOUS PREFERENCE-HD"              ;
label variable ER41037    "COMPLETED ED-HD"                          ;
label variable ER41038    "COMPLETED ED-WF"                          ;
label variable ER33901    "2007 INTERVIEW NUMBER"                    ;
label variable ER33902    "SEQUENCE NUMBER                       07" ;
label variable ER33903    "RELATION TO HEAD                      07" ;
label variable ER42001    "RELEASE NUMBER"                           ;
label variable ER42053    "A27F2 MONTHS BEHIND ON MTGE # 1"          ;
label variable ER42058    "A27F6 LIKELY TO FALL BEHIND ON MTGE #1"   ;
label variable ER42072    "A27F2 MONTHS BEHIND ON MTGE # 2"          ;
label variable ER42077    "A27F6 LIKELY TO FALL BEHIND ON MTGE # 2"  ;
label variable ER44242    "H8A # WEEKS IN HOSPITAL-HEAD"             ;
label variable ER45339    "H8A # WEEKS HOSPITALIZED-WIFE"            ;
label variable ER46375    "K-6 NON-SPEC PSYCHOL DISTRESS SCALE"      ;
label variable ER46382    "H60 WTR FU MEMBER W/HLTH INS LAST 2 YRS"  ;
label variable ER46498    "K68 RELIGIOUS PREFERENCE-WF"              ;
label variable ER46592    "L68 RELIGIOUS PREFERENCE-HD"              ;
label variable ER46981    "COMPLETED ED-HD"                          ;
label variable ER46982    "COMPLETED ED-WF"                          ;
label variable ER34001    "2009 INTERVIEW NUMBER"                    ;
label variable ER34002    "SEQUENCE NUMBER                       09" ;
label variable ER34003    "RELATION TO HEAD                      09" ;
label variable ER47301    "RELEASE NUMBER"                           ;
label variable ER47360    "A27B MONTHS BEHIND ON MTGE # 1"           ;
label variable ER47365    "A27G LIKELY TO FALL BEHIND ON MTGE #1"    ;
label variable ER47381    "A27B MONTHS BEHIND ON MTGE # 2"           ;
label variable ER47386    "A27G LIKELY TO FALL BEHIND ON MTGE # 2"   ;
label variable ER49580    "H8A # WEEKS IN HOSPITAL-HEAD"             ;
label variable ER50698    "H8A # WEEKS HOSPITALIZED-WIFE"            ;
label variable ER51736    "K-6 NON-SPEC PSYCHOL DISTRESS SCALE"      ;
label variable ER51743    "H60 WTR FU MEMBER W/HLTH INS LAST 2 YRS"  ;
label variable ER51859    "K68 RELIGIOUS PREFERENCE-WF"              ;
label variable ER51953    "L68 RELIGIOUS PREFERENCE-HD"              ;
label variable ER52405    "COMPLETED ED-HD"                          ;
label variable ER52406    "COMPLETED ED-WF"                          ;
label variable ER34101    "2011 INTERVIEW NUMBER"                    ;
label variable ER34102    "SEQUENCE NUMBER                       11" ;
label variable ER34103    "RELATION TO HEAD                      11" ;
label variable ER53001    "RELEASE NUMBER"                           ;
label variable ER53060    "A27B MONTHS BEHIND ON MTGE # 1"           ;
label variable ER53065    "A27G LIKELY TO FALL BEHIND ON MTGE #1"    ;
label variable ER53081    "A27B MONTHS BEHIND ON MTGE # 2"           ;
label variable ER53086    "A27G LIKELY TO FALL BEHIND ON MTGE # 2"   ;
label variable ER55328    "H8A # WEEKS IN HOSPITAL-HEAD"             ;
label variable ER56444    "H8A # WEEKS HOSPITALIZED-WIFE"            ;
label variable ER57482    "K-6 NON-SPEC PSYCHOL DISTRESS SCALE"      ;
label variable ER57484    "H61D2 WTR ANY FU MEMBER HLTH INSURANCE"   ;
label variable ER57599    "K68 RELIGIOUS PREFERENCE-WF"              ;
label variable ER57709    "L68 RELIGIOUS PREFERENCE-HD"              ;
label variable ER58223    "COMPLETED ED-HD"                          ;
label variable ER58224    "COMPLETED ED-WF"                          ;
label variable ER34201    "2013 INTERVIEW NUMBER"                    ;
label variable ER34202    "SEQUENCE NUMBER                       13" ;
label variable ER34203    "RELATION TO HEAD                      13" ;
label variable ER60001    "RELEASE NUMBER"                           ;
label variable ER60061    "A27B MONTHS BEHIND ON MTGE # 1"           ;
label variable ER60066    "A27G LIKELY TO FALL BEHIND ON MTGE #1"    ;
label variable ER60082    "A27B MONTHS BEHIND ON MTGE # 2"           ;
label variable ER60087    "A27G LIKELY TO FALL BEHIND ON MTGE # 2"   ;
label variable ER62450    "H8A # WEEKS IN HOSPITAL-HEAD"             ;
label variable ER63566    "H8A # WEEKS HOSPITALIZED-SPOUSE"          ;
label variable ER64604    "K-6 NON-SPEC PSYCHOL DISTRESS SCALE"      ;
label variable ER64606    "H61D2 WTR ANY FU MEMBER HLTH INSURANCE"   ;
label variable ER64730    "K68 RELIGIOUS PREFERENCE-SP"              ;
label variable ER64869    "L68 RELIGIOUS PREFERENCE-HD"              ;
label variable ER65459    "COMPLETED ED-HD"                          ;
label variable ER65460    "COMPLETED ED-SP"                          ;
label variable ER34301    "2015 INTERVIEW NUMBER"                    ;
label variable ER34302    "SEQUENCE NUMBER                       15" ;
label variable ER34303    "RELATION TO HEAD                      15" ;
save Y:\PSID_Jessica\data\raw\psych_psid_raw.dta,replace ;
