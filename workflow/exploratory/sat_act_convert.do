
clear
* Source https://collegereadiness.collegeboard.org/educators/higher-ed/scoring/concordance
	* Plus I filled down from 580 because the table didn't go all the way to 400

input sat_merge act_merge 
1600	36
1590	36
1580	36
1570	36
1560	35
1550	35
1540	35 * take the midpoint and then run a regression for the midopint. 
1530	35
1520	34
1510	34
1500	34
1490	34
1480	33
1470	33
1460	33
1450	33
1440	32
1430	32
1420	32
1410	31
1400	31
1390	31
1380	30
1370	30
1360	30
1350	29
1340	29
1330	29
1320	28
1310	28
1300	28
1290	27
1280	27
1270	27
1260	27
1250	26
1240	26
1230	26
1220	25
1210	25
1200	25
1190	24
1180	24
1170	24
1160	24
1150	23
1140	23
1130	23
1120	22
1110	22
1100	22
1090	21
1080	21
1070	21
1060	21
1050	20
1040	20
1030	20
1020	19
1010	19
1000	19
990		19
980		18
970		18
960		18
950		17
940		17
930		17
920		17
910		16
900		16
890		16
880		16
870		15
860		15
850		15
840		15
830		15
820		14
810		14
800		14
790		14
780		14
770		13
760		13
750		13
740		13
730		13
720		12
710		12
700		12
690		12
680		11
670		11
660		11
650		11
640		10
630		10
620		10
610		9
600		9
590		9
580 	9
570		8
560		8
550		8
540		8
530		7
520		7
510		7
500		7
490		6
480		6
470		6
460		6
450		5
440		5
430		5
420		5
410		4
400		4
end

tempfile act_convert
save `act_convert'

use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_with_indintnum.dta", clear

keep famidpns year age sat* act*

replace sat_reading = . if sat_reading >800 
replace sat_math = . if sat_math >800 
replace sat_reading = . if sat_reading <200 
replace sat_math = . if sat_math <200 
replace act_score = . if act_score > 36 
replace act_score = . if act_score < 11 

count if sat_math != . & sat_reading == . 
count if sat_math == . & sat_reading != . 
gen sat_reading_round = round(sat_reading,10)
gen sat_math_round = round(sat_math,10)
gen sat_merge = sat_reading_round + sat_math_round 


merge m:1 sat_merge using `act_convert'
	* There are some weird errors can't help that honestly. 
	drop if _merge == 2
sort _merge
tab sat_math _merge

gen act_equivalent_score = act_score 
	replace act_equivalent_score  = act_merge if act_equivalent_score  == . 
	
sort famidpns year

* There is some suspicious reporting
bysort famidpns: egen max_act_equivalent = max(act_equivalent_score)
bysort famidpns: egen min_act_equivalent = min(act_equivalent_score)
count if max_act_equivalent != min_act_equivalent 
*br if max_act_equivalent != min_act_equivalent & year >= 2011

/*keep if age >= 15 & age <= 18
twoway (hist max_act_equivalent, width(1) color(orange%30)) ///
	   (hist min_act_equivalent, width(1) color(blue%30)) ///
	   , legend(order(1 "Max" 2 "Min")) title("Act Equivalent Score")
		
*/ 
	 
* Phil doesn't want the act score. 
clear
use `act_convert'
	regress sat_merge act_merge
	predict sat_predicted_temp

gen sat_predicted = round(sat_predicted_temp,10)
	* If you take a look at this these values don't really make sense. 

* I'm taking the avergage and rounding sorry 
	collapse (mean) sat_merge , by(act_merge )
	gen sat_merge2 = round(sat,10)
	drop sat_merge
	rename sat_merge2 sat_merge 
	
save "$path/psid_cleanup/data/intermediate/act_to_sat_conversion.dta" , replace



use "$path/psid_cleanup/data/intermediate/wealth_finaid_psid_with_indintnum.dta", clear
keep famidpns year age sat* act*

replace sat_reading = . if sat_reading >800 
	replace sat_math = . if sat_math >800 
	replace sat_reading = . if sat_reading <200 
	replace sat_math = . if sat_math <200 
	replace act_score = . if act_score > 36 
	replace act_score = . if act_score < 11 

	count if sat_math != . & sat_reading == . 
	count if sat_math == . & sat_reading != . 
	gen sat_reading_round = round(sat_reading,10)
	gen sat_math_round = round(sat_math,10)
	gen sat_score= sat_reading_round + sat_math_round 
	gen act_merge = act_score
		
	
// Phil wants to use the sat equivalent score. See sat_act_convert.do for more details
	merge m:1 act_merge using "$path/psid_cleanup/data/intermediate/act_to_sat_conversion.dta"
		drop if _merge == 2
		drop _merge 
	
	gen sat_equivalent_score = sat_score 
	replace sat_equivalent_score  = sat_merge if sat_equivalent_score  == . 
	
// Remembering scores 
	** Clearly there are some problems here 
		*hist sat_equivalent_score, width(10)
		tab sat_equivalent_score  
		
	* There is some suspicious reporting
		bysort famidpns: egen max_sat_equivalent = max(sat_equivalent_score)
		bysort famidpns: egen min_sat_equivalent = min(sat_equivalent_score)
		count if max_sat_equivalent !=  min_sat_equivalent

		sort famidpns year
		br if max_sat_equivalent != min_sat_equivalent 
		
	* I'm going to take the earliest sat score available 
		// Want the value of the child's student loan debt at each age group. But the variable is currently long	
	gen temp_sat_at_15_16 = sat_equivalent_score if inlist(age,15,16)
	gen temp_sat_at_17_18 = sat_equivalent_score if inlist(age,17,18)
	gen temp_sat_at_19_20 = sat_equivalent_score if inlist(age,19,20)
	gen temp_sat_at_21_22 = sat_equivalent_score if inlist(age,21,22)
	gen temp_sat_at_23_24 = sat_equivalent_score if inlist(age,23,24)
	gen temp_sat_at_25_26 = sat_equivalent_score if inlist(age,25,26)

	
	bysort famidpns: egen sat_at_15_16 = max(temp_sat_at_15_16)	
	bysort famidpns: egen sat_at_17_18 = max(temp_sat_at_17_18)
	bysort famidpns: egen sat_at_19_20 = max(temp_sat_at_19_20)
	bysort famidpns: egen sat_at_21_22 = max(temp_sat_at_21_22)
	bysort famidpns: egen sat_at_23_24 = max(temp_sat_at_23_24)
	bysort famidpns: egen sat_at_25_26 = max(temp_sat_at_25_26)
	drop temp_sat*
	
	gen college_age_sat_equivalent 		   = sat_at_17_18
		replace college_age_sat_equivalent = sat_at_19_20 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_15_16 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_19_20 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_21_22 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_23_24 if college_age_sat_equivalent == . 
		replace college_age_sat_equivalent = sat_at_25_26 if college_age_sat_equivalent == . 
	
	drop sat_reading sat_math act_score sat_reading_round sat_math_round sat_score act_merge sat_merge /// 
	sat_equivalent_score max_sat_equivalent min_sat_equivalent /// 
	sat_at_15_16 sat_at_17_18 sat_at_19_20 sat_at_21_22 sat_at_23_24 sat_at_25_26 