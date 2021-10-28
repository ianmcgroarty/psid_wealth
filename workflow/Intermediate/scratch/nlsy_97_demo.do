clear all 
set more off

********************************* Setting Macros *******************************
global data "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data" 
global raw  "$data\raw" 
global int  "$data\Intermediate" 
global output "$data\Output" 

/*
import delimited using Y:\PSID_Jessica\data\raw\nlsy_97_demo.csv
save "$int\nlsy_97_demo.dta", replace 
*/

use "$int/nlsy_97_demo.dta", clear

rename r0536300 gender 
rename r1482600 race 
recode race (2=3) (1=.)
recode race (4=1) (.=2)

/*
1 Black
2 Hispanic
3 Mixed Race (Non-Hispanic)
4 Non-Black / Non-Hispanic (white)

now 
1 White
2 Black 
3 Other 
*/

graph bar, over(race, relabel(1 White 2 Black 3 Other)) ylabel(0(10)60) name(nlsy_race, replace)
graph save Graph "$output\race_nlsy.gph", replace 


rename s5412700 comp_ed_2005
recode comp_ed_2005 (95=.) (-4=.) (-5=.) 

rename s5412800 fam_inc_2005
recode fam_inc_2005 (-4=.) (-5=.)

rename t0014000 comp_ed_2007
recode comp_ed_2007 (95=.) (-4=.) (-5=.)

rename t0014100 fam_inc_2007
recode fam_inc_2007 (-4=.) (-5=.)

rename t3606400 comp_ed_2009
recode comp_ed_2009 (95=.) (-4=.) (-5=.)

rename t6656600 comp_ed_2011
recode comp_ed_2011 (95=.) (-4=.) (-5=.)

rename t8129000 comp_ed_2013
recode comp_ed_2013 (95=.) (-4=.) (-5=.)

rename u0008800 comp_ed_2015
recode comp_ed_2015 (95=.) (-4=.) (-5=.)

rename r0000100 pubid

rename t3606500 fam_inc_2009
recode fam_inc_2009 (-4=.) (-5=.)

rename t6656700 fam_inc_2011
recode fam_inc_2011 (-4=.) (-5=.)

rename t8129100 fam_inc_2013
recode fam_inc_2013 (-4=.) (-5=.)

rename u0008900 fam_inc_2015
recode fam_inc_2015 (-4=.) (-5=.)

reshape long ///
comp_ed_ ///
fam_inc_  , i(pubid) j (year)

recode comp_ed_ (-3=.)
recode fam_inc_ (-3=.) 












