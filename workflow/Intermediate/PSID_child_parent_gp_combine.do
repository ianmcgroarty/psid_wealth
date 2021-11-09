/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning crosswalk files, merging them with TAS 
Last Updated: 5/25/21

*/

STOP THIS FILE HAS BEEN RETIRED PSID_child_parent_gp_combine

*******************************
*******************************
** FIMS mapping parent-child **
*******************************
*******************************

clear

do "$path/psid_cleanup/workflow/Raw/fim11418_gid_BA_2_UBL_wide.do" 


* Individual ID for person in question
rename ER30001 famid
label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pnid
tostring famidpn, gen(famidpns)
sort famidpn
order famidpn famidpns

* Find father, use bio father if individual has both 
egen fam_father = rowmax(ER30001_P_AF ER30001_P_F)
replace fam_father = ER30001_P_F if ER30001_P_AF != . & ER30001_P_F != .

egen pn_father = rowmax(ER30002_P_AF ER30002_P_F)
replace pn_father = ER30002_P_F if ER30002_P_AF != . & ER30002_P_F != .

gen famidpn_f  = (fam_father*1000)+ pn_father
tostring famidpn_f, gen(famidpns_f)

* Find mother, use bio mother if individual has both  
egen fam_mother = rowmax(ER30001_P_AM ER30001_P_M)
replace fam_mother = ER30001_P_M if ER30001_P_AM != . & ER30001_P_M != .

egen pn_mother = rowmax(ER30002_P_AM ER30002_P_M)
replace pn_mother = ER30002_P_M if ER30002_P_AM != . & ER30002_P_M != .

gen famidpn_m  = (fam_mother*1000)+ pn_mother
tostring famidpn_m, gen(famidpns_m)
	
keep famidpns famidpn_f famidpn_m

save "$path/psid_cleanup/data/raw/parent_child_old.dta", replace 
sort famidpn_f

*******************************
*******************************
** FIMS mapping grandparents **
*******************************
*******************************
* drop grandparent if 800+
clear

do "$path/psid_cleanup/workflow/Raw/fim11421_gid_BA_3_UBL_wide.do" 

* Individual ID for person in question
rename ER30001 famid
label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pnid
tostring famidpn, gen(famidpns)
sort famidpn
order famidpn famidpns

* Map out possibilities for grandparents. There are no duplicates
* Mother's mother
egen fam_mm = rowmax(ER30001_GP_MM ER30001_GP_MAM ER30001_GP_AMM ER30001_GP_AMAM)
egen pn_mm = rowmax(ER30002_GP_MM ER30002_GP_MAM ER30002_GP_AMM ER30002_GP_AMAM)

gen famidpn_mm  = (fam_mm*1000)+ pn_mm
tostring famidpn_mm, gen(famidpns_mm)

* Mother's father 
egen fam_mf = rowmax(ER30001_GP_MF ER30001_GP_MAF ER30001_GP_AMF ER30001_GP_AMAF)
egen pn_mf = rowmax(ER30002_GP_MF ER30002_GP_MAF ER30002_GP_AMF ER30002_GP_AMAF)

gen famidpn_mf  = (fam_mf*1000)+ pn_mf
tostring famidpn_mf, gen(famidpns_mf)

* Father's mother 
egen fam_fm = rowmax(ER30001_GP_FM ER30001_GP_FAM ER30001_GP_AFM ER30001_GP_AFAM)
egen pn_fm = rowmax(ER30002_GP_FM ER30002_GP_FAM ER30002_GP_AFM ER30002_GP_AFAM)

gen famidpn_fm  = (fam_fm*1000)+ pn_fm
tostring famidpn_fm, gen(famidpns_fm)

* Father's father
egen fam_ff = rowmax(ER30001_GP_FF ER30001_GP_FAF ER30001_GP_AFF ER30001_GP_AFAF)
egen pn_ff = rowmax(ER30002_GP_FF ER30002_GP_FAF ER30002_GP_AFF ER30002_GP_AFAF)

gen famidpn_ff  = (fam_ff*1000)+ pn_ff
tostring pn_ff, gen(famidpns_ff)
 
order famidpns famidpn_mm famidpn_mf famidpn_fm famidpn_ff
keep famidpns famidpn_mm famidpn_mf famidpn_fm famidpn_ff

save "$path/psid_cleanup/data/raw/grandparent_child_old.dta", replace 

***************************************
***************************************
** COMBINE CROSS-GENERATION DATASETS ** 
***************************************
***************************************

* Step 1: merge wide TAS with parent-child and gp-child identifiers on child ID
use "$path/psid_cleanup/data/raw/tas_psid_renamed.dta", clear

merge 1:1 famidpns using "$path/psid_cleanup/data/raw/parent_child_old.dta"

// Note there's a weird child ID without a match 
drop if _merge == 2
drop _merge 

merge 1:1 famidpns using "$path/psid_cleanup/data/raw/grandparent_child_old.dta"

// We expect more unmatched grandchildren here. That's fine. 
drop if _merge ==2
drop _merge 

save "$path/psid_cleanup/data/raw/tas_fims_old.dta", replace
