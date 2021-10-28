*Author: Jessica Kiser
*Date:06.06.2018
*Description: This file renames and cleans the demographics PSID data

clear all
set more off
******************************************************************************************/

use "Y:\PSID_Jessica\data\raw\demographics_psid_raw.dta", clear 


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

	
****Recoding missing**********
	recode age_* (999=.)
	recode race_exp_* (9=.) (0=.)
	recode marr_status_* (9=.) (8=.)
	recode educ_exp_* (99=.)
	recode educ_exp_sp_* (99=.)
	
*************DUMMY VARIABLES***********
***Creating a dummy variable for married
*2005
	gen married_2005 = 0
	replace married_2005 = 1 if marr_status_2005 == 1 
	replace married_2005 = . if marr_status_2005 == . 
*2007
	gen married_2007 = 0
	replace married_2007 = 1 if marr_status_2007 == 1
	replace married_2007 = . if marr_status_2007 == . 
*2009	
	gen married_2009 = 0
	replace married_2009 = 1 if marr_status_2009 == 1 
	replace married_2009 = . if marr_status_2009 == . 
*2011	
	gen married_2011 = 0
	replace married_2011 = 1 if marr_status_2011 == 1 
	replace married_2011 = . if marr_status_2011 == . 
*2013	
	gen married_2013 = 0
	replace married_2013 = 1 if marr_status_2013 == 1 
	replace married_2013 = . if marr_status_2013 == . 
*2015	
	gen married_2015 = 0
	replace married_2015 = 1 if marr_status_2015 == 1 
	replace married_2015 = . if marr_status_2015 == . 
	
	
***Creating a categorical variable for race 
* 1 = white, 2 = black, 3 = other 
*2005
	gen race_2005 =  0
	replace race_2005 = 1 if race_exp_2005 == 1
	replace race_2005 = 2 if race_exp_2005 == 2
	replace race_2005 = 3 if race_exp_2005 >= 3  
	replace race_2005 = . if race_exp_2005 == . 

*2007
	gen race_2007 =  0
	replace race_2007 = 1 if race_exp_2007 == 1
	replace race_2007 = 2 if race_exp_2007 == 2
	replace race_2007 = 3 if race_exp_2007 >= 3  
	replace race_2007 = . if race_exp_2007 == . 

*2009
	gen race_2009 =  0
	replace race_2009 = 1 if race_exp_2009 == 1
	replace race_2009 = 2 if race_exp_2009 == 2
	replace race_2009 = 3 if race_exp_2009 >= 3  
	replace race_2009 = . if race_exp_2009 == . 

*2011
	gen race_2011 =  0
	replace race_2011 = 1 if race_exp_2011 == 1
	replace race_2011 = 2 if race_exp_2011 == 2
	replace race_2011 = 3 if race_exp_2011 >= 3  
	replace race_2011 = . if race_exp_2011 == . 

*2013
	gen race_2013 =  0
	replace race_2013 = 1 if race_exp_2013 == 1
	replace race_2013 = 2 if race_exp_2013 == 2
	replace race_2013 = 3 if race_exp_2013 >= 3  
	replace race_2013 = . if race_exp_2013 == . 

*2015
	gen race_2015 =  0
	replace race_2015 = 1 if race_exp_2015 == 1
	replace race_2015 = 2 if race_exp_2015 == 2
	replace race_2015 = 3 if race_exp_2015 >= 3  
	replace race_2015 = . if race_exp_2015 == . 

***creating categorical variable for educ of head
* 0 = less than HS, 1 = HS, 2 = 2 year college, 3 = 4 year college, 4 = Post grad
*2005	
	gen educ_2005 = 0 if educ_exp_2005 < 12 
	replace educ_2005 = 1 if educ_exp_2005 == 12
	replace educ_2005 = 2 if educ_exp_2005 == 14
	replace educ_2005 = 3 if educ_exp_2005 == 16
	replace educ_2005 = 4 if educ_exp_2005 == 17
	
*2007
	gen educ_2007 = 0 if educ_exp_2007 < 12 
	replace educ_2007 = 1 if educ_exp_2007 == 12
	replace educ_2007 = 2 if educ_exp_2007 == 14
	replace educ_2007 = 3 if educ_exp_2007 == 16
	replace educ_2007 = 4 if educ_exp_2007 == 17
	
*2009
	gen educ_2009 = 0 if educ_exp_2009 < 12 
	replace educ_2009 = 1 if educ_exp_2009 == 12
	replace educ_2009 = 2 if educ_exp_2009 == 14
	replace educ_2009 = 3 if educ_exp_2009 == 16
	replace educ_2009 = 4 if educ_exp_2009 == 17
	
*2011
	gen educ_2011 = 0 if educ_exp_2011 < 12 
	replace educ_2011 = 1 if educ_exp_2011 == 12
	replace educ_2011 = 2 if educ_exp_2011 == 14
	replace educ_2011 = 3 if educ_exp_2011 == 16
	replace educ_2011 = 4 if educ_exp_2011 == 17
	
*2013
	gen educ_2013 = 0 if educ_exp_2013 < 12 
	replace educ_2013 = 1 if educ_exp_2013 == 12
	replace educ_2013 = 2 if educ_exp_2013 == 14
	replace educ_2013 = 3 if educ_exp_2013 == 16
	replace educ_2013 = 4 if educ_exp_2013 == 17
	
