clear 

global path "D:/Ian"

*do "$path/psid_cleanup/workflow/Raw/MX19REL.do" 


*************************************************************
// Load in Parent Identification file with the RAW file provided by PSID 
*************************************************************
cap frame change default 
clear
do "$path/psid_cleanup/workflow/Raw/PID19.do" 
rename PID2 famid
rename PID3 pnid
rename PID4 ER30001_P_M2
rename PID5 ER30002_P_M2
rename PID6 ER30001_P_AM2
rename PID7 ER30002_P_AM2 
rename PID8 ER30001_P_AM2_2
rename PID9 ER30002_P_AM2_2

rename PID23 ER30001_P_F2 
rename PID24 ER30002_P_F2
rename PID25 ER30001_P_AF2 
rename PID26 ER30002_P_AF2
rename PID27 ER30001_P_AF2_2
rename PID28 ER30002_P_AF2_2


tempfile pid_data
save `pid_data'


/*************************************************************
// Validate against Veronika's work 
	** NOTE, I don't know how to replicate this file now that PSID has updated
	** to the 2019 data. So you'll have to use the one provided by Vonk. 
*************************************************************
cap frame drop validate
cap frame create validate
frame change validate 

clear
do "$path/psid_cleanup/workflow/Raw/fim11418_gid_BA_2_UBL_wide.do" 

* Individual ID for person in question
rename ER30001 famid
label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
label var pnid "unique person #, for each individual"


*frlink 1:1 famid pnid, frame(pid)
merge 1:1 famid pnid using `pid_data'
count if ER30001_P_M2 != ER30001_P_M  & ER30001_P_M != . 
count if ER30001_P_F2 != ER30001_P_F  & ER30001_P_F != . 


*************************************************************
// Create Parent idenifiers 
*************************************************************/
cap frame change default 

// Person id variable 
	gen famidpn  = (famid*1000)+ pnid
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns

// Find father, use bio father if individual has both , no preference for adopted parent if 2
	egen fam_father = rowmax(ER30001_P_AF2_2 ER30001_P_AF2 ER30001_P_F2)
		replace fam_father = ER30001_P_F2 if ER30001_P_AF2 != 0 & ER30001_P_F2 != 0
		replace fam_father = ER30001_P_F2 if ER30001_P_AF2_2 != 0 & ER30001_P_F2 != 0

	egen pn_father = rowmax(ER30001_P_AF2_2 ER30002_P_AF2 ER30002_P_F2)
		replace pn_father = ER30002_P_F2 if ER30002_P_AF2 != 0 & ER30002_P_F2 != 0
		replace pn_father = ER30002_P_F2 if ER30002_P_AF2_2 != 0 & ER30002_P_F2 != 0

	gen famidpn_f  = (fam_father*1000)+ pn_father
	tostring famidpn_f, gen(famidpns_f)

//  Find mother, use bio mother if individual has both , no preference for adopted parent if 2
	egen fam_mother = rowmax(ER30001_P_AM2_2 ER30001_P_AM2 ER30001_P_M2)
		replace fam_mother = ER30001_P_M2 if ER30001_P_AM2 != 0 & ER30001_P_M2 != 0
		replace fam_mother = ER30001_P_M2 if ER30001_P_AM2_2 != 0 & ER30001_P_M2 != 0

	egen pn_mother = rowmax(ER30002_P_AM2_2 ER30002_P_AM2 ER30002_P_M2)
		replace pn_mother = ER30002_P_M2 if ER30002_P_AM2 != 0 & ER30002_P_M2 != 0
		replace pn_mother = ER30002_P_M2 if ER30002_P_AM2_2 != 0 & ER30002_P_M2 != 0

	gen famidpn_m  = (fam_mother*1000)+ pn_mother
	tostring famidpn_m, gen(famidpns_m)
	
keep famidpns famidpns_f famidpns_m
save "$path/psid_cleanup/data/raw/parent_child.dta", replace 


*************************************************************
// Create Grand-Parent idenifiers 
	** NOTE: I'm not sure what Vonk did, where her other file came from
	** but this should work, since we have individual and parents. 
*************************************************************


