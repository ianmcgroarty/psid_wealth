*Author: Jessica Kiser
*Date:06.12.2018
*Description: This file renames and cleans the demographics PSID data

clear all
set more off
******************************************************************************************/

use "Y:\PSID_Jessica\data\raw\personal_psid_raw.dta", clear 

***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns

************Renaming varibales**************
*2005
	rename ER27058    weeks_hospital_hd_2005            
	rename ER27181    weeks_hospital_sp_2005           
	rename ER27237    wtr_any_fam_health_ins_2005  
	rename ER27346    relig_pref_sp_2005  // 1-catholic, 2-jewish, 8-protestant,            
	rename ER27442    relig_pref_hd_2005

*2007
	rename ER38269    weeks_hospital_hd_2007  // 1-52 actual number             
	rename ER39366    weeks_hospital_sp_2007            
	rename ER40402    psych_distress_2007     
	rename ER40409    wtr_any_fam_health_ins_2007  
	rename ER40521    relig_pref_sp_2007            
	rename ER40614    relig_pref_hd_2007 

*2009      
	rename ER42058    likely_fall_beh_mtg_1_2009  // 1-very likely, 3-somewhat likely
	                                              // 5-not likely at all 
	rename ER42077    likely_fall_beh_mtg_2_2009 
	rename ER44242    weeks_hospital_hd_2009             
	rename ER45339    weeks_hospital_sp_2009            
	rename ER46375    psych_distress_2009     
	rename ER46382    wtr_any_fam_health_ins_2009  
	rename ER46498    relig_pref_sp_2009             
	rename ER46592    relig_pref_hd_2009 

*2011           
	rename ER47365    likely_fall_beh_mtg_1_2011              
	rename ER47386    likely_fall_beh_mtg_2_2011   
	rename ER49580    weeks_hospital_hd_2011            
	rename ER50698    weeks_hospital_sp_2011           
	rename ER51736    psych_distress_2011      
	rename ER51743    wtr_any_fam_health_ins_2011  
	rename ER51859    relig_pref_sp_2011              
	rename ER51953    relig_pref_hd_2011   

*2013         
	rename ER53065    likely_fall_beh_mtg_1_2013            
	rename ER53086    likely_fall_beh_mtg_2_2013   
	rename ER55328    weeks_hospital_hd_2013             
	rename ER56444    weeks_hospital_sp_2013             
	rename ER57482    psych_distress_2013      
	rename ER57484    wtr_any_fam_health_ins_2013   
	rename ER57599    relig_pref_sp_2013              
	rename ER57709    relig_pref_hd_2013  

*2015
	rename ER60066    likely_fall_beh_mtg_1_2015             
	rename ER60087    likely_fall_beh_mtg_2_2015   
	rename ER62450    weeks_hospital_hd_2015              
	rename ER63566    weeks_hospital_sp_2015           
	rename ER64604    psych_distress_2015     
	rename ER64606    wtr_any_fam_health_ins_2015   
	rename ER64730    relig_pref_sp_2015             
	rename ER64869    relig_pref_hd_2015  

	
*sequence number 
	rename ER33802 seq_num_2005
	rename ER33902 seq_num_2007
	rename ER34002 seq_num_2009
	rename ER34102 seq_num_2011
	rename ER34202 seq_num_2013
	rename ER34302 seq_num_2015
	
*interview number
	rename ER33801 int_num_2005
	rename ER33901 int_num_2007
	rename ER34001 int_num_2009
	rename ER34101 int_num_2011
	rename ER34201 int_num_2013
	rename ER34301 int_num_2015
	
*release number
	rename ER30000 release_all
	rename ER25001 release_2005
	rename ER36001 release_2007
	rename ER42001 release_2009
	rename ER47301 release_2011
	rename ER53001 release_2013
	rename ER60001 release_2015

drop ER25017 ER36017 ER42017 ER47317 ER53017 ER25029 ER25039 ER36029 ER36039                      
drop ER42030 ER42040 ER47330 ER47345 ER53030 ER53045 ER53069 ER53048 ER47369 ER47348                 
drop ER42043 ER42062 ER36042 ER36054 ER25053 ER25042 ER42053 ER42072 ER47360            
drop ER47381 ER53060 ER53081 ER60061 ER60082 ER65459 ER65460 ER58223 ER58224  
drop ER52405 ER52406 ER46981 ER46982 ER41037 ER41038 ER28047 ER28048 ER60017
drop ER60031 ER60046 ER60049 ER60070 ER33803 ER33903 ER34003
drop ER34103 ER34203 ER34303


