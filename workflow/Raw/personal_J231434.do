#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 231434                            
   DATA_DOMAIN      : PSID                              
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 120                               
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 330                               
   DATE & TIME      : August 13, 2017 @ 16:09:11
*************************************************************************
;

infix
      ER30000         1 - 1         ER30001         2 - 5         ER30002         6 - 8    
      ER25001         9 - 9         ER25017        10 - 12        ER25029        13 - 19   
      ER25039        20 - 20        ER25042        21 - 27        ER25053        28 - 34   
      ER27058        35 - 36        ER27181        37 - 38        ER27237        39 - 39   
      ER27346        40 - 41        ER27442        42 - 43        ER28047        44 - 45   
      ER28048        46 - 47        ER33801        48 - 52        ER33802        53 - 54   
      ER33803        55 - 56        ER36001        57 - 57        ER36017        58 - 60   
      ER36029        61 - 67        ER36039        68 - 68        ER36042        69 - 75   
      ER36054        76 - 82        ER38269        83 - 84        ER39366        85 - 86   
      ER40402        87 - 88        ER40409        89 - 89        ER40521        90 - 91   
      ER40614        92 - 93        ER41037        94 - 95        ER41038        96 - 97   
      ER33901        98 - 102       ER33902       103 - 104       ER33903       105 - 106  
      ER42001       107 - 107       ER42017       108 - 110       ER42030       111 - 117  
      ER42040       118 - 118       ER42043       119 - 125       ER42053       126 - 127  
      ER42058       128 - 128       ER42062       129 - 135       ER42072       136 - 137  
      ER42077       138 - 138       ER44242       139 - 140       ER45339       141 - 142  
      ER46375       143 - 144       ER46382       145 - 145       ER46498       146 - 147  
      ER46592       148 - 149       ER46981       150 - 151       ER46982       152 - 153  
      ER34001       154 - 158       ER34002       159 - 160       ER34003       161 - 162  
      ER47301       163 - 163       ER47317       164 - 166       ER47330       167 - 173  
      ER47345       174 - 174       ER47348       175 - 181       ER47360       182 - 183  
      ER47365       184 - 184       ER47369       185 - 191       ER47381       192 - 193  
      ER47386       194 - 194       ER49580       195 - 196       ER50698       197 - 198  
      ER51736       199 - 200       ER51743       201 - 201       ER51859       202 - 203  
      ER51953       204 - 205       ER52405       206 - 207       ER52406       208 - 209  
      ER34101       210 - 214       ER34102       215 - 216       ER34103       217 - 218  
      ER53001       219 - 219       ER53017       220 - 222       ER53030       223 - 229  
      ER53045       230 - 230       ER53048       231 - 237       ER53060       238 - 239  
      ER53065       240 - 240       ER53069       241 - 247       ER53081       248 - 249  
      ER53086       250 - 250       ER55328       251 - 252       ER56444       253 - 254  
      ER57482       255 - 256       ER57484       257 - 257       ER57599       258 - 259  
      ER57709       260 - 261       ER58223       262 - 263       ER58224       264 - 265  
      ER34201       266 - 270       ER34202       271 - 272       ER34203       273 - 274  
      ER60001       275 - 275       ER60017       276 - 278       ER60031       279 - 285  
      ER60046       286 - 286       ER60049       287 - 293       ER60061       294 - 295  
      ER60066       296 - 296       ER60070       297 - 303       ER60082       304 - 305  
      ER60087       306 - 306       ER62450       307 - 308       ER63566       309 - 310  
      ER64604       311 - 312       ER64606       313 - 313       ER64730       314 - 315  
      ER64869       316 - 317       ER65459       318 - 319       ER65460       320 - 321  
      ER34301       322 - 326       ER34302       327 - 328       ER34303       329 - 330  
 using \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\untouched\J231434.txt, clear 
;
label variable ER30000    "RELEASE NUMBER"                           ;
label variable ER30001    "1968 INTERVIEW NUMBER"                    ;
label variable ER30002    "PERSON NUMBER                         68" ;
label variable ER25001    "RELEASE NUMBER"                           ;
label variable ER25017    "AGE OF HEAD"                              ;
label variable ER25029    "A20 HOUSE VALUE"                          ;
label variable ER25039    "A23 HAVE MORTGAGE?"                       ;
label variable ER25042    "A24 REM PRINCIPAL MOR 1"                  ;
label variable ER25053    "A24 REM PRINCIPAL MOR 2"                  ;
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
label variable ER36017    "AGE OF HEAD"                              ;
label variable ER36029    "A20 HOUSE VALUE"                          ;
label variable ER36039    "A23 HAVE MORTGAGE?"                       ;
label variable ER36042    "A24 REM PRINCIPAL MOR 1"                  ;
label variable ER36054    "A24 REM PRINCIPAL MOR 2"                  ;
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
label variable ER42017    "AGE OF HEAD"                              ;
label variable ER42030    "A20 HOUSE VALUE"                          ;
label variable ER42040    "A23 HAVE MORTGAGE?"                       ;
label variable ER42043    "A24 REM PRINCIPAL MOR 1"                  ;
label variable ER42053    "A27F2 MONTHS BEHIND ON MTGE # 1"          ;
label variable ER42058    "A27F6 LIKELY TO FALL BEHIND ON MTGE #1"   ;
label variable ER42062    "A24 REM PRINCIPAL MOR 2"                  ;
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
label variable ER47317    "AGE OF HEAD"                              ;
label variable ER47330    "A20 HOUSE VALUE"                          ;
label variable ER47345    "A23 HAVE MORTGAGE?"                       ;
label variable ER47348    "A24 REM PRINCIPAL MOR 1"                  ;
label variable ER47360    "A27B MONTHS BEHIND ON MTGE # 1"           ;
label variable ER47365    "A27G LIKELY TO FALL BEHIND ON MTGE #1"    ;
label variable ER47369    "A24 REM PRINCIPAL MOR 2"                  ;
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
label variable ER53017    "AGE OF HEAD"                              ;
label variable ER53030    "A20 HOUSE VALUE"                          ;
label variable ER53045    "A23 HAVE MORTGAGE?"                       ;
label variable ER53048    "A24 REM PRINCIPAL MOR 1"                  ;
label variable ER53060    "A27B MONTHS BEHIND ON MTGE # 1"           ;
label variable ER53065    "A27G LIKELY TO FALL BEHIND ON MTGE #1"    ;
label variable ER53069    "A24 REM PRINCIPAL MOR 2"                  ;
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
label variable ER60017    "AGE OF HEAD"                              ;
label variable ER60031    "A20 HOUSE VALUE"                          ;
label variable ER60046    "A23 HAVE MORTGAGE?"                       ;
label variable ER60049    "A24 REM PRINCIPAL MOR 1"                  ;
label variable ER60061    "A27B MONTHS BEHIND ON MTGE # 1"           ;
label variable ER60066    "A27G LIKELY TO FALL BEHIND ON MTGE #1"    ;
label variable ER60070    "A24 REM PRINCIPAL MOR 2"                  ;
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

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\personal_psid_raw.dta,replace ;
