#delimit ;
*  PSID DATA CENTER *****************************************************
   JOBID            : 246462                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : NULL                              
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : do                                
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 121                               
   N_OF_OBSERVATIONS: 33516                             
   MAX_REC_LENGTH   : 674                               
   DATE & TIME      : July 2, 2018 @ 13:35:39
*************************************************************************
;

infix
      ER30000              1 - 1           ER30001              2 - 5           ER30002              6 - 8     
      ER25001              9 - 9           ER25112             10 - 13          ER25175             14 - 17    
      ER25207             18 - 21          ER25239             22 - 25          ER25370             26 - 29    
      ER25433             30 - 33          ER25465             34 - 37          ER25497             38 - 41    
 long ER26535             42 - 50     long ER26539             51 - 59     long ER26544             60 - 68    
 long ER26549             69 - 77     long ER26571             78 - 86     long ER26577             87 - 95    
 long ER26598             96 - 104         ER33801            105 - 109         ER33802            110 - 111   
      ER33803            112 - 113         ER36001            114 - 114         ER36117            115 - 118   
      ER36180            119 - 122         ER36212            123 - 126         ER36244            127 - 130   
      ER36375            131 - 134         ER36438            135 - 138         ER36470            139 - 142   
      ER36502            143 - 146    long ER37553            147 - 155    long ER37557            156 - 164   
 long ER37562            165 - 173    long ER37567            174 - 182    long ER37589            183 - 191   
 long ER37595            192 - 200    long ER37616            201 - 209         ER33901            210 - 214   
      ER33902            215 - 216         ER33903            217 - 218         ER42001            219 - 219   
      ER42152            220 - 223         ER42213            224 - 227         ER42243            228 - 231   
      ER42273            232 - 235         ER42404            236 - 239         ER42465            240 - 243   
      ER42495            244 - 247         ER42525            248 - 251    long ER43544            252 - 260   
 long ER43548            261 - 269    long ER43553            270 - 278    long ER43558            279 - 287   
 long ER43580            288 - 296    long ER43586            297 - 305    long ER43607            306 - 314   
      ER34001            315 - 319         ER34002            320 - 321         ER34003            322 - 323   
      ER47301            324 - 324         ER47464            325 - 328         ER47526            329 - 332   
      ER47556            333 - 336         ER47586            337 - 340         ER47721            341 - 344   
      ER47783            345 - 348         ER47813            349 - 352         ER47843            353 - 356   
 long ER48869            357 - 365    long ER48873            366 - 374    long ER48878            375 - 383   
 long ER48883            384 - 392    long ER48905            393 - 401    long ER48911            402 - 410   
 long ER48932            411 - 419         ER34101            420 - 424         ER34102            425 - 426   
      ER34103            427 - 428         ER53001            429 - 429         ER53164            430 - 433   
      ER53226            434 - 437         ER53256            438 - 441         ER53286            442 - 445   
      ER53427            446 - 449         ER53489            450 - 453         ER53519            454 - 457   
      ER53549            458 - 461    long ER54612            462 - 470    long ER54616            471 - 479   
 long ER54620            480 - 488    long ER54625            489 - 497    long ER54629            498 - 506   
 long ER54634            507 - 515    long ER54655            516 - 524    long ER54661            525 - 533   
 long ER54682            534 - 542         ER34201            543 - 547         ER34202            548 - 549   
      ER34203            550 - 551         ER60001            552 - 552         ER60179            553 - 556   
      ER60241            557 - 560         ER60271            561 - 564         ER60301            565 - 568   
      ER60442            569 - 572         ER60504            573 - 576         ER60534            577 - 580   
      ER60564            581 - 584    long ER61723            585 - 593    long ER61727            594 - 602   
 long ER61731            603 - 611    long ER61736            612 - 620    long ER61740            621 - 629   
 long ER61745            630 - 638    long ER61766            639 - 647    long ER61772            648 - 656   
 long ER61793            657 - 665         ER34301            666 - 670         ER34302            671 - 672   
      ER34303            673 - 674   
using \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\untouched\J246462.txt, clear 

