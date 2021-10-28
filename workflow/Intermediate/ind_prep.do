/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning individual level data
Last Updated: 5/28/21

*/

do D:/Veronika/psid_cleanup/workflow/Raw/IND2019ER.do

// save 1968 famidpns and each year's interview and sequence number for merging with family data 

***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	
*interview number
	rename ER33801 int_num2005
	rename ER33901 int_num2007
	rename ER34001 int_num2009
	rename ER34101 int_num2011
	rename ER34201 int_num2013
	rename ER34301 int_num2015
	rename ER34501 int_num2017

*sequence number 
	rename ER33802 seq_num2005
	rename ER33902 seq_num2007
	rename ER34002 seq_num2009
	rename ER34102 seq_num2011
	rename ER34202 seq_num2013
	rename ER34302 seq_num2015
	rename ER34502 seq_num2017
	
* Age of individual 
	rename ER33804 age2005
	rename ER33904 age2007
	rename ER34004 age2009
	rename ER34104 age2011
	rename ER34204 age2013
	rename ER34305 age2015
	rename ER34504 age2017
	

preserve 

keep famidpn famidpns age*

save D:/Veronika/psid_cleanup/data/raw/ind_er.dta, replace

restore

order famidpn famidpns int_num* seq_num* age*

keep famidpn famidpns int_num* seq_num* age*

* save a separate dataset that contains the int_num and seq_n for both parents and grandparents 

local list "f m ff fm mf mm"

foreach p of local list{
preserve 

rename famidpn famidpn_`p'
rename famidpns famidpns_`p'

forv i = 5(2)9{
    rename int_num200`i' int_num_`p'200`i'
	rename seq_num200`i' seq_num_`p'200`i'
}

forv i = 11(2)17{
    rename int_num20`i' int_num_`p'20`i'
	rename seq_num20`i' seq_num_`p'20`i'
}
	rename age2005 age_`p'2005
	rename age2007 age_`p'2007
	rename age2009 age_`p'2009
	rename age2011 age_`p'2011
	rename age2013 age_`p'2013
	rename age2015 age_`p'2015
	rename age2017 age_`p'2017


save D:/Veronika/psid_cleanup/data/raw/fam_ids_int_`p'.dta, replace

restore

}


// Merge this with the TAS 
	  
use D:/Veronika/psid_cleanup/data/raw/tas_fims.dta, clear 
merge m:1 famidpn using D:/Veronika/psid_cleanup/data/raw/ind_er.dta
drop if _merge == 2
drop _merge 

foreach p of local list{
merge m:1 famidpn_`p' using D:/Veronika/psid_cleanup/data/raw/fam_ids_int_`p'.dta
drop if _merge == 2
drop _merge 

}

save D:/Veronika/psid_cleanup/data/raw/tas_with_ind.dta, replace
