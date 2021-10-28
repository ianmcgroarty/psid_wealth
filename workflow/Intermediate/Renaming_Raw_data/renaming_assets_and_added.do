*Author: Jessica Kiser
*Date:07.02.2018
*Description: This file renames asset and miscellaneous PSID data

clear all
set more off
******************************************************************************************/

use "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\assets_and_added_psid_raw.dta", clear 

***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns

	*****************renaming variables**********************
		
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
	
*
rename ER25112 beg_yrj1_2005
rename ER36117 beg_yrj1_2007
rename ER42152 beg_yrj1_2009
rename ER47464 beg_yrj1_2011
rename ER53164 beg_yrj1_2013
rename ER60179 beg_yrj1_2015

*
rename ER25175 beg_yrj2_2005
rename ER36180 beg_yrj2_2007
rename ER42213 beg_yrj2_2009
rename ER47526 beg_yrj2_2011
rename ER53226 beg_yrj2_2013
rename ER60241 beg_yrj2_2015

*
rename ER25207 beg_yrj3_2005
rename ER36212 beg_yrj3_2007
rename ER42243 beg_yrj3_2009
rename ER47556 beg_yrj3_2011
rename ER53256 beg_yrj3_2013
rename ER60271 beg_yrj3_2015

*
rename ER25239 beg_yrj4_2005
rename ER36244 beg_yrj4_2007
rename ER42273 beg_yrj4_2009
rename ER47586 beg_yrj4_2011
rename ER53286 beg_yrj4_2013
rename ER60301 beg_yrj4_2015

*
rename ER25370 beg_yrj1_sp_2005
rename ER36375 beg_yrj1_sp_2007
rename ER42404 beg_yrj1_sp_2009
rename ER47721 beg_yrj1_sp_2011
rename ER53427 beg_yrj1_sp_2013
rename ER60442 beg_yrj1_sp_2015

*
rename ER25433 beg_yrj2_sp_2005
rename ER36438 beg_yrj2_sp_2007
rename ER42465 beg_yrj2_sp_2009
rename ER47783 beg_yrj2_sp_2011
rename ER53489 beg_yrj2_sp_2013
rename ER60504 beg_yrj2_sp_2015

*
rename ER25465 beg_yrj3_sp_2005
rename ER36470 beg_yrj3_sp_2007
rename ER42495 beg_yrj3_sp_2009
rename ER47813 beg_yrj3_sp_2011
rename ER53519 beg_yrj3_sp_2013
rename ER60534 beg_yrj3_sp_2015

*
rename ER25497 beg_yrj4_sp_2005
rename ER36502 beg_yrj4_sp_2007
rename ER42525 beg_yrj4_sp_2009
rename ER47843 beg_yrj4_sp_2011
rename ER53549 beg_yrj4_sp_2013
rename ER60564 beg_yrj4_sp_2015

*
rename ER26539 value_vehicles_2005
rename ER37557 value_vehicles_2007
rename ER43548 value_vehicles_2009
rename ER48873 value_vehicles_2011
rename ER54620 value_vehicles_2013
rename ER61731 value_vehicles_2015

*
rename ER26549 value_stock_2005
rename ER37567 value_stock_2007
rename ER43558 value_stock_2009
rename ER48883 value_stock_2011
rename ER54634 value_stock_2013
rename ER61745 value_stock_2015

*
rename ER26571 ira_2005
rename ER37589 ira_2007
rename ER43580 ira_2009
rename ER48905 ira_2011
rename ER54655 ira_2013
rename ER61766 ira_2015

*
rename ER26598 bonds_2005
rename ER37616 bonds_2007
rename ER43607 bonds_2009
rename ER48932 bonds_2011
rename ER54682 bonds_2013
rename ER61793 bonds_2015

*
rename ER26535 profit_otr_real_estate_2005
rename ER37553 profit_otr_real_estate_2007
rename ER43544 profit_otr_real_estate_2009
rename ER48869 profit_otr_real_estate_2011
gen profit_otr_real_estate_2013 = ER54612 - ER54616
gen profit_otr_real_estate_2015 = ER61723 - ER61727

drop ER54612 ER54616 ER61723 ER61727

*
rename ER26544 bus_profit_2005
rename ER37562 bus_profit_2007
rename ER43553 bus_profit_2009
rename ER48878 bus_profit_2011
gen bus_profit_2013 = ER54625 - ER54629
gen bus_profit_2015 = ER61736 - ER61740

drop ER54625 ER54629 ER61736 ER61740

*
rename ER26577 liq_assets_2005
rename ER37595 liq_assets_2007
rename ER43586 liq_assets_2009
rename ER48911 liq_assets_2011
rename ER54661 liq_assets_2013
rename ER61772 liq_assets_2015

save \\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data\raw\assets_and_added_psid_renamed.dta,replace 




