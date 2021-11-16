/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning individual level data
Last Updated: 7/20/21

*/

clear
do "$path/psid_cleanup/workflow/Raw/IND2019ER.do"


// save 1968 famidpns and each year's interview and sequence number for merging with family data 

***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000) + pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	
*interview number
	rename ER33601 int_num2001
	rename ER33701 int_num2003
	rename ER33801 int_num2005
	rename ER33901 int_num2007
	rename ER34001 int_num2009
	rename ER34101 int_num2011
	rename ER34201 int_num2013
	rename ER34301 int_num2015
	rename ER34501 int_num2017
	rename ER34701 int_num2019

*sequence number 
	rename ER33602 seq_num2001
	rename ER33702 seq_num2003
	rename ER33802 seq_num2005
	rename ER33902 seq_num2007
	rename ER34002 seq_num2009
	rename ER34102 seq_num2011
	rename ER34202 seq_num2013
	rename ER34302 seq_num2015
	rename ER34502 seq_num2017
	rename ER34702 seq_num2019
	
* Age of individual 
	rename ER33804 age2005
	rename ER33904 age2007
	rename ER34004 age2009
	rename ER34104 age2011
	rename ER34204 age2013
	rename ER34305 age2015
	rename ER34504 age2017
	rename ER34704 age2019
	
* Sex of individual 
	rename ER32000 sex
	
* Weights 
	rename ER33848 ind_weight2005
	rename ER33950 ind_weight2007
	rename ER34045 ind_weight2009
	rename ER34154 ind_weight2011
	rename ER34268 ind_weight2013
	rename ER34413 ind_weight2015
	rename ER34650 ind_weight2017
	rename ER34863 ind_weight2019
	
	*rename ER33848 ind_long_weight2005
	rename ER33849 ind_cross_weight2005
	*rename ER33950 ind_long_weight2007
	rename ER33951 ind_cross_weight2007
	*rename ER34045 ind_long_weight2009
	rename ER34046 ind_cross_weight2009
	*rename ER34154 ind_long_weight2011
	rename ER34155 ind_cross_weight2011
	*rename ER34268 ind_long_weight2013
	rename ER34269 ind_cross_weight2013
	*rename ER34413 ind_long_weight2015
	rename ER34414 ind_cross_weight2015
	*rename ER34650 ind_long_weight2017
	rename ER34651 ind_cross_weight2017
	rename ER34864 ind_cross_weight2019

	
preserve 

keep famidpn famidpns age* sex ind_weight* ind_cross_weight*

** This is for the merge with TAS
save "$path/psid_cleanup/data/raw/ind_er.dta", replace

restore

order famidpn famidpns int_num* seq_num* age*

keep famidpn famidpns int_num* seq_num* age*

* save a separate dataset that contains the int_num and seq_n for both parents and grandparents 

local list "f m ff fm mf mm"

foreach p of local list{
preserve 

rename famidpn famidpn_`p'
rename famidpns famidpns_`p'

forv i = 1(2)9{
    rename int_num200`i' int_num_`p'200`i'
	rename seq_num200`i' seq_num_`p'200`i'
}

forv i = 11(2)19{
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
	rename age2019 age_`p'2019


** This is for the merge with the parents data
save "$path/psid_cleanup/data/raw/fam_ids_int_`p'.dta", replace

restore

}
