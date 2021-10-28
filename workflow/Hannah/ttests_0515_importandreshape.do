#delimit ;
/*  PSID DATA CENTER *****************************************************
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
;*/

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
using  "\\c1resp2\SRC Shared\PSID_mtge_demo\Data\Untouched\J231434.txt", clear ;


rename ER27058    weeks_hospital_hd_2005            
rename ER27181    weeks_hospital_sp_2005           
rename ER27237    wtr_any_fam_health_ins_2005  
rename ER27346    relig_pref_sp_2005             
rename ER27442    relig_pref_hd_2005 "              
rename ER28047    completed_ed_hd_2005                        
rename ER28048    completed_ed_sp_2005                           


rename ER38269    weeks_hospital_hd_2007              
rename ER39366    weeks_hospital_sp_2007            
rename ER40402    psych_distress_2007     
rename ER40409    wtr_any_fam_health_ins_2007  
rename ER40521    relig_pref_sp_2007            
rename ER40614    relig_pref_hd_2007            
rename ER41037    completed_ed_hd_2007                         
rename ER41038    completed_ed_sp_2007                          


rename ER42053    months_behind_mtge_1_2009        
rename ER42058    likely_fall_beh_mtg_1_2009   
rename ER42072    months_behind_mtge_2_2009           
rename ER42077    likely_fall_beh_mtg_2_2009 
rename ER44242    weeks_hospital_hd_2009             
rename ER45339    weeks_hospital_sp_2009            
rename ER46375    psych_distress_2009     
rename ER46382    wtr_any_fam_health_ins_2009  
rename ER46498    relig_pref_sp_2009             
rename ER46592    relig_pref_hd_2009         
rename ER46981    completed_ed_hd_2009                        
rename ER46982    completed_ed_sp_2009                         



rename ER47360    months_behind_mtge_1_2011           
rename ER47365    likely_fall_beh_mtg_1_2011   
rename ER47381    months_behind_mtge_2_2011           
rename ER47386    likely_fall_beh_mtg_2_2011   
rename ER49580    weeks_hospital_hd_2011            
rename ER50698    weeks_hospital_sp_2011           
rename ER51736    psych_distress_2011      
rename ER51743    wtr_any_fam_health_ins_2011  
rename ER51859    relig_pref_sp_2011              
rename ER51953    relig_pref_hd_2011             
rename ER52405    completed_ed_hd_2011                       
rename ER52406    completed_ed_sp_2011                          


rename ER53060    months_behind_mtge_1_2013           
rename ER53065    likely_fall_beh_mtg_1_2013   
rename ER53081    months_behind_mtge_2_2013           
rename ER53086    likely_fall_beh_mtg_2_2013   
rename ER55328    weeks_hospital_hd_2013             
rename ER56444    weeks_hospital_sp_2013             
rename ER57482    psych_distress_2013      
rename ER57484    wtr_any_fam_health_ins_2013   
rename ER57599    relig_pref_sp_2013              
rename ER57709    relig_pref_hd_2013             
rename ER58223    completed_ed_hd_2013                        
rename ER58224    completed_ed_sp_2013                          


rename ER60061    months_behind_mtge_1_2015         
rename ER60066    likely_fall_beh_mtg_1_2015   
rename ER60082    months_behind_mtge_2_2015           
rename ER60087    likely_fall_beh_mtg_2_2015   
rename ER62450    weeks_hospital_hd_2015              
rename ER63566    weeks_hospital_sp_2015           
rename ER64604    psych_distress_2015     
rename ER64606    wtr_any_fam_health_ins_2015   
rename ER64730    relig_pref_sp_2015             
rename ER64869    relig_pref_hd_2015             
rename ER65459    completed_ed_hd_2015                          
rename ER65460    completed_ed_sp_2015                        

rename  ER25017     age_head_2005                              
rename  ER36017    age_head_2007                               
rename  ER42017    age_head_2009                             
rename  ER47317    age_head_2011                             
rename  ER53017    age_head_2013                             
rename  ER25029    house_value_2005                          
rename  ER25039    have_mtge_2005                      
rename  ER36029    house_value_2007                         
rename  ER36039    have_mtge_2007                     
rename  ER42030    house_value_2009                          
rename  ER42040    have_mtge_2009                       
rename  ER47330    house_value_2011                          
rename  ER47345    have_mtge_2011                       
rename  ER53030    house_value_2013                         
rename  ER53045    have_mtge_2013                      
rename  ER53069    rem_princ_mtge_2_2013                  
rename  ER53048    rem_princ_mtge_1_2013                 
rename  ER47369    rem_princ_mtge_2_2011                 
rename  ER47348    rem_princ_mtge_1_2011                 
rename  ER42043    rem_princ_mtge_1_2009                  
rename  ER42062    rem_princ_mtge_2_2009                 
rename  ER36042    rem_princ_mtge_1_2007                  
rename  ER36054    rem_princ_mtge_2_2007                  
rename  ER25053    rem_princ_mtge_2_2005                  
rename  ER25042    rem_princ_mtge_1_2005                  



rename ER60017 age_head_2015
rename ER60031 house_value_2015 
rename ER60046 have_mtge_2015 
rename ER60049 rem_princ_mtge_1_2015 
rename ER60070 rem_princ_mtge_2_2015



*identifiers*
rename ER30001 famid 
label var famid "unique family id #, for each family from 1968"  
rename ER30002 pnid
label var pnid "unique person #, for each individual"
gen famidpn  = (famid*1000)+ pn
tostring famidpn, gen(famidpns)
sort famidpn


drop ER*


save  "\\c1resp2\SRC Shared\PSID_mtge_demo\Data\Raw\ttests_05_15.dta", replace
******************next code is the reshape*******************
set more off

reshape long /// 
age_head_ /// 
house_value_  /// 
have_mtge_  /// 
rem_princ_mtge_1_  /// 
rem_princ_mtge_2_ ///
months_behind_mtge_1_         /// 
likely_fall_beh_mtg_1_  /// 
months_behind_mtge_2_           /// 
likely_fall_beh_mtg_2_ /// 
weeks_hospital_hd_             /// 
weeks_hospital_sp_         /// 
psych_distress_ /// 
wtr_any_fam_health_ins_  /// 
relig_pref_sp_            /// 
relig_pref_hd_             /// 
completed_ed_hd_                        /// 
completed_ed_sp_                       , i(famidpn) j(year)

save  "\\c1resp2\SRC Shared\PSID_mtge_demo\Data\Raw\ttests_05_15.dta", replace



















