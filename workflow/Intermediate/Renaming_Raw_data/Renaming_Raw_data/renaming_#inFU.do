*Author: Jessica Kiser
*Date:08.01.2018
*Description: This file renames demographics PSID data

clear all
set more off
******************************************************************************************/

use "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\#inFU_psid_raw.dta", clear 


***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns

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
	
	 
	rename ER25016 num_in_fam_2005
	rename ER36016 num_in_fam_2007
	rename ER42016 num_in_fam_2009
	rename ER47316 num_in_fam_2011
	rename ER53016 num_in_fam_2013
	rename ER60016 num_in_fam_2015
	
	
	rename ER25020 num_children_2005
	rename ER36020 num_children_2007
	rename ER42020 num_children_2009
	rename ER47320 num_children_2011
	rename ER53020 num_children_2013
	rename ER60021 num_children_2015
	
	save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\#inFU_psid_renamed.dta,replace 

