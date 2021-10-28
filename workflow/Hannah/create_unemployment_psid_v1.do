**********************************************************************************
*Author: Hannah Kronenberg 
*Date: 11.06.2017
*Description: This file creates 
*********************************************************************************
global Data "H:\PSID\Data" 
global RAW "$Data\Raw"
global INT  "$Data\Intermediate" 
global OUT  "$Data\Output" 
global LOG  "H:\PSID\Code\logs"
global VERSION "v1"
*******************************************************
clear all
set more off

log using "$LOG/create_psid_unemploy_$version.smcl", text replace 
use "$RAW\unemploy_psid_raw.dta", clear

****************************
*Clean Data*****************
****************************

rename ER30001 famid
	label var famid "unique family id #, for each family from 1968"
rename ER30002 pnid
	label var pnid "unique person #, for each individual"

gen famidpn  = (famid*1000)+ pn

tostring famidpn, gen(famidpns)

sort famidpn

*Labor force status 
	*2005
	rename ER25104 lfs1_2005
	rename ER25105 lfs2_2005
	rename ER25106 lfs3_2005
	*2007
	rename ER36109 lfs1_2007
	rename ER36110 lfs2_2007
	rename ER36111 lfs3_2007
	*2009
	rename ER42140 lfs1_2009
	rename ER42141 lfs2_2009
	rename ER42142 lfs3_2009
	*2011
	rename ER47448 lfs1_2011
	rename ER47449 lfs2_2011
	rename ER47450 lfs3_2011
	*2013
	rename ER53148 lfs1_2013
	rename ER53149 lfs2_2013
	rename ER53150 lfs3_2013
	*2015
	rename ER60163 lfs1_2015
	rename ER60164 lfs2_2015
	rename ER60165 lfs3_2015	
*spouse labor force status
	*2005
	rename ER25362 lfs1_sp_2005
	rename ER25363 lfs2_sp_2005
	rename ER25364 lfs3_sp_2005
	*2007
	rename ER36367 lfs1_sp_2007
	rename ER36368 lfs2_sp_2007
	rename ER36369 lfs3_sp_2007
	*2009
	rename ER42392 lfs1_sp_2009
	rename ER42393 lfs2_sp_2009
	rename ER42394 lfs3_sp_2009
	*2011
	rename ER47705 lfs1_sp_2011
	rename ER47706 lfs2_sp_2011
	rename ER47707 lfs3_sp_2011		
	*2013
	rename ER53411 lfs1_sp_2013
	rename ER53412 lfs2_sp_2013
	rename ER53413 lfs3_sp_2013
	*2015
	rename ER60426 lfs1_sp_2015
	rename ER60427 lfs2_sp_2015
	rename ER60428 lfs3_sp_2015	

*prioritized
	rename ER33813 lfs_indiv_2005
	rename ER33913 lfs_indiv_2007
	rename ER34016 lfs_indiv_2009
	rename ER34116 lfs_indiv_2011
	rename ER34216 lfs_indiv_2013
	rename ER34317 lfs_indiv_2015	
	
*unemployment duration 
	rename ER25311 udur_2005
	rename ER36316 udur_2007
	rename ER42343 udur_2009
	rename ER47656 udur_2011
	rename ER53356 udur_2013
	rename ER60371 udur_2015
	
*spouse unemployment duration 
	rename ER25569 udur_sp_2005
	rename ER36574 udur_sp_2007
	rename ER42595 udur_sp_2009
	rename ER47913 udur_sp_2011	
	rename ER53619 udur_sp_2013	
	rename ER60634 udur_sp_2015

***********************************************************
*Missing codes for variables that don't change across waves
***********************************************************
	recode lfs_indiv_* (9=.)
	recode udur_* (98/99=.)
	recode udur_sp_* (98/99=.)

*lfs clean up 
	*2005
	recode lfs1_2005 (99=.) (0=.)
	recode lfs2_2005 (98=.)
	recode lfs3_2005 (98=.)
	*2007
	recode lfs1_2007 (98/99=.)
	recode lfs2_2007 (98=0)
	re
	*2009
	recode lfs1_2009 (99=.)
	*2011
	recode lfs1_2011 (99=.)
	*2013
	recode lfs1_2013 (99=.)
	*2015
	recode lfs1_2015 (99=.)
*lfs spouse clean up 
	*2005
	recode lfs1_sp_2005 (99=.)
	recode lfs2_sp_2005 (99=.)
	*2007
	recode lfs1_sp_2007 (99=.) (32=.)
	recode lfs3_sp_2007 (99=.)
	*2009
	recode lfs1_sp_2009 (99=.)
	*2011
	recode lfs1_sp_2011 (99=.)
	*2013
	recode lfs1_sp_2013 (99=.)
	*2015
	recode lfs1_sp_2015 (99=.)

***********************************************************
*Reshape
***********************************************************
	drop ER*

reshape long ///
	lfs1_ ///
	lfs2_ ///
	lfs3_ ///
	lfs1_sp_ ///
	lfs2_sp_ ///
	lfs3_sp_ ///
	lfs_indiv_ ///
	udur_ ///
	udur_sp_ , i(famidpn) j(year)


order famidpns famidpn famid pn year

***********************************************************
*creating variables 
***********************************************************

*Unemployed head current flag


*Unemployed in the previous survey flag


*Unemployed spouse current flag 

*Unemployed spouse in the previous survey flag

*Months unemployed flag by every three months 







