clear all 
set more off

********************************* Setting Macros *******************************
global data "\\c1resp3\Retail_Risk_Analysis\Non_Restricted_Research\Kiser\PSID\PSID_Jessica\data" 
global raw  "$data\raw" 
global int  "$data\Intermediate" 
global output "$data\Output" 


use \\rb.win.frb.org\C1\Accounts\J-L\c1jhk02\Redirected\Desktop\IPUMS, clear

recode ftotinc (9999998/9999999=.) 
keep if ftotinc >= 0 

*mean income of 77,698

*compare education next 

recode race (4/5=3) 
recode race (6/7=3) 
recode race (8/9=3)

recode educd (1=.)(999=.)