*2015
	gen educ_2015 = 0 if educ_exp_2015 < 12 
	replace educ_2015 = 1 if educ_exp_2015 == 12
	replace educ_2015 = 2 if educ_exp_2015 == 14
	replace educ_2015 = 3 if educ_exp_2015 == 16
	replace educ_2015 = 4 if educ_exp_2015 == 17
	
	
****creating categorical variables for spouse educ	
*2005	
	gen educ_sp_2005 = 0 if educ_exp_sp_2005 < 12 
	replace educ_sp_2005 = 1 if educ_exp_sp_2005 == 12
	replace educ_sp_2005 = 2 if educ_exp_sp_2005 == 14
	replace educ_sp_2005 = 3 if educ_exp_sp_2005 == 16
	replace educ_sp_2005 = 4 if educ_exp_sp_2005 == 17
	
*2007
	gen educ_sp_2007 = 0 if educ_exp_sp_2007 < 12 
	replace educ_sp_2007 = 1 if educ_exp_sp_2007 == 12
	replace educ_sp_2007 = 2 if educ_exp_sp_2007 == 14
	replace educ_sp_2007 = 3 if educ_exp_sp_2007 == 16
	replace educ_sp_2007 = 4 if educ_exp_sp_2007 == 17
	
*2009
	gen educ_sp_2009 = 0 if educ_exp_sp_2009 < 12 
	replace educ_sp_2009 = 1 if educ_exp_sp_2009 == 12
	replace educ_sp_2009 = 2 if educ_exp_sp_2009 == 14
	replace educ_sp_2009 = 3 if educ_exp_sp_2009 == 16
	replace educ_sp_2009 = 4 if educ_exp_sp_2009 == 17
	
*2011
	gen educ_sp_2011 = 0 if educ_exp_sp_2011 < 12 
	replace educ_sp_2011 = 1 if educ_exp_sp_2011 == 12
	replace educ_sp_2011 = 2 if educ_exp_sp_2011 == 14
	replace educ_sp_2011 = 3 if educ_exp_sp_2011 == 16
	replace educ_sp_2011 = 4 if educ_exp_sp_2011 == 17
	
*2013
	gen educ_sp_2013 = 0 if educ_exp_sp_2013 < 12 
	replace educ_sp_2013 = 1 if educ_exp_sp_2013 == 12
	replace educ_sp_2013 = 2 if educ_exp_sp_2013 == 14
	replace educ_sp_2013 = 3 if educ_exp_sp_2013 == 16
	replace educ_sp_2013 = 4 if educ_exp_sp_2013 == 17
	
*2015
	gen educ_sp_2015 = 0 if educ_exp_sp_2015 < 12 
	replace educ_sp_2015 = 1 if educ_exp_sp_2015 == 12
	replace educ_sp_2015 = 2 if educ_exp_sp_2015 == 14
	replace educ_sp_2015 = 3 if educ_exp_sp_2015 == 16
	replace educ_sp_2015 = 4 if educ_exp_sp_2015 == 17
	
/*code for spouse having no education and not applicable bc not married are both
 0 so to correct for this I replace spouse educ as . instead of 0 if the head
 is unmarried */ 

	replace educ_sp_2005 = . if married_2005 == 0 
	replace educ_sp_2007 = . if married_2007 == 0 
	replace educ_sp_2009 = . if married_2009 == 0 
	replace educ_sp_2011 = . if married_2011 == 0 
	replace educ_sp_2013 = . if married_2013 == 0 
	replace educ_sp_2015 = . if married_2015 == 0 
	
	
	replace educ_exp_sp_2005 = . if married_2005 == 0 
	replace educ_exp_sp_2007 = . if married_2007 == 0 
	replace educ_exp_sp_2009 = . if married_2009 == 0 
	replace educ_exp_sp_2011 = . if married_2011 == 0 
	replace educ_exp_sp_2013 = . if married_2013 == 0 
	replace educ_exp_sp_2015 = . if married_2015 == 0 
	
***********formatting*************
*reshaping from wide to long // can leave this line out if want to keep wide
reshape long ///
age_ ///
sex_ ///
marr_status_ ///
married_ ///
race_exp_ ///
race_ ///
educ_exp_ ///
educ_ ///
educ_sp_ ///
educ_exp_sp_ ///
seq_num_ ///
int_num_ ///
rel_head_ ///
release_                  , i(famidpn) j (year) 

sort famidpn year 
order famidpn famidpns year
order married_, before(marr_status_)
order race_, before (race_exp_)
order educ_, before (educ_exp_)
order educ_sp_, before (educ_exp_sp_)

******************************Generating Variables********************
****dummy (flag) variables****
*divorced flad
gen divorced_flag_ = 0
replace divorced_flag_ = 1 if marr_status_ == 4 

*education flags, less than HS, just HS, some (or all of college), college grad and post
gen less_than_HS_ = 0
replace less_than_HS_ = 1 if educ_exp_ <12

gen HS_flag_ = 0
replace HS_flag_ = 1 if educ_exp_ == 12

gen some_college_flag_ = 0
replace some_college_flag_ = 1 if educ_exp_ >12 & educ_exp_ <17

gen college_grad_plus_ = 0 
replace college_grad_plus = 1 if educ_exp_ == 17