;
label variable ER30000       "RELEASE NUMBER"                           ;
label variable ER30001       "1968 INTERVIEW NUMBER"                    ;
label variable ER30002       "PERSON NUMBER                         68" ;
label variable ER25001       "RELEASE NUMBER"                           ;
label variable ER25112       "BC6 BEGINNING YEAR--JOB 1"                ;
label variable ER25175       "BC6 BEGINNING YEAR--JOB 2"                ;
label variable ER25207       "BC6 BEGINNING YEAR--JOB 3"                ;
label variable ER25239       "BC6 BEGINNING YEAR--JOB 4"                ;
label variable ER25370       "DE6 BEGINNING YEAR--JOB 1"                ;
label variable ER25433       "DE6 BEGINNING YEAR--JOB 2"                ;
label variable ER25465       "DE6 BEGINNING YEAR--JOB 3"                ;
label variable ER25497       "DE6 BEGINNING YEAR--JOB 4"                ;
label variable ER26535       "W2 PROFIT IF SOLD OTR REAL ESTATE"        ;
label variable ER26539       "W6 PROFIT IF SOLD VEHICLES"               ;
label variable ER26544       "W11 PROFIT IF SOLD BUSINESS/FARM"         ;
label variable ER26549       "W16 PROFIT IF SOLD NON-IRA STOCK"         ;
label variable ER26571       "W22 VALUE OF IRA/ANNUITY"                 ;
label variable ER26577       "W28 AMT ALL ACCOUNTS"                     ;
label variable ER26598       "W34 PROFIT IF SOLD BONDS/INSURANCE"       ;
label variable ER33801       "2005 INTERVIEW NUMBER"                    ;
label variable ER33802       "SEQUENCE NUMBER                       05" ;
label variable ER33803       "RELATION TO HEAD                      05" ;
label variable ER36001       "RELEASE NUMBER"                           ;
label variable ER36117       "BC6 BEGINNING YEAR--JOB 1"                ;
label variable ER36180       "BC6 BEGINNING YEAR--JOB 2"                ;
label variable ER36212       "BC6 BEGINNING YEAR--JOB 3"                ;
label variable ER36244       "BC6 BEGINNING YEAR--JOB 4"                ;
label variable ER36375       "DE6 BEGINNING YEAR--JOB 1"                ;
label variable ER36438       "DE6 BEGINNING YEAR--JOB 2"                ;
label variable ER36470       "DE6 BEGINNING YEAR--JOB 3"                ;
label variable ER36502       "DE6 BEGINNING YEAR--JOB 4"                ;
label variable ER37553       "W2 PROFIT IF SOLD OTR REAL ESTATE"        ;
label variable ER37557       "W6 PROFIT IF SOLD VEHICLES"               ;
label variable ER37562       "W11 PROFIT IF SOLD BUSINESS/FARM"         ;
label variable ER37567       "W16 PROFIT IF SOLD NON-IRA STOCK"         ;
label variable ER37589       "W22 VALUE OF IRA/ANNUITY"                 ;
label variable ER37595       "W28 AMT ALL ACCOUNTS"                     ;
label variable ER37616       "W34 PROFIT IF SOLD BONDS/INSURANCE"       ;
label variable ER33901       "2007 INTERVIEW NUMBER"                    ;
label variable ER33902       "SEQUENCE NUMBER                       07" ;
label variable ER33903       "RELATION TO HEAD                      07" ;
label variable ER42001       "RELEASE NUMBER"                           ;
label variable ER42152       "BC6 BEGINNING YEAR--JOB 1"                ;
label variable ER42213       "BC6 BEGINNING YEAR--JOB 2"                ;
label variable ER42243       "BC6 BEGINNING YEAR--JOB 3"                ;
label variable ER42273       "BC6 BEGINNING YEAR--JOB 4"                ;
label variable ER42404       "DE6 BEGINNING YEAR--JOB 1"                ;
label variable ER42465       "DE6 BEGINNING YEAR--JOB 2"                ;
label variable ER42495       "DE6 BEGINNING YEAR--JOB 3"                ;
label variable ER42525       "DE6 BEGINNING YEAR--JOB 4"                ;
label variable ER43544       "W2 PROFIT IF SOLD OTR REAL ESTATE"        ;
label variable ER43548       "W6 PROFIT IF SOLD VEHICLES"               ;
label variable ER43553       "W11 PROFIT IF SOLD BUSINESS/FARM"         ;
label variable ER43558       "W16 PROFIT IF SOLD NON-IRA STOCK"         ;
label variable ER43580       "W22 VALUE OF IRA/ANNUITY"                 ;
label variable ER43586       "W28 AMT ALL ACCOUNTS"                     ;
label variable ER43607       "W34 PROFIT IF SOLD BONDS/INSURANCE"       ;
label variable ER34001       "2009 INTERVIEW NUMBER"                    ;
label variable ER34002       "SEQUENCE NUMBER                       09" ;
label variable ER34003       "RELATION TO HEAD                      09" ;
label variable ER47301       "RELEASE NUMBER"                           ;
label variable ER47464       "BC6 BEGINNING YEAR--JOB 1"                ;
label variable ER47526       "BC6 BEGINNING YEAR--JOB 2"                ;
label variable ER47556       "BC6 BEGINNING YEAR--JOB 3"                ;
label variable ER47586       "BC6 BEGINNING YEAR--JOB 4"                ;
label variable ER47721       "DE6 BEGINNING YEAR--JOB 1"                ;
label variable ER47783       "DE6 BEGINNING YEAR--JOB 2"                ;
label variable ER47813       "DE6 BEGINNING YEAR--JOB 3"                ;
label variable ER47843       "DE6 BEGINNING YEAR--JOB 4"                ;
label variable ER48869       "W2 PROFIT IF SOLD OTR REAL ESTATE"        ;
label variable ER48873       "W6 PROFIT IF SOLD VEHICLES"               ;
label variable ER48878       "W11 PROFIT IF SOLD BUSINESS/FARM"         ;
label variable ER48883       "W16 PROFIT IF SOLD NON-IRA STOCK"         ;
label variable ER48905       "W22 VALUE OF IRA/ANNUITY"                 ;
label variable ER48911       "W28 AMT ALL ACCOUNTS"                     ;
label variable ER48932       "W34 PROFIT IF SOLD BONDS/INSURANCE"       ;
label variable ER34101       "2011 INTERVIEW NUMBER"                    ;
label variable ER34102       "SEQUENCE NUMBER                       11" ;
label variable ER34103       "RELATION TO HEAD                      11" ;
label variable ER53001       "RELEASE NUMBER"                           ;
label variable ER53164       "BC6 BEGINNING YEAR--JOB 1"                ;
label variable ER53226       "BC6 BEGINNING YEAR--JOB 2"                ;
label variable ER53256       "BC6 BEGINNING YEAR--JOB 3"                ;
label variable ER53286       "BC6 BEGINNING YEAR--JOB 4"                ;
label variable ER53427       "DE6 BEGINNING YEAR--JOB 1"                ;
label variable ER53489       "DE6 BEGINNING YEAR--JOB 2"                ;
label variable ER53519       "DE6 BEGINNING YEAR--JOB 3"                ;
label variable ER53549       "DE6 BEGINNING YEAR--JOB 4"                ;
label variable ER54612       "W2A WORTH OF OTR REAL ESTATE"             ;
label variable ER54616       "W2B AMT OWED ON OTR REAL ESTATE"          ;
label variable ER54620       "W6 PROFIT IF SOLD VEHICLES"               ;
label variable ER54625       "W11A WORTH OF FARM OR BUSINESS"           ;
label variable ER54629       "W11B AMT OWED ON FARM OR BUSINESS"        ;
label variable ER54634       "W16 PROFIT IF SOLD NON-IRA STOCK"         ;
label variable ER54655       "W22 VALUE OF IRA/ANNUITY"                 ;
label variable ER54661       "W28 AMT ALL ACCOUNTS"                     ;
label variable ER54682       "W34 PROFIT IF SOLD BONDS/INSURANCE"       ;
label variable ER34201       "2013 INTERVIEW NUMBER"                    ;
label variable ER34202       "SEQUENCE NUMBER                       13" ;
label variable ER34203       "RELATION TO HEAD                      13" ;
label variable ER60001       "RELEASE NUMBER"                           ;
label variable ER60179       "BC6 BEGINNING YEAR--JOB 1"                ;
label variable ER60241       "BC6 BEGINNING YEAR--JOB 2"                ;
label variable ER60271       "BC6 BEGINNING YEAR--JOB 3"                ;
label variable ER60301       "BC6 BEGINNING YEAR--JOB 4"                ;
label variable ER60442       "DE6 BEGINNING YEAR--JOB 1"                ;
label variable ER60504       "DE6 BEGINNING YEAR--JOB 2"                ;
label variable ER60534       "DE6 BEGINNING YEAR--JOB 3"                ;
label variable ER60564       "DE6 BEGINNING YEAR--JOB 4"                ;
label variable ER61723       "W2A WORTH OF OTR REAL ESTATE"             ;
label variable ER61727       "W2B AMT OWED ON OTR REAL ESTATE"          ;
label variable ER61731       "W6 PROFIT IF SOLD VEHICLES"               ;
label variable ER61736       "W11A WORTH OF FARM OR BUSINESS"           ;
label variable ER61740       "W11B AMT OWED ON FARM OR BUSINESS"        ;
label variable ER61745       "W16 PROFIT IF SOLD NON-IRA STOCK"         ;
label variable ER61766       "W22 VALUE OF IRA/ANNUITY"                 ;
label variable ER61772       "W28 AMT ALL ACCOUNTS"                     ;
label variable ER61793       "W34 PROFIT IF SOLD BONDS/INSURANCE"       ;
label variable ER34301       "2015 INTERVIEW NUMBER"                    ;
label variable ER34302       "SEQUENCE NUMBER                       15" ;
label variable ER34303       "RELATION TO HEAD                      15" ;

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\assets_and_added_psid_raw.dta,replace ;
