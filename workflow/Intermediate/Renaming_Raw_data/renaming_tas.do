/*

Name: Veronika Konovalova
Project: Wealth and FAFSA 
Description: cleaning and stitching together all years of TA data
Last Updated: 5/27/21

*/

// The annual TAS files do not have the 1968 dynasty identifier (famidpn)-- this is annoying
// Take the personalized file I downloaded, J293176.dta, and attach the identifier to the data

forv i = 2005(2)2017{
clear
do D:/Veronika/psid_cleanup/workflow/Raw/tas_J293176.do

***Combining famid and pnid to create a unique identifier for each observation
	rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
	rename ER30002 pnid
	label var pnid "unique person #, for each individual"

	gen famidpn  = (famid*1000)+ pn
	tostring famidpn, gen(famidpns)
	sort famidpn
	order famidpn famidpns
	
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

keep famidpns famidpn int_num`i' seq_num`i'
keep if int_num`i' != . & seq_num`i' ! = .
drop if int_num`i' == 0 & seq_num`i' == 0
drop if seq_num`i' == 0

save D:/Veronika/psid_cleanup/data/raw/famid_`i'.dta, replace
}

// Now take each TAS year, merge on the corresponding year's identifier to get the 1968 dynasty identifier onto each observation
forv i = 5(2)9{

clear
do D:/Veronika/psid_cleanup/workflow/Raw/TA200`i'.do

	rename TA0`i'0003 int_num200`i'
	rename TA0`i'0004 seq_num200`i'
	
merge 1:1 int_num200`i' seq_num200`i' using D:/Veronika/psid_cleanup/data/raw/famid_200`i'.dta
assert _merge != 1 
drop if _merge == 2
drop _merge

order famidpns int_num200`i' seq_num200`i'

save D:/Veronika/psid_cleanup/data/raw/TA200`i'_lab.dta, replace
}

forv i = 11(2)17{

clear
do D:/Veronika/psid_cleanup/workflow/Raw/TA20`i'.do

	rename TA`i'0003 int_num20`i'
	rename TA`i'0004 seq_num20`i'
	
merge 1:1 int_num20`i' seq_num20`i' using D:/Veronika/psid_cleanup/data/raw/famid_20`i'.dta
assert _merge != 1 
drop if _merge == 2
drop _merge 

order famidpns int_num20`i' seq_num20`i'


save D:/Veronika/psid_cleanup/data/raw/TA20`i'_lab.dta, replace
}

// Now string all the datasets together 
use D:/Veronika/psid_cleanup/data/raw/TA2005_lab.dta, clear
merge 1:1 famidpns using D:/Veronika/psid_cleanup/data/raw/TA2007_lab.dta
drop _merge 
merge 1:1 famidpns using D:/Veronika/psid_cleanup/data/raw/TA2009_lab.dta
drop _merge 
merge 1:1 famidpns using D:/Veronika/psid_cleanup/data/raw/TA2011_lab.dta
drop _merge 
merge 1:1 famidpns using D:/Veronika/psid_cleanup/data/raw/TA2013_lab.dta
drop _merge 
merge 1:1 famidpns using D:/Veronika/psid_cleanup/data/raw/TA2015_lab.dta
drop _merge 
merge 1:1 famidpns using D:/Veronika/psid_cleanup/data/raw/TA2017_lab.dta
drop _merge 

* NOTE: College #1 = most recent college, college #2 = college before it

	*****************renaming variables**********************
	
rename TA050559 fam_bought_house_condo2005
rename TA070533 fam_bought_house_condo2007
rename TA090570 fam_bought_house_condo2009
rename TA110650 fam_bought_house_condo2011
rename TA130670 fam_bought_house_condo2013
rename TA150679 fam_bought_house_condo2015
rename TA170634 fam_bought_house_condo2017

rename TA050560 value_house_condo2005
rename TA070534 value_house_condo2007
rename TA090571 value_house_condo2009
rename TA110651 value_house_condo2011
rename TA130671 value_house_condo2013
rename TA150680 value_house_condo2015
rename TA170635 value_house_condo2017

rename TA050561 fam_paid_rent_mortgage2005
rename TA070535 fam_paid_rent_mortgage2007
rename TA090572 fam_paid_rent_mortgage2009
rename TA110652 fam_paid_rent_mortgage2011
rename TA130672 fam_paid_rent_mortgage2013
rename TA150681 fam_paid_rent_mortgage2015
rename TA170638 fam_paid_rent_mortgage2017

rename TA050562 value_rent_mortgage2005
rename TA070536 value_rent_mortgage2007
rename TA090573 value_rent_mortgage2009
rename TA110653 value_rent_mortgage2011
rename TA130673 value_rent_mortgage2013
rename TA150682 value_rent_mortgage2015
rename TA170639 value_rent_mortgage2017

rename TA050563 fam_bought_car2005 
rename TA070537 fam_bought_car2007
rename TA090574 fam_bought_car2009 
rename TA110654 fam_bought_car2011 
rename TA130674 fam_bought_car2013 
rename TA150683 fam_bought_car2015
rename TA170642 fam_bought_car2017

rename TA050564 value_car2005
rename TA070538 value_car2007
rename TA090575 value_car2009
rename TA110655 value_car2011
rename TA130675 value_car2013
rename TA150684 value_car2015 
rename TA170643 value_car2017

rename TA050565 fam_paid_tuition2005
rename TA070539 fam_paid_tuition2007
rename TA090576 fam_paid_tuition2009
rename TA110656 fam_paid_tuition2011
rename TA130676 fam_paid_tuition2013
rename TA150685 fam_paid_tuition2015
rename TA170646 fam_paid_tuition2017

rename TA050566 value_tuition2005 
rename TA070540 value_tuition2007
rename TA090577 value_tuition2009 
rename TA110657 value_tuition2011 
rename TA130677 value_tuition2013 
rename TA150686 value_tuition2015 
rename TA170647 value_tuition2017 

rename TA170650 fam_helped_pay_sl2017

rename TA170651 value_sl_payments2017

rename TA050567 fam_paid_expenses2005
rename TA070541 fam_paid_expenses2007
rename TA090578 fam_paid_expenses2009
rename TA110658 fam_paid_expenses2011
rename TA130678 fam_paid_expenses2013
rename TA150687 fam_paid_expenses2015
rename TA170656 fam_paid_expenses2017

rename TA050568 value_expenses2005 
rename TA070542 value_expenses2007
rename TA090579 value_expenses2009 
rename TA110659 value_expenses2011 
rename TA130679 value_expenses2013 
rename TA150688 value_expenses2015
rename TA170657 value_expenses2017

rename TA050569 got_personal_loan2005 
rename TA070543 got_personal_loan2007
rename TA090580 got_personal_loan2009 
rename TA110660 got_personal_loan2011 
rename TA130680 got_personal_loan2013 
rename TA150689 got_personal_loan2015
rename TA170654 got_personal_loan2017

rename TA050570 value_personal_loan2005  
rename TA070544 value_personal_loan2007 
rename TA090581 value_personal_loan2009 
rename TA110661 value_personal_loan2011 
rename TA130681 value_personal_loan2013 
rename TA150690 value_personal_loan2015
rename TA170655 value_personal_loan2017

rename TA070545 other_fin_help2007
rename TA090582 other_fin_help2009
rename TA110662 other_fin_help2011
rename TA130682 other_fin_help2013
rename TA150691 other_fin_help2015
rename TA170660 other_fin_help2017

rename TA110663 val_other_fin_help2011
rename TA130683 val_other_fin_help2013
rename TA150692 val_other_fin_help2015
rename TA170661 val_other_fin_help2017

rename TA090583 other_large_gifts2009
rename TA110664 other_large_gifts2011
rename TA130684 other_large_gifts2013
rename TA150693 other_large_gifts2015
rename TA170662 other_large_gifts2017

rename TA170671 yr_rec_first_mention_one2017
rename TA170676 yr_rec_first_mention_two2017 

rename TA150694 large_gift_first_mention2015 
rename TA170664 large_gift_first_mention2017 

rename TA150698 large_gift_second_mention2015

rename TA150699 how_much_second_mention2015 

rename TA150700 yr_rec_second_mention2015 
rename TA170665 yr_rec_second_mention2017

rename TA170666 yr_rec_third_mention2017

rename TA170663 gift_inheritance_one2017 
rename TA170670 gift_inheritance_two2017 
rename TA170675 gift_inheritance_three2017 

rename TA090584 large_gift_one_amt2009
rename TA110665 large_gift_one_amt2011
rename TA130685 large_gift_one_amt2013
rename TA150695 large_gift_one_amt2015

rename TA090585 large_gift_one_yr_rec2009
rename TA110666 large_gift_one_yr_rec2011
rename TA130686 large_gift_one_yr_rec2013
rename TA150696 large_gift_one_yr_rec2015

rename TA090586 large_gift_two_amt2009
rename TA110667 large_gift_two_amt2011
rename TA130687 large_gift_two_amt2013
rename TA150697 large_gift_two_amt2015

rename TA090587 large_gift_two_yr_rec2009
rename TA110668 large_gift_two_yr_rec2011
rename TA130688 large_gift_two_yr_rec2013

rename TA090588 large_gift_three_amt2009
rename TA110669 large_gift_three_amt2011
rename TA130689 large_gift_three_amt2013

rename TA090589 large_gift_three_yr_rec2009
rename TA110670 large_gift_three_yr_rec2011
rename TA130690 large_gift_three_yr_rec2013

rename TA170667 how_much_one2017
rename TA170672 how_much_two2017
rename TA170677 how_much_three2017


rename TA050571 received_inheritance2005 
rename TA070546 received_inheritance2007

rename TA050572 value_inheritance2005
rename TA070547 value_inheritance2007
* rename value_inheritance2009
* rename value_inheritance2011
* rename value_inheritance2013
* rename TA050572 value_inheritance2015

rename TA050573 grad_hs2005
rename TA070548 grad_hs2007
rename TA090590 grad_hs2009
rename TA110671 grad_hs2011
rename TA130691 grad_hs2013
rename TA150701 grad_hs2015
rename TA170781 grad_hs2017

rename TA050574 month_grad_hs2005
rename TA070549 month_grad_hs2007
rename TA090591 month_grad_hs2009
rename TA110672 month_grad_hs2011
rename TA130692 month_grad_hs2013
rename TA150702 month_grad_hs2015

rename TA050575 year_grad_hs2005
rename TA070550 year_grad_hs2007
rename TA090592 year_grad_hs2009
rename TA110673 year_grad_hs2011
rename TA130693 year_grad_hs2013
rename TA150703 year_grad_hs2015
* none for 2017?

rename TA050576 grade_lvl_if_ged2005
rename TA070551 grade_lvl_if_ged2007
rename TA090593 grade_lvl_if_ged2009
rename TA110674 grade_lvl_if_ged2011
rename TA130694 grade_lvl_if_ged2013
rename TA150704 grade_lvl_if_ged2015
* none for 2017?

rename TA050577 month_last_in_school_if_ged2005
rename TA070552 month_last_in_school_if_ged2007
rename TA090594 month_last_in_school_if_ged2009
rename TA110675 month_last_in_school_if_ged2011
rename TA130695 month_last_in_school_if_ged2013
rename TA150705 month_last_in_school_if_ged2015
* none for 2017?

rename TA050578 year_last_in_school_if_ged2005 
rename TA070553 year_last_in_school_if_ged2007
rename TA090595 year_last_in_school_if_ged2009 
rename TA110676 year_last_in_school_if_ged2011 
rename TA130696 year_last_in_school_if_ged2013 
rename TA150706 year_last_in_school_if_ged2015
* none for 2017?

rename TA050579 month_received_ged2005 
rename TA070554 month_received_ged2007
rename TA090596 month_received_ged2009 
rename TA110677 month_received_ged2011 
rename TA130697 month_received_ged2013 
rename TA150707 month_received_ged2015
* none for 2017?

rename TA050580 year_received_ged2005 
rename TA070555 year_received_ged2007
rename TA090597 year_received_ged2009 
rename TA110678 year_received_ged2011 
rename TA130698 year_received_ged2013 
rename TA150708 year_received_ged2015
* none for 2017?

rename TA050581 last_grade_finished2005 
rename TA070556 last_grade_finished2007
rename TA090598 last_grade_finished2009 
rename TA110679 last_grade_finished2011 
rename TA130699 last_grade_finished2013 
rename TA150709 last_grade_finished2015
* none for 2017?

rename TA050582 mo_last_school_ifnograd2005
rename TA070557 mo_last_school_ifnograd2007
rename TA090599 mo_last_school_ifnograd2009
rename TA110680 mo_last_school_ifnograd2011
rename TA130700 mo_last_school_ifnograd2013
rename TA150710 mo_last_school_ifnograd2015
* none for 2017?

rename TA050583 yr_last_in_school_ifnograd2005
rename TA070558 yr_last_in_school_ifnograd2007
rename TA090600 yr_last_in_school_ifnograd2009
rename TA110681 yr_last_in_school_ifnograd2011
rename TA130701 yr_last_in_school_ifnograd2013
rename TA150711 yr_last_in_school_ifnograd2015
* none for 2017?

rename TA050584 hs_gpa2005 
rename TA070559 hs_gpa2007
rename TA090601 hs_gpa2009 
rename TA110682 hs_gpa2011 
rename TA130702 hs_gpa2013 
rename TA150712 hs_gpa2015
rename TA170782 hs_gpa2017

rename TA050585 highest_hs_gpa2005 
rename TA070560 highest_hs_gpa2007
rename TA090602 highest_hs_gpa2009 
rename TA110683 highest_hs_gpa2011 
rename TA130703 highest_hs_gpa2013 
rename TA150713 highest_hs_gpa2015
rename TA170783 highest_hs_gpa2017

rename TA110684 had_more_educ2011
rename TA130704 had_more_educ2013
rename TA150714 had_more_educ2015

rename TA110687 highest_lvl_complete2011
rename TA130707 highest_lvl_complete2013
rename TA150717 highest_lvl_complete2015

*rename TA110688 grad_hs2011
*rename TA130708 grad_hs2013
*rename TA150718 grad_hs2015

rename TA110689 grad_college2011
rename TA130709 grad_college2013
rename TA150719 grad_college2015

rename TA050590 took_sat2005
rename TA070565 took_sat2007
rename TA090607 took_sat2009
rename TA110694 took_sat2011
rename TA130714 took_sat2013
rename TA150726 took_sat2015
rename TA170785 took_sat2017

rename TA050591 sat_reading2005
rename TA070566 sat_reading2007
rename TA090608 sat_reading2009
rename TA110695 sat_reading2011
rename TA130715 sat_reading2013
rename TA150727 sat_reading2015
rename TA170787 sat_reading2017

rename TA050592 sat_math2005
rename TA070567 sat_math2007
rename TA090609 sat_math2009
rename TA110696 sat_math2011
rename TA130716 sat_math2013
rename TA150728 sat_math2015
rename TA170788 sat_math2017

rename TA050593 act_score2005
rename TA070568 act_score2007
rename TA090610 act_score2009
rename TA110697 act_score2011
rename TA130717 act_score2013
rename TA150729 act_score2015
rename TA170789 act_score2017

rename TA050594 ever_attend_college2005     
rename TA070569 ever_attend_college2007
rename TA090611 ever_attend_college2009
rename TA110698 ever_attend_college2011
rename TA130718 ever_attend_college2013
rename TA150730 ever_attend_college2015
rename TA170790 ever_attend_college2017

rename TA050595 in_college2005 
rename TA070570 in_college2007 
rename TA090612 in_college2009 
rename TA110699 in_college2011 
rename TA130719 in_college2013 
rename TA150731 in_college2015

rename TA110711 current_attend_college2011
rename TA130731 current_attend_college2013
rename TA150743 current_attend_college2015

rename TA050596 ft_or_pt_student2005
rename TA070571 ft_or_pt_student2007
rename TA090624 ft_or_pt_student2009
rename TA110712 ft_or_pt_student2011
rename TA130732 ft_or_pt_student2013
rename TA150744 ft_or_pt_student2015
rename TA170791 ft_or_pt_student2017

rename TA050597 mo_enroll_most_rec_college2005 
rename TA070572 mo_enroll_most_rec_college2007
rename TA090625 mo_enroll_most_rec_college2009
rename TA110713 mo_enroll_most_rec_college2011
rename TA130733 mo_enroll_most_rec_college2013
rename TA150746 mo_enroll_most_rec_college2015
rename TA170798 mo_enroll_most_rec_college2017

rename TA050598 yr_enroll_most_rec_college2005
rename TA070573 yr_enroll_most_rec_college2007
rename TA090626 yr_enroll_most_rec_college2009
rename TA110714 yr_enroll_most_rec_college2011
rename TA130734 yr_enroll_most_rec_college2013
rename TA150747 yr_enroll_most_rec_college2015
rename TA170799 yr_enroll_most_rec_college2017

rename TA050599 mo_attend_most_rec_college2005 
rename TA070574 mo_attend_most_rec_college2007
rename TA090627 mo_attend_most_rec_college2009
rename TA110715 mo_attend_most_rec_college2011
rename TA130735 mo_attend_most_rec_college2013
rename TA150748 mo_attend_most_rec_college2015
rename TA170800 mo_attend_most_rec_college2017

rename TA050600 yr_attend_most_rec_college2005
rename TA070575 yr_attend_most_rec_college2007
rename TA090628 yr_attend_most_rec_college2009
rename TA110716 yr_attend_most_rec_college2011
rename TA130736 yr_attend_most_rec_college2013
rename TA150749 yr_attend_most_rec_college2015
rename TA170801 yr_attend_most_rec_college2017

* Then what are these? TA050608 TA070583 TA150757 TA170812
rename TA050601 major_most_rec_college2005
rename TA070576 major_most_rec_college2007
rename TA090629 major_most_rec_college2009
rename TA110717 major_most_rec_college2011
rename TA130737 major_most_rec_college2013
rename TA150750 major_most_rec_college2015
rename TA170802 major_most_rec_college2017
 
rename TA050603 gpa_most_rec_college2005
rename TA070578 gpa_most_rec_college2007
rename TA090631 gpa_most_rec_college2009
rename TA110719 gpa_most_rec_college2011
rename TA130739 gpa_most_rec_college2013
rename TA150752 gpa_most_rec_college2015
rename TA170805 gpa_most_rec_college2017

rename TA050604 high_gpa_most_rec_college2005
rename TA070579 high_gpa_most_rec_college2007
rename TA090632 high_gpa_most_rec_college2009
rename TA110720 high_gpa_most_rec_college2011
rename TA130740 high_gpa_most_rec_college2013
rename TA150753 high_gpa_most_rec_college2015
rename TA170806 high_gpa_most_rec_college2017

rename TA050606 degree_most_rec_college2005
rename TA070581 degree_most_rec_college2007
rename TA090634 degree_most_rec_college2009
rename TA110722 degree_most_rec_college2011
rename TA130742 degree_most_rec_college2013
rename TA150755 degree_most_rec_college2015
rename TA170808 degree_most_rec_college2017

rename TA050609 gpa_college_one2005
rename TA070584 gpa_college_one2007
rename TA090637 gpa_college_one2009
rename TA110725 gpa_college_one2011
rename TA130745 gpa_college_one2013
rename TA150758 gpa_college_one2015
rename TA170814 gpa_college_one2017

rename TA050610 highest_gpa_college_one2005
rename TA070585 highest_gpa_college_one2007
rename TA090638 highest_gpa_college_one2009
rename TA110726 highest_gpa_college_one2011
rename TA130746 highest_gpa_college_one2013
rename TA150759 highest_gpa_college_one2015
rename TA170815 highest_gpa_college_one2017

rename TA050612 tot_credit_hrs_college_one2005
rename TA070587 tot_credit_hrs_college_one2007
rename TA090640 tot_credit_hrs_college_one2009
rename TA110728 tot_credit_hrs_college_one2011
rename TA130748 tot_credit_hrs_college_one2013
rename TA150761 tot_credit_hrs_college_one2015
rename TA170810 tot_credit_hrs_college_one2017

rename TA050613 semester_system_college_one2005
rename TA070588 semester_system_college_one2007
rename TA090641 semester_system_college_one2009
rename TA110729 semester_system_college_one2011
rename TA130749 semester_system_college_one2013
rename TA150762 semester_system_college_one2015
rename TA170811 semester_system_college_one2017

rename TA050614 mo_enroll_earlier_college2005
rename TA070589 mo_enroll_earlier_college2007
rename TA090642 mo_enroll_earlier_college2009
rename TA110730 mo_enroll_earlier_college2011
rename TA130750 mo_enroll_earlier_college2013
rename TA150763 mo_enroll_earlier_college2015
rename TA170819 mo_enroll_earlier_college2017

rename TA050615 yr_enroll_earlier_college2005
rename TA070590 yr_enroll_earlier_college2007
rename TA090643 yr_enroll_earlier_college2009
rename TA110731 yr_enroll_earlier_college2011
rename TA130751 yr_enroll_earlier_college2013
rename TA150764 yr_enroll_earlier_college2015
rename TA170820 yr_enroll_earlier_college2017

rename TA050616 mo_attend_earlier_college2005
rename TA070591 mo_attend_earlier_college2007
rename TA090644 mo_attend_earlier_college2009
rename TA110732 mo_attend_earlier_college2011
rename TA130752 mo_attend_earlier_college2013
rename TA150765 mo_attend_earlier_college2015
rename TA170821 mo_attend_earlier_college2017

rename TA050617 yr_attend_earlier_college2005
rename TA070592 yr_attend_earlier_college2007
rename TA090645 yr_attend_earlier_college2009
rename TA110733 yr_attend_earlier_college2011
rename TA130753 yr_attend_earlier_college2013
rename TA150766 yr_attend_earlier_college2015
rename TA170822 yr_attend_earlier_college2017

rename TA050620 gpa_earlier_college2005
rename TA070597 gpa_earlier_college2007
rename TA090650 gpa_earlier_college2009
rename TA110738 gpa_earlier_college2011
rename TA130758 gpa_earlier_college2013
rename TA150771 gpa_earlier_college2015
rename TA170828 gpa_earlier_college2017

rename TA050626 gpa_college_two2005

rename TA050621 highest_gpa_earlier_college2005
rename TA070598 highest_gpa_earlier_college2007
rename TA090651 highest_gpa_earlier_college2009
rename TA110739 highest_gpa_earlier_college2011
rename TA130759 highest_gpa_earlier_college2013
rename TA150772 highest_gpa_earlier_college2015
rename TA170829 highest_gpa_earlier_college2017

rename TA050627 highest_gpa_college_two2005

rename TA050623 degree_earlier_college2005
rename TA070594 degree_earlier_college2007
rename TA090647 degree_earlier_college2009
rename TA110735 degree_earlier_college2011
rename TA130755 degree_earlier_college2013
rename TA150768 degree_earlier_college2015
rename TA170824 degree_earlier_college2017

*rename TA050625 major_earlier_college2005
*rename TA070596 major_earlier_college2007
*rename TA090649 major_earlier_college2009
*rename TA110737 major_earlier_college2011
*rename TA130757 major_earlier_college2013
*rename TA150770 major_earlier_college2015
*rename TA170826 major_earlier_college2017

rename TA050834 ethnicity2005 
rename TA070815 ethnicity2007 
* rename ethnicity2009 
* rename ethnicity2011 
* rename ethnicity2013
* rename ethnicity2015
* rename ethnicity2017

rename TA050884 race2005  
rename TA070865 race2007 
rename TA090925 race2009 
rename TA111057 race2011 
rename TA131092 race2013 
rename TA151132 race2015
rename TA171955 race2017

rename TA050947 educ_mother2005
rename TA070928 educ_mother2007
rename TA090992 educ_mother2009
rename TA111134 educ_mother2011
rename TA131226 educ_mother2013
rename TA151286 educ_mother2015
rename TA171981 educ_mother2017

rename TA050948 recent_educ_mother2005
rename TA070929 recent_educ_mother2007
rename TA090993 recent_educ_mother2009
rename TA111135 recent_educ_mother2011
rename TA131227 recent_educ_mother2013
rename TA151287 recent_educ_mother2015
rename TA171982 recent_educ_mother2017

rename TA050949 educ_father2005
rename TA070930 educ_father2007
rename TA090994 educ_father2009
rename TA111136 educ_father2011
rename TA131228 educ_father2013
rename TA151288 educ_father2015
rename TA171983 educ_father2017

rename TA050950 recent_educ_father2005
rename TA070931 recent_educ_father2007
rename TA090995 recent_educ_father2009
rename TA111137 recent_educ_father2011
rename TA131229 recent_educ_father2013
rename TA151289 recent_educ_father2015
rename TA171984 recent_educ_father2017

rename TA091008 highest_educ_level2009
rename TA131241 highest_educ_level2013
rename TA151301 highest_educ_level2015
rename TA171990 highest_educ_level2017



* inspect: college #1 multiple entries for gpa and major
* 2015 weirdness with gifts and inheritances generally 

order famidpn famidpns int_num* fam_bought_house_condo* value_house_condo* fam_paid_rent_mortgage* ///
value_rent_mortgage* fam_bought_car* value_car* fam_paid_tuition* value_tuition* fam_helped_pay_sl* ///
value_sl_payments* fam_paid_expenses* value_expenses* got_personal_loan* value_personal_loan* ///
other_fin_help* val_other_fin_help* other_large_gifts* large_gift_first_mention* large_gift_one_amt* ///
large_gift_one_yr_rec* large_gift_two_amt* large_gift_two_yr_rec* large_gift_three_amt* ///
large_gift_three_yr_rec* received_inheritance* value_inheritance* large_gift_first_mention* ///
large_gift_second_mention* how_much_second_mention* yr_rec_second_mention* ///
gift_inheritance* yr_rec_third_mention* ///
how_much* yr_rec_first_mention* grad_hs* month_grad_hs* ///
year_grad_hs* grade_lvl_if_ged* month_last_in_school_if_ged* year_last_in_school_if_ged* ///
month_received_ged* year_received_ged* last_grade_finished* mo_last_school_ifnograd* ///
yr_last_in_school_ifnograd* hs_gpa* highest_hs_gpa* had_more_educ* had_more_educ* ///
highest_lvl_complete* grad_college* took_sat* sat_reading* sat_math* act_score* ever_attend_college* ///
in_college* current_attend_college* ft_or_pt_student* mo_enroll_most_rec_college* ///
yr_enroll_most_rec_college* mo_attend_most_rec_college* yr_attend_most_rec_college* major_most_rec_college* ///
gpa_most_rec_college* high_gpa_most_rec_college* degree_most_rec_college* gpa_college_one* ///
highest_gpa_college_one* tot_credit_hrs_college_one* semester_system_college_one* mo_enroll_earlier_college* ///
yr_enroll_earlier_college* mo_attend_earlier_college* yr_attend_earlier_college* gpa_earlier_college* ///
gpa_college_two* highest_gpa_earlier_college* highest_gpa_college_two*  degree_earlier_college* ///
ethnicity* race* highest_educ_level* educ_mother* recent_educ_mother* ///
educ_father* recent_educ_father* 

keep famidpn famidpns int_num* fam_bought_house_condo* value_house_condo* fam_paid_rent_mortgage* ///
value_rent_mortgage* fam_bought_car* value_car* fam_paid_tuition* value_tuition* fam_helped_pay_sl* ///
value_sl_payments* fam_paid_expenses* value_expenses* got_personal_loan* value_personal_loan* ///
other_fin_help* val_other_fin_help* other_large_gifts* large_gift_first_mention* large_gift_one_amt* ///
large_gift_one_yr_rec* large_gift_two_amt* large_gift_two_yr_rec* large_gift_three_amt* ///
large_gift_three_yr_rec* received_inheritance* value_inheritance* ///
large_gift_second_mention* how_much_second_mention* yr_rec_second_mention* ///
gift_inheritance* yr_rec_third_mention* ///
how_much* yr_rec_first_mention* grad_hs* month_grad_hs* ///
year_grad_hs* grade_lvl_if_ged* month_last_in_school_if_ged* year_last_in_school_if_ged* ///
month_received_ged* year_received_ged* last_grade_finished* mo_last_school_ifnograd* ///
yr_last_in_school_ifnograd* hs_gpa* highest_hs_gpa* had_more_educ* ///
highest_lvl_complete* grad_college* took_sat* sat_reading* sat_math* act_score* ever_attend_college* ///
in_college* current_attend_college* ft_or_pt_student* mo_enroll_most_rec_college* ///
yr_enroll_most_rec_college* mo_attend_most_rec_college* yr_attend_most_rec_college* major_most_rec_college* ///
gpa_most_rec_college* high_gpa_most_rec_college* degree_most_rec_college* gpa_college_one* ///
highest_gpa_college_one* tot_credit_hrs_college_one* semester_system_college_one* mo_enroll_earlier_college* ///
yr_enroll_earlier_college* mo_attend_earlier_college* yr_attend_earlier_college* gpa_earlier_college* ///
gpa_college_two* highest_gpa_earlier_college* highest_gpa_college_two*  degree_earlier_college* ///
ethnicity* race* highest_educ_level* educ_mother* recent_educ_mother* ///
educ_father* recent_educ_father* 

save D:/Veronika/psid_cleanup/data/Raw/tas_psid_renamed.dta,replace 
