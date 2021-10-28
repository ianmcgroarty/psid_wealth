**********************************************************************************
*Author: Jessica Kiser
*Date: 06.12.18
*Description: This file renames all unemployment variables 
*********************************************************************************

clear all
set more off

use "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\unemploy_psid_raw", clear



***Combining famid and pnid to create a unique identifier for each observation
rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
	label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pn

tostring famidpn, gen(famidpns)

sort famidpn

************************Renaming Variables*******************
*Labor force status 
*1-working now, 2-temp laid off/leave, 3-looking for work/unemployed, 4-retired
*5-permanently disabled, 6-house keeping, 7-student, 8-"workfare"/prison 
	*2005 0 = wild code, 99 = NA
	rename ER25104 lfs1_2005   // Employment status 1st mention
	rename ER25105 lfs2_2005   // Employment status 2nd mention
	rename ER25106 lfs3_2005   // Employmnet status 3rd mention
	*2007
	rename ER36109 lfs1_2007
	rename ER36110 lfs2_2007
	rename ER36111 lfs3_2007
	*2009
	rename ER42140 lfs1_2009
	rename ER42141 lfs2_2009
	rename ER42142 lfs3_2009
	*2011
	rename ER47448 lfs1_2011
	rename ER47449 lfs2_2011
	rename ER47450 lfs3_2011
	*2013
	rename ER53148 lfs1_2013
	rename ER53149 lfs2_2013
	rename ER53150 lfs3_2013
	*2015
	rename ER60163 lfs1_2015
	rename ER60164 lfs2_2015
	rename ER60165 lfs3_2015	
*spouse labor force status
	*2005
	rename ER25362 lfs1_sp_2005
	rename ER25363 lfs2_sp_2005
	rename ER25364 lfs3_sp_2005
	*2007
	rename ER36367 lfs1_sp_2007
	rename ER36368 lfs2_sp_2007
	rename ER36369 lfs3_sp_2007
	*2009
	rename ER42392 lfs1_sp_2009
	rename ER42393 lfs2_sp_2009
	rename ER42394 lfs3_sp_2009
	*2011
	rename ER47705 lfs1_sp_2011
	rename ER47706 lfs2_sp_2011
	rename ER47707 lfs3_sp_2011		
	*2013
	rename ER53411 lfs1_sp_2013
	rename ER53412 lfs2_sp_2013
	rename ER53413 lfs3_sp_2013
	*2015
	rename ER60426 lfs1_sp_2015
	rename ER60427 lfs2_sp_2015
	rename ER60428 lfs3_sp_2015	

*prioritized
	rename ER33813 lfs_indiv_2005  // Prioritized version of employment status
	rename ER33913 lfs_indiv_2007
	rename ER34016 lfs_indiv_2009
	rename ER34116 lfs_indiv_2011
	rename ER34216 lfs_indiv_2013
	rename ER34317 lfs_indiv_2015	
	
*unemployment duration 
	rename ER25311 udur_2005   // Months unemployed 1-24 number of months 
	rename ER36316 udur_2007
	rename ER42343 udur_2009
	rename ER47656 udur_2011
	rename ER53356 udur_2013
	rename ER60371 udur_2015
	
*spouse unemployment duration 
	rename ER25569 udur_sp_2005
	rename ER36574 udur_sp_2007
	rename ER42595 udur_sp_2009
	rename ER47913 udur_sp_2011	
	rename ER53619 udur_sp_2013	
	rename ER60634 udur_sp_2015
	
*release number
	rename ER30000 release_all
	rename ER25001 release_2005
	rename ER36001 release_2007
	rename ER42001 release_2009
	rename ER47301 release_2011
	rename ER53001 release_2013
	rename ER60001 release_2015

*interview number
	rename ER33801 int_num_2005
	rename ER33901 int_num_2007
	rename ER34001 int_num_2009
	rename ER34101 int_num_2011
	rename ER34201 int_num_2013
	rename ER34301 int_num_2015
	
*seauence number 
	rename ER33802 seq_num_2005
	rename ER33902 seq_num_2007
	rename ER34002 seq_num_2009
	rename ER34102 seq_num_2011
	rename ER34202 seq_num_2013
	rename ER34302 seq_num_2015
		
		
*relation to head
	rename ER33803 rel_head_2005
	rename ER33903 rel_head_2007
	rename ER34003 rel_head_2009
	rename ER34103 rel_head_2011
	rename ER34203 rel_head_2013
	rename ER34303 rel_head_2015
	
	
order famidpn famidpns 
save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\unemployment_psid_renamed.dta,replace 
