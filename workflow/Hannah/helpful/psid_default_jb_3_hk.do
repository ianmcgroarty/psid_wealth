********************************************************************
*Jackie September 25, 2013
*Hannah Kronenberg September 2017
*PSID Default Paper - cleaning the vars after the reshape
********************************************************************
********************************************************
clear
set more off


*********************************************************************************
global Data "\\c1resp2\SRC Shared\PSID_mtge_demo\September_V1\Data" 
global RAW "$Data\Raw"
global INT  "$Data\Intermediate" 
global OUT  "$Data\Output" 
global LOG  "\\c1resp2\SRC Shared\PSID_mtge_demo\September_V1\Code\logs"
*******************************************************
log using "$LOG/psid_default_jb_3_hk_log.smcl", text replace 

use "$RAW\psid_jb2_hk.dta", replace

*format interview dates*
gen riym = ym(riy_, rim_)

*******************************************************************
*Data manipulation once the file was reshaped*
*******************************************************************

*some years don't have mort_ *
replace mort_ = 1 if mort_ ==. &  pr_ > 0 & pr_ < .
replace mort_ = 0 if mort_ ==. &  pr_ == 0 

gen i_fc= (fc_==1) 
replace i_fc =. if fc_==.
label var i_fc "whether in foreclosure"

gen iwelf_last = (last_welfare_ == 1)
replace iwelf_last = . if last_welfare_ == .
label var iwelf_last "received welfare the year before last"

*Jackie Note - Changed to include all mortgage types*
gen imort = (mort_ == 1)
replace imort = . if mort_ == .
label var imort "have a first mortgage"

gen refi_miss= (refi_==.)
gen irefi = (refi_ ==2)

gen imtype_miss= (mtype== . | mtype==8 | mtype==9)
gen imtype= (mtype==2)
label var imtype "has a variable interest rate"

gen im2_miss= (m2_ == .)
gen im2 = (m2_==1)
label var im2_ "have a second mortgage"

gen istmort = (morttyp == 1 | morttyp == 2  | morttyp == 3 | morttyp == 4 | morttyp == 7 | morttyp == 8)
replace istmort = . if morttyp == .
destring year, replace 
replace istmort = 1 if year < 1996
label var istmort "1st mtg is not a heloc or heloan"

gen iheloc1 = (morttyp == 5)
replace iheloc1 = . if  morttyp == .
label var iheloc1 "heloc on first mortgage"

gen istmort2 = (m2type_ == 1 | m2type_ == 2 | m2type_ == 3 | m2type_ == 4 | m2type_ == 7 | m2type_ == 8)
*replace istmort2 = 0 if m2type_ == .
replace istmort2 = 1 if year < 1996
label var istmort2 "2nd mtg is not a heloc or heloan"

gen iheloc2 = (m2type_ == 5)
replace iheloc2 = . if  m2type_ == .
label var iheloc2 "heloc on second mortgage"

gen im2type = (m2typevar == 2)
replace im2type = . if m2typevar == .
label var im2type "2nd mtg has a variable interest rate"

gen invol_lossj1=(reason_endj1_==1 | reason_endj1_==2 | reason_endj1_==3) //Fired==3 or Company Folded==1
gen invol_lossj2=(reason_endj2_==1 | reason_endj2_==2 | reason_endj2_==3) //Fired==3 or Company Folded==1
gen invol_lossj3=(reason_endj3_==1 | reason_endj3_==2 | reason_endj3_==3) //Fired==3 or Company Folded==1
gen invol_lossj4=(reason_endj4_==1 | reason_endj4_==2 | reason_endj4_==3) //Fired==3 or Company Folded==1

gen invol_loss_sp_j1=(reason_endj1_sp==1 | reason_endj1_sp==2 | reason_endj1_sp==3) //Fired==3 or Company Folded==1
gen invol_loss_sp_j2=(reason_endj2_sp==1 | reason_endj2_sp==2 | reason_endj2_sp==3) //Fired==3 or Company Folded==1
gen invol_loss_sp_j3=(reason_endj3_sp==1 | reason_endj3_sp==2 | reason_endj3_sp==3) //Fired==3 or Company Folded==1
gen invol_loss_sp_j4=(reason_endj4_sp==1 | reason_endj4_sp==2 | reason_endj4_sp==3) //Fired==3 or Company Folded==1

****************************************
*Negative equity vs. Job Loss Data *
****************************************
*Jackie - changed this to include "other" types of second mortgages in the LTV too
gen i_meq_=(m2type_ >0) //Home equity, home improvement, line of credit
replace i_meq_=. if m2type_==.

