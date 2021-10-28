*Author: Jessica Kiser
*Date:06.06.2018
*Description: This file renames demographics PSID data

clear all
set more off
******************************************************************************************/

use "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\demographics_psid_raw.dta", clear 


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
*age 
	rename 	ER25017 age_2005 
	rename	ER36017	age_2007
	rename	ER42017	age_2009	
	rename 	ER47317	age_2011
	rename 	ER53017 age_2013
	rename 	ER60017 age_2015

*sex // 1 =  male, 2 = female
	rename	ER25018	sex_2005
	rename	ER36018	sex_2007	
	rename	ER42018	sex_2009	
	rename	ER47318	sex_2011
	rename	ER53018 sex_2013
	rename	ER60018 sex_2015	

*married  
* 1 = married, 2 = never married, 3 = widowed, 4 = divorced, 5 = seperated 
	rename  ER25023 marr_status_2005
	rename	ER36023	marr_status_2007	
	rename	ER42023	marr_status_2009	
	rename 	ER47323	marr_status_2011
	rename  ER53023 marr_status_2013
	rename 	ER60024	marr_status_2015	

	
*race expanded
/* 1 = white, 2 = black, 3 = American Indian, 4 = Asian,
   5 = Pacific Islander, 7 = other */
	rename ER27393 race_exp_2005 	
	rename ER40565 race_exp_2007 
	rename ER46543 race_exp_2009 
	rename ER51904 race_exp_2011	
	rename ER57659 race_exp_2013	
	rename ER64810 race_exp_2015	
	
*education head expanded
	rename ER28047 educ_exp_2005 	
	rename ER41037 educ_exp_2007 
	rename ER46981 educ_exp_2009 
	rename ER52405 educ_exp_2011	
	rename ER58223 educ_exp_2013	
	rename ER65459 educ_exp_2015		
	
*education spouse
	rename ER28048 educ_exp_sp_2005 	
	rename ER41038 educ_exp_sp_2007 
	rename ER46982 educ_exp_sp_2009 
	rename ER52406 educ_exp_sp_2011	
	rename ER58224 educ_exp_sp_2013	
	rename ER65460 educ_exp_sp_2015		
	
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
	
*relation to head
	rename ER33803 rel_head_2005
	rename ER33903 rel_head_2007
	rename ER34003 rel_head_2009
	rename ER34103 rel_head_2011
	rename ER34203 rel_head_2013
	rename ER34303 rel_head_2015
	
*release number
	rename ER30000 release_all
	rename ER25001 release_2005
	rename ER36001 release_2007
	rename ER42001 release_2009
	rename ER47301 release_2011
	rename ER53001 release_2013
	rename ER60001 release_2015

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\demographics_psid_renamed.dta,replace 


