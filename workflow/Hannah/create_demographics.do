**********************************************************************************
*Author: Hannah Kronenberg 
*Jessica Kiser
*Date: 11.06.2017 / 05.06.2018
*Description: This file creates 
*********************************************************************************
global Data "H:\PSID\Data" 
global RAW "$Data\Raw"
global INT  "$Data\Intermediate" 
global OUT  "$Data\Output" 
global LOG  "H:\PSID\Code\logs"
global VERSION "v1"
*******************************************************
clear all
set more off
******************************************************************************************/
use "H:\PSID\Data\Raw\demographics_psid_raw.dta", clear 

	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pn

tostring famidpn, gen(famidpns)

sort famidpn


*age 
	rename 	ER25017 age_2005 
	rename	ER36017	age_2007
	rename	ER42017	age_2009	
	rename 	ER47317	age_2011
	rename 	ER53017 age_2013
	rename 	ER60017 age_2015

*sex 
	rename	ER25018	sex_2005
	rename	ER36018	sex_2007	
	rename	ER42018	sex_2009	
	rename	ER47318	sex_2011
	rename	ER53018 sex_2013
	rename	ER60018 sex_2015	

*married 
	rename  ER25023 married_2005
	rename	ER36023	married_2007	
	rename	ER42023	married_2009	
	rename 	ER47323	married_2011	
	rename 	ER60024	married_2015	

*race 
	rename ER27393 race_2005 	
	rename ER40565 race_2007 
	rename ER46543 race_2009 
	rename ER51904 race_2011	
	rename ER57659 race_2013	
	rename ER64810 race_2015	
	
*education head 
	rename ER28047 educ_2005 	
	rename ER41037 educ_2007 
	rename ER46981 educ_2009 
	rename ER52405 educ_2011	
	rename ER58223 educ_2013	
	rename ER65459 educ_2015		
	
*education spouse
	rename ER28048 educ_sp_2005 	
	rename ER41038 educ_sp_2007 
	rename ER46982 educ_sp_2009 
	rename ER52406 educ_sp_2011	
	rename ER58224 educ_sp_2013	
	rename ER65460 educ_sp_2015		
	
	
	
	
//	SEX OF HEAD
gen imale2007= (sex2007==1)
//	HEAD MARITAL STATUS
gen imarry2007=0 if married2007<8
replace imarry2007=1 if married2007==1 



	//	AGE OF HEAD (no missing values)
//	SEX OF HEAD (no missing values)
gen imale2009= (sex2009==1)
	//	HEAD MARITAL STATUS (no missing values)
gen imarry2009=0 if married2009<8 
replace imarry2009=1 if married2009==1 



****************************************
*2011 Data *****************************
****************************************

	//	AGE OF HEAD (no missing values)
	//	SEX OF HEAD (no missing values)
gen imale2011= (sex2011==1) 
	//	HEAD MARITAL STATUS (no missing values)
gen imarry2011=0 if married2011<8 
replace imarry2011=1 if married2011==1 

 //Race

****************************************
*2013 Data *****************************
****************************************;

 //	AGE OF HEAD (no missing values);
	//	SEX OF HEAD (no missing values);
gen imale2013= (sex2013==1) 
rename 	ER53023	married2013		//	HEAD MARITAL STATUS (no missing values);
gen imarry2013=0 if married2013<8 
replace imarry2013=1 if married2013==1 
*Jackie - I fixed this - delinq should be 0, not missing when there is no mortgage;

 //Race;


****************************************
*2015 Data *****************************
****************************************;
 //	AGE OF HEAD (no missing values);
//	SEX OF HEAD (no missing values);
gen imale2015= (sex2015==1) 
	//	HEAD MARITAL STATUS (no missing values);
gen imarry2015=0 if married2015<8 
replace imarry2015=1 if married2015==1 
*Jackie - I fixed this - delinq should be 0, not missing when there is no mortgage;

 //Race;


**************************************
*Missing codes
**************************************
recode age_* (999=.)

recode race_* (9=.) (0=.)
recode hed_* (99=.)

***********Now the reshape**********************************