gen m2pr_miss = (m2pr_ == .)
replace m2pr_=0 if m2pr_==.
gen pr_miss = (pr_ == .)
replace pr_ = 0 if pr_ == .

gen fixed = (mtype_ == 1)

gen pr_tot =((pr_*istmort) + (m2pr_*istmort2)) 
gen pr_heloc =((pr_*iheloc1) + (m2pr_*iheloc2)) 

replace pr_heloc = 0 if pr_heloc == .
gen pr_tot_heloc = pr_tot + pr_heloc

gen mpay_tot = ((mpay_+m2pay_)*12)
gen mpay_pr_tot = mpay_tot/(pr_tot_heloc)

gen mpay_pr_1 = (mpay_*12)/pr_
gen mpay_pr_2 = (m2pay_*12)/m2pr_

gen m2int_miss = (m2int_ == .)
replace m2int_ = 0 if m2int_miss == 1

*Jackie Changes - generate different iterations of CLTV - one with HELOC and one without*
gen cltv =((pr_*istmort) + (m2pr_*istmort2))/hv_ //Combined loan to value (based on self-reported house value)
gen ltv_heloc =((pr_*iheloc1) + (m2pr_*iheloc2))/hv_ //Combined loan to value (based on self-reported house value)
replace ltv_heloc = 0 if ltv_heloc == .

gen cltv_heloc = cltv + ltv_heloc



tempvar cltv_win cltv_heloc_win
winsor cltv, gen(cltv_win) p(.01)
winsor cltv_heloc, gen(cltv_heloc_win) p(.01)
replace cltv = cltv_win
replace cltv_heloc = cltv_heloc_win

*Calculate income burdens*
gen debt_miss = (debt_==.)
replace debt_ = 0 if debt_ == .
gen inc_miss = (inc_==.)
replace inc_ = 0 if inc_ == .

gen unsec_incburden =debt_/inc_ if inc_>1000 // Unsecured debt burden as a fraction of income
gen unsec_incburden_miss = (unsec_incburden ==.)
replace unsec_incburden=0 if unsec_incburden_miss==1

gen mpay_miss = (mpay_==.)
replace mpay_ = 0 if mpay_ == .
gen m2pay_miss = (m2pay_==.)
replace m2pay_=0 if m2pay_==.

gen unsec_mortburden= debt_/(mpay_+m2pay_) 
gen unsec_mortburden_miss = (unsec_mortburden==.)
replace unsec_mortburden=0 if unsec_mortburden_miss==1

gen i_30_=0 if delinq_!=. // 30-day Delinquency
replace i_30_=1 if delinq_>=1 & delinq_!=.
gen i_60_=0 if delinq_!=. // 60-day Delinquency
replace i_60_=1 if delinq_ >=2 & delinq_!=.
gen i_90_=0 if delinq_!=. // 90-day Delinquency
replace i_90_=1 if delinq_>=3 & delinq_!=.
gen i_m260_=0 if m2delinq_!=. 
replace i_m260_=1 if m2delinq_>=2 & m2delinq_!=.

***************************************************************************
*new variables created by Jackie 10/30/2013 - this is based on Kris's code
***************************************************************************
*fill in missing values for the own variable - count as own if the housing value is  > 0
replace homeowner_ = 1 if hv_ > 0 & hv_ <.
replace homeowner_ = 0 if hv_ == .

