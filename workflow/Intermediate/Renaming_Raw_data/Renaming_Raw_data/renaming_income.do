*Author: Jessica Kiser
*Date:06.19.2018
*Description: This file renames income PSID data

clear all
set more off
******************************************************************************************/

use "Y:\PSID_Jessica\data\raw\income_psid_raw.dta", clear 


***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns

	
**********************Renaming variables************************************
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
	
drop ER25011 ER36011 ER42011 ER47311 ER53011 ER60011	
drop ER27711A1 ER27711F4 ER40686A1 ER40686F4 ER40686F5 ER46665 ER46676 ER52077 ER65024
drop ER57796	

*unemployed during the previous year head	
	rename ER25306 unemp_prev_yr_2005
	rename ER36311 unemp_prev_yr_2007
	rename ER42338 unemp_prev_yr_2009
	rename ER47651 unemp_prev_yr_2011
	rename ER53351 unemp_prev_yr_2013
	rename ER60366 unemp_prev_yr_2015

*unemployed during previous year spouse
	rename ER25564 unemp_prev_yr_sp_2005
	rename ER36569 unemp_prev_yr_sp_2007
	rename ER42590 unemp_prev_yr_sp_2009
	rename ER47908 unemp_prev_yr_sp_2011
	rename ER53614 unemp_prev_yr_sp_2013
	rename ER60629 unemp_prev_yr_sp_2015
	
*unemployment duration (1-12 months) during previous year	
	rename ER25311 udur_prev_yr_2005
	rename ER36316 udur_prev_yr_2007
	rename ER42343 udur_prev_yr_2009
	rename ER47656 udur_prev_yr_2011
	rename ER53356 udur_prev_yr_2013
	rename ER60371 udur_prev_yr_2015
	
*unemployment duration (1-12 months) during previous year spouse
	rename ER25569 udur_prev_yr_sp_2005
	rename ER36574 udur_prev_yr_sp_2007
	rename ER42595 udur_prev_yr_sp_2009
	rename ER47913 udur_prev_yr_sp_2011
	rename ER53619 udur_prev_yr_sp_2013
	rename ER60634 udur_prev_yr_sp_2015

*wtr wife recieved income 2015 missing 
	rename ER26278 wife_recd_inc_2005
	rename ER37296 wife_recd_inc_2007
	rename ER43287 wife_recd_inc_2009
	rename ER48612 wife_recd_inc_2011
	rename ER54306 wife_recd_inc_2013

*wtr receieved unemployment compentation previous year head
	rename ER26165 unemp_comp_2005
	rename ER37183 unemp_comp_2007
	rename ER43174 unemp_comp_2009
	rename ER48499 unemp_comp_2011 
	rename ER54193 unemp_comp_2013
	rename ER61235 unemp_comp_2015
	
*wtr recieved workers compenstation during the previous year-head
	rename ER26181 workers_comp_2005
	rename ER37199 workers_comp_2007
	rename ER43190 workers_comp_2009
	rename ER48515 workers_comp_2011
	rename ER54209 workers_comp_2013
	rename ER61251 workers_comp_2015
	
drop ER27711F1 ER27711L4 ER27744 ER27834 ER27913 ER40686F1 ER40686L4 ER40719 ///
ER40809 ER40903 ER46673 ER46684 ER46688 ER46694 ER46811 ER52074 ER52085 ER52089 ///
ER52095 ER52219 ER57841 ER57889 ER57893 ER57899 ER58020 ER65021 ER65069 ER65073 ER65079 ER65200 ER65228	
	
drop  ER61135	
	
*wtr head recieved welfare in previous year-head 
	rename ER26083 welfare_hd_2005
	rename ER37101 welfare_hd_2007
	rename ER43092 welfare_hd_2009
	rename ER48414 welfare_hd_2011
	rename ER54092 welfare_hd_2013
	rename ER61134 welfare_hd_2015
	
*wtr head recieved income from retirement plan in previous year 
	rename ER26116 retirement_inc_hd_2005
	rename ER37134 retirement_inc_hd_2007
	rename ER43125 retirement_inc_hd_2009
	rename ER48450 retirement_inc_hd_2011
	rename ER54128 retirement_inc_hd_2013
	rename ER61170 retirement_inc_hd_2015
	
*	*wtr head recieved welfare in previous year-spouse
	rename ER26432 welfare_sp_2005
	rename ER37450 welfare_sp_2007
	rename ER43441 welfare_sp_2009
	rename ER48766 welfare_sp_2011
	rename ER54461 welfare_sp_2013
	rename ER61538 welfare_sp_2015
	
*labor income of head prev year
	rename ER27931 labor_inc_hd_2005
	rename ER40921 labor_inc_hd_2007
	rename ER46829 labor_inc_hd_2009
	rename ER52237 labor_inc_hd_2011
	rename ER58038 labor_inc_hd_2013
	rename ER65216 labor_inc_hd_2015
	
*labor income of head prev year	
	rename ER27943 labor_inc_sp_2005
	rename ER40933 labor_inc_sp_2007
	rename ER46841 labor_inc_sp_2009
	rename ER52249 labor_inc_sp_2011
	rename ER58050 labor_inc_sp_2013
	rename ER65244 labor_inc_sp_2015
	
*total family income prev year
	rename ER28037 total_fam_inc_2005
	rename ER41027 total_fam_inc_2007
	rename ER46935 total_fam_inc_2009
	rename ER52343 total_fam_inc_2011 
	rename ER58152 total_fam_inc_2013
	rename ER65349 total_fam_inc_2015
	
drop ER52066 ER57844 ER64976 ER54093 ER61364 ER61388
	
order famidpn famidpns 
save Y:\PSID_Jessica\data\raw\income_psid_renamed.dta,replace 