// For the FATHER'S parents 
	use "$path/psid_cleanup/data/raw/parent_child.dta", clear
	
	rename famidpns grandchild
	rename famidpns_f famidpns 
	rename famidpns_m mother 
		
	// merge using the father as the identifier 
	merge m:1 famidpns using "$path/psid_cleanup/data/raw/parent_child.dta"
		drop if _merge == 2 
			/* these are people who we don't have grandparent identifcation for (e.g. famidpn is the grandparent) */
			drop _merge 

	rename famidpns_f famidpns_ff
	rename famidpns_m famidpns_fm
	rename famidpns father 
	
	replace famidpns_ff = "" if father == "0"
	replace famidpns_fm = "" if father  == "0"
	
// For the MOTHER'S parents
	rename mother famidpns
	
	// merge using the Mother as the identifier 
	merge m:1 famidpns using "$path/psid_cleanup/data/raw/parent_child.dta"
		drop if _merge == 2 
			/* these are people who we don't have grandparent identifcation for (e.g. famidpn is the grandparent) */
			drop _merge 

	rename famidpns_f famidpns_mf
	rename famidpns_m famidpns_mm
	rename famidpns mother 
	
	
	replace famidpns_mf = "" if mother == "0"
	replace famidpns_mm = "" if mother == "0"
	
// Checkpoint
	rename grandchild famidpns 
	rename mother famidpns_m
	rename father famidpns_f
	sort famidpns
	
	bysort famidpns_m: gen dup = cond(_N==1, 0, _n)
	*br if dup != 0 
	drop dup 
	
	
save "$path/psid_cleanup/data/raw/grandparent_child.dta", replace 

/*************************************************************
// Validate against Veronika's work grandparents 
	** NOTE, I don't know how to replicate this file now that PSID has updated
	** to the 2019 data. So you'll have to use the one provided by Vonk. 
*************************************************************

cap frame create validate
frame change validate 

// Prepare veronika's version laid out in "PSID_child_parent_gp_combine.do"
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
	tostring famidpn_ff, gen(famidpns_ff)
	 
	order famidpns famidpn_mm famidpn_mf famidpn_fm famidpn_ff
	keep famidpns famidpns_mm famidpns_mf famidpns_fm famidpns_ff
	
	
	rename * *_old 
	rename famidpns_old famidpns 

// Merge in my version  
	merge 1:1 famidpns using "$path/psid_cleanup/data/raw/grandparent_child.dta"
	drop if _merge == 2

	replace famidpns_mm_old = "" if famidpns_mm_old == "."
	replace famidpns_mf_old = "" if famidpns_mf_old == "."
	replace famidpns_ff_old = "" if famidpns_ff_old == "."
	replace famidpns_fm_old = "" if famidpns_fm_old == "."

	replace famidpns_mm_old = "" if famidpns_mm_old == "0"
	replace famidpns_mf_old = "" if famidpns_mf_old == "0"
	replace famidpns_ff_old = "" if famidpns_ff_old == "0"
	replace famidpns_fm_old = "" if famidpns_fm_old == "0"

	replace famidpns_mm = "" if famidpns_mm == "0"
	replace famidpns_mf = "" if famidpns_mf == "0"
	replace famidpns_ff = "" if famidpns_ff == "0"
	replace famidpns_fm = "" if famidpns_fm == "0"

	gen flag = .
		replace flag = 1 if famidpns_mm_old != famidpns_mm 

	count if famidpns_mm_old != famidpns_mm 
	count if famidpns_mf_old != famidpns_mf
	count if famidpns_ff_old != famidpns_ff
	count if famidpns_fm_old != famidpns_fm
	
	order famidpns famidpns_m famidpns_mm famidpns_mm_old famidpns_fm famidpns_fm_old famidpns_mf famidpns_mf_old famidpns_ff famidpns_ff_old

	** conclusion: 
		** There are a couple mismatches but all in all I think I did alright. Plus there are way more grandparent data. 
		** AND as we see below, no child doesn't have a match. 


*************************************************************
// Merge with TAS Data 
*************************************************************/
frame change default 


use "$path/psid_cleanup/data/raw/tas_psid_renamed.dta", clear
merge 1:1 famidpns using  "$path/psid_cleanup/data/raw/grandparent_child.dta"
	drop if _merge == 2 
		** These are just the people not in TAS
	drop _merge 
	
save "$path/psid_cleanup/data/raw/tas_fims.dta", replace
	