*note if ever a homeonwer, since 1968*
gen homeown_evr = 0
replace homeown_evr = 1 if homeowner_ == 1
xtset famidpn year
forval num = 1/50 {
  replace homeown_evr = 1 if l`num'.homeowner_ == 1 

      } 
label var homeown_evr "transitioned to owning before or during this yr"
***************************************************************************************
*first, purchase variables*
***************************************************************************************

/* Create dummy variable for housing tenure decision (0 - nochange, 1 - become owner, 2 - become renter) 
The distinction between pre and post 1997 has to do with the lags*/
gen tendum = 0
bysort famidpn: replace tendum = 1 if l.homeowner_==0 & homeowner_==1 & year<=1997
bysort famidpn: replace tendum = 1 if l2.homeowner_==0 & homeowner_==1 & (year>1997)
bysort famidpn: replace tendum = 2 if l.homeowner_==1 &  homeowner_==0 & year<=1997
bysort famidpn: replace tendum = 2 if l2.homeowner_==1 &  homeowner_==0 & (year>1997)

*count the number of transitions to and from homeownership and duration as a homeowner*
bysort famidpn: gen switchamt = sum(tendum==1)	
bysort famidpn: gen switchamt2 = sum(tendum==2)
bysort famidpn: gen sumown = sum(homeowner_==1)


/* Identify Home Purchases (no purchase - 0, first-time buyer - 1, everyone else - 2) */
bysort famidpn: gen firstpurch = 0
bysort famidpn: replace firstpurch = 1 if tendum==1 & l.homeown_evr == 0 & year <= 1997
bysort famidpn: replace firstpurch = 1 if tendum==1 & l2.homeown_evr == 0 & year > 1997
bysort famidpn: replace firstpurch = 1 if move==1 & homeowner_==1 & l.homeown_evr == 0 & year <= 1997
bysort famidpn: replace firstpurch = 1 if move==1 & homeowner_==1 & l2.homeown_evr == 0 & year > 1997

bysort famidpn: gen otherpurch = 0
bysort famidpn: replace otherpurch = 1 if tendum==1 & l.homeown_evr == 1 & year <=1997
bysort famidpn: replace otherpurch = 1 if tendum==1 & l2.homeown_evr == 1 & year >1997
bysort famidpn: replace otherpurch = 1 if move==1 & homeowner_==1 & l.homeown_evr == 1 & year <= 1997
bysort famidpn: replace otherpurch = 1 if move==1 & homeowner_==1 & l2.homeown_evr == 1 & year > 1997

/* Variable for number of house purchases (that we see in the sample) */

gen anypurch = (otherpurch == 1)
replace anypurch = 1 if firstpurch == 1

/* Variable for number of house purchases (that we see in the sample) */
bysort famidpn: gen numpurch = sum(anypurch)

*generate purchase years - total number of home purchases reported by these counts is 13*
gen purchyr = year if anypurch == 1

forval num = 1/13 {
egen purchyr`num' = min(purchyr) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace purchyr = purchyr`num' if numpurch == `num' & purchyr`num' != .
}
***

*generate purchase interview dates*

gen purchym = riym if anypurch == 1

forval num = 1/13 {
egen purchym`num' = min(purchym) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace purchym = purchym`num' if numpurch == `num' & purchym`num' != .
}
***


*fill in purchase prices*
gen purchp = hv_ if anypurch == 1

forval num = 1/13 {
egen purchp`num' = min(purchp) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace purchp = purchp`num' if numpurch == `num' & purchp`num' != .
}
***

gen ch_purchp = hv_ -purchp
gen pc_purchp = ln(hv_) - ln(purchp)
gen homeown_yrs = year-purchyr
gen homeown_mos = riym-purchym

gen chprice_oyrs = ch_purchp/ ((homeown_mos)/12) if (homeown_mos/12 > 1) 
replace chprice_oyrs = ch_purchp/ 1 if ((homeown_mos)/12 < 1 ) 

gen pcprice_oyrs = (pc_purchp)/ ((homeown_mos)/12) if ((homeown_mos)/12) > 1 
replace pcprice_oyrs = (pc_purchp)/ (1) if ((homeown_mos)/12) < 1 

******************************************************************************************************************
*Now work on debt variables*
******************************************************************************************************************

*fill in mortgage amounts*
gen mortp = pr_ if anypurch == 1

forval num = 1/13 {
egen mortp`num' = min(mortp) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace mortp = mortp`num' if numpurch == `num' & mortp`num' != .
}
***

*fill in 2nd mortgage amounts*
gen mort2p = m2pr_ if anypurch == 1

forval num = 1/13 {
egen mort2p`num' = min(mort2p) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace mort2p = mort2p`num' if numpurch == `num' & mort2p`num' != .
}
***

gen cltvp =((pr_*istmort)+(m2pr_*istmort2))/hv_ if anypurch == 1 //Combined loan to value (based on self-reported house value)
gen ltvp_heloc =((pr_*iheloc1) + (m2pr_*iheloc2))/hv_ if anypurch == 1 //Combined loan to value (based on self-reported house value)

forval num = 1/13 {
egen cltvp`num' = min(cltvp) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace cltvp = cltvp`num' if numpurch == `num' & cltvp`num' != .
}
***

forval num = 1/13 {
egen ltvp_heloc`num' = min(ltvp_heloc) if numpurch == `num', by(famidpn)
}
***

forval num = 1/13 {
replace ltvp_heloc = ltvp_heloc`num' if numpurch == `num' & ltvp_heloc`num' != .
}
***

replace ltvp_heloc = 0 if ltvp_heloc == .
gen cltvp_heloc = cltvp + ltvp_heloc

forval num = 1/13 {
drop purchp`num'
drop purchyr`num'
drop mortp`num'
drop cltvp`num'
drop ltvp_heloc`num'
}
***

******************************************************************************************************************
*Employment variables*
******************************************************************************************************************

*Jackie Note - this is a new employment variable based on the employment variable that takes into account all answers
*to the employment question
*Construct for the lfs vars for the wife - based on the method used for the individual:
*Employment mentions for Heads and Wives/"Wives" and OFUMS were priortized in the following order: 2,1,3,4,5,7,6,8,9.
*temporary layoff > work > unemployed > retired > disabled > student > homemaker > other
#delimit
gen lfs_indiv_sp = 2 if (lfs1_sp_ == 2 | lfs2_sp_ == 2 | lfs3_sp_ == 2)
replace lfs_indiv_sp = 1 if (lfs1_sp_ == 1 | lfs2_sp_ == 1 | lfs3_sp_ == 1) & lfs_indiv_sp == .
replace lfs_indiv_sp = 3 if (lfs1_sp_ == 3 | lfs2_sp_ == 3 | lfs3_sp_ == 3) & lfs_indiv_sp == .
replace lfs_indiv_sp = 4 if (lfs1_sp_ == 4 | lfs2_sp_ == 4 | lfs3_sp_ == 4) & lfs_indiv_sp == .
replace lfs_indiv_sp = 5 if (lfs1_sp_ == 5 | lfs2_sp_ == 5 | lfs3_sp_ == 5) & lfs_indiv_sp == .
replace lfs_indiv_sp = 7 if (lfs1_sp_ == 7 | lfs2_sp_ == 7 | lfs3_sp_ == 7) & lfs_indiv_sp == .
replace lfs_indiv_sp = 6 if (lfs1_sp_ == 6 | lfs2_sp_ == 6 | lfs3_sp_ == 6) & lfs_indiv_sp == .
replace lfs_indiv_sp = 8 if (lfs1_sp_ == 8 | lfs2_sp_ == 8 | lfs3_sp_ == 8) & lfs_indiv_sp == .

gen retired = (lfs1_ == 4 | lfs2_ == 4 | lfs3_ == 4)
gen retired_sp = (lfs1_sp == 4 | lfs2_sp == 4 | lfs3_sp == 4)

gen student = (lfs1_ == 7 | lfs2_ == 7 | lfs3_ == 7)
gen student_sp = (lfs1_sp == 7 | lfs2_sp == 7 | lfs3_sp == 7)

gen i_u_indiv =0 if lfs_indiv_ !=. //Unemployment ("unemployed" or "temporarily laid off")
replace i_u_indiv =1 if lfs_indiv_ ==2 | lfs_indiv_ ==3

gen i_u_indiv_sp =0 if lfs_indiv_sp !=. //Unemployment ("unemployed" or "temporarily laid off")
replace i_u_indiv_sp =1 if lfs_indiv_sp ==2 | lfs_indiv_sp ==3

gen i_wk_indiv_sp =0 if lfs_indiv_sp !=. 
replace i_wk_indiv_sp =1 if lfs_indiv_sp ==1 | lfs_indiv_sp == 2 | lfs_indiv_sp ==3

*need to make the job loss years consistently 4 digits
tempvar j1 j2 j3
tostring end_yrj1_, gen(`j1')
gen `j2' = "19" + `j1' if year < 2000
gen `j3' = "190" + `j1' if year < 2000
destring `j2' `j3', replace
replace end_yrj1_ = `j2' if end_yrj1_ < 100 & end_yrj1_ > 10
replace end_yrj1_ = `j3' if end_yrj1_ < 10 & end_yrj1_ > 0
replace end_yrj1_ = . if end_yrj1_ == 9996

*whether unemployed ever (leave out for now) 
gen i_u_evr = 0
forval num = 1/50{
replace i_u_evr = 1 if i_u_indiv == 1
replace i_u_evr = 1 if l`num'.i_u_evr == 1
}
***
label var i_u_evr "experienced unemployment before or during this yr"

*# of unemployment spells*
bysort famidpn: gen i_u_num = sum(i_u_indiv)

save "$RAW\psid_jb2A_hk.dta", replace
log close
