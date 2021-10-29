
#delimit ;

**************************************************************************
   Label           : Panel Study of Income Dynamics: 2013 Rosters and Transfers Parent/Child File- Final Release
   Rows            : 23967
   Columns         : 74
   ASCII File Date : October 12, 2020
*************************************************************************;


infix 
      RT13V60        1 - 1          RT13V61        2 - 6          RT13V62        7 - 8    
      RT13V63        9 - 12         RT13V64       13 - 15         RT13V65       16 - 18   
      RT13V66       19 - 20         RT13V67       21 - 24         RT13V68       25 - 27   
      RT13V69       28 - 30         RT13V70       31 - 31         RT13V71       32 - 33   
      RT13V72       34 - 35         RT13V73       36 - 36         RT13V74       37 - 40   
      RT13V75       41 - 43         RT13V76       44 - 44         RT13V77       45 - 46   
      RT13V78       47 - 48         RT13V79       49 - 49         RT13V80       50 - 51   
      RT13V81       52 - 55         RT13V82       56 - 56         RT13V83       57 - 59   
      RT13V84       60 - 61         RT13V85       62 - 63         RT13V86       64 - 65   
      RT13V87       66 - 67         RT13V88       68 - 68         RT13V89       69 - 69   
      RT13V90       70 - 71         RT13V91       72 - 72         RT13V92       73 - 73   
      RT13V93       74 - 75         RT13V94       76 - 76         RT13V95       77 - 77   
      RT13V96       78 - 78         RT13V97       79 - 82         RT13V98       83 - 85   
      RT13V99       86 - 87         RT13V100      88 - 89         RT13V101      90 - 92   
      RT13V102      93 - 94         RT13V103      95 - 96         RT13V104      97 - 98   
      RT13V105      99 - 100        RT13V106     101 - 101        RT13V107     102 - 102  
      RT13V108     103 - 104        RT13V109     105 - 107        RT13V110     108 - 112  
      RT13V111     113 - 117        RT13V112     118 - 121        RT13V113     122 - 122  
      RT13V114     123 - 123        RT13V115     124 - 124        RT13V116     125 - 125  
      RT13V117     126 - 126        RT13V118     127 - 130        RT13V119     131 - 131  
      RT13V120     132 - 132        RT13V121     133 - 133        RT13V122     134 - 137  
      RT13V123     138 - 138        RT13V124     139 - 139   long RT13V125     140 - 148  
      RT13V126     149 - 149        RT13V127     150 - 150   long RT13V128     151 - 159  
      RT13V129     160 - 160   long RT13V130     161 - 169   long RT13V131     170 - 178  
 long RT13V132     179 - 187        RT13V133     188 - 188  
using /share/cfi-dubravka/wealth_fafsa/data/untouched/RT13PARCHD.txt, clear 
;
label variable  RT13V60      "RELEASE NUMBER" ;                                  
label variable  RT13V61      "ROSTERS AND TRANSFERS FILE (ID) NUMBER" ;          
label variable  RT13V62      "HEAD 2013 SEQUENCE NUMBER" ;                       
label variable  RT13V63      "HEAD 1968 INTERVIEW NUMBER" ;                      
label variable  RT13V64      "HEAD PERSON NUMBER" ;                              
label variable  RT13V65      "HEAD AGE" ;                                        
label variable  RT13V66      "WIFE 2013 SEQUENCE NUMBER" ;                       
label variable  RT13V67      "WIFE 1968 INTERVIEW NUMBER" ;                      
label variable  RT13V68      "WIFE PERSON NUMBER" ;                              
label variable  RT13V69      "WIFE AGE" ;                                        
label variable  RT13V70      "TYPE OF RECORD" ;                                  
label variable  RT13V71      "TYPE OF PARENTAL UNIT RECORD" ;                    
label variable  RT13V72      "RECORD NUMBER" ;                                   
label variable  RT13V73      "WHICH PARENT # 1" ;                                
label variable  RT13V74      "CHILD OR PARENT 1968 IW NUMBER # 1" ;              
label variable  RT13V75      "CHILD OR PARENT PERSON NUMBER # 1" ;               
label variable  RT13V76      "WTR CHILD OR PARENT IN FU" ;                       
label variable  RT13V77      "RELATIONSHIP TO HD # 1" ;                          
label variable  RT13V78      "RELATIONSHIP TO WF # 1" ;                          
label variable  RT13V79      "CHILD AGE CHECKPOINT" ;                            
label variable  RT13V80      "CHILD'S BIRTH MONTH" ;                             
label variable  RT13V81      "CHILD'S BIRTH YEAR" ;                              
label variable  RT13V82      "CR1 CHECKPOINT" ;                                  
label variable  RT13V83      "AGE # 1" ;                                         
label variable  RT13V84      "EMPLOYMENT STATUS MEN1 #1" ;                       
label variable  RT13V85      "EMPLOYMENT STATUS MEN2 #1" ;                       
label variable  RT13V86      "EMPLOYMENT STATUS MEN3 #1" ;                       
label variable  RT13V87      "EMPLOYMENT STATUS MEN4 #1" ;                       
label variable  RT13V88      "PR7/PR11 MARITAL STATUS #1" ;                      
label variable  RT13V89      "PR2/CR11 HEALTH STATUS #1" ;                       
label variable  RT13V90      "CR3 COMPLETED EDUCATION" ;                         
label variable  RT13V91      "CR5 MARITAL STATUS" ;                              
label variable  RT13V92      "CR6 WTR HAS PARTNER" ;                             
label variable  RT13V93      "CR7 NUMBER OF LIVING KIDS" ;                       
label variable  RT13V94      "PR7 CHECKPOINT" ;                                  
label variable  RT13V95      "WHETHER PARENTS ARE A COUPLE (PR7=1,2,3)" ;        
label variable  RT13V96      "WHICH PARENT # 2" ;                                
label variable  RT13V97      "2ND PARENT 1968 IW NUMBER # 2" ;                   
label variable  RT13V98      "2ND PARENT PERSON NUMBER # 2" ;                    
label variable  RT13V99      "2ND PAR RELATIONSHIP TO HD # 2" ;                  
label variable  RT13V100     "2ND PAR RELATIONSHIP TO WF # 2" ;                  
label variable  RT13V101     "2ND PARENT AGE # 2" ;                              
label variable  RT13V102     "2ND PAR EMPLOYMENT STATUS MEN1 #2" ;               
label variable  RT13V103     "2ND PAR EMPLOYMENT STATUS MEN2 #2" ;               
label variable  RT13V104     "2ND PAR EMPLOYMENT STATUS MEN3 #2" ;               
label variable  RT13V105     "2ND PAR EMPLOYMENT STATUS MEN4 #2" ;               
label variable  RT13V106     "2ND PAR PR7 MARITAL STATUS #2" ;                   
label variable  RT13V107     "PR2 HEALTH STATUS #2" ;                            
label variable  RT13V108     "PR8/PR12/CR8 STATE OF RESIDENCE" ;                 
label variable  RT13V109     "PR8/PR12/CR8 COUNTY OF RESIDENCE" ;                
label variable  RT13V110     "PR8/PR12/CR8 PLACE OF RESIDENCE" ;                 
label variable  RT13V111     "MAIN FAMILY PLACE OF RESIDENCE" ;                  
label variable  RT13V112     "DISTANCE IN MILES B/T FAM AND CHLD/PAR" ;          
label variable  RT13V113     "PR9/PR13/CR9 WTR OWNS HOME" ;                      
label variable  RT13V114     "PR10/14/CR10 WTR INCOME GE $50,000" ;              
label variable  RT13V115     "PR10A/14A/CR10A WTR INCOME GE $75,000" ;           
label variable  RT13V116     "PR10B/14B/CR10B WTR INCOME LE $25,000" ;           
label variable  RT13V117     "WHETHER PT2/CT2 AMT" ;                             
label variable  RT13V118     "PT2/CT2 HOURS HELPING CHILD/PARENT" ;              
label variable  RT13V119     "PT2/CT2 HOURS HELPING CHILD/PARENT PER" ;          
label variable  RT13V120     "CT3/PT3 WHO HELPED CHILD/PARENT" ;                 
label variable  RT13V121     "WHETHER PT5/CT5 AMT" ;                             
label variable  RT13V122     "PT5/CT5 HOURS BEING HELPED BY CHLD/PAR" ;          
label variable  RT13V123     "PT5/CT5 HOURS HELPING CHLD OR PAR PER" ;           
label variable  RT13V124     "WHETHER PT7/CT7 AMT" ;                             
label variable  RT13V125     "PT7/CT7 MONEY GIVEN TO CHLD/PAR" ;                 
label variable  RT13V126     "PT7/CT7 MONEY GIVEN TO CHLD/PAR PER" ;             
label variable  RT13V127     "WHETHER PT9/CT9 AMT" ;                             
label variable  RT13V128     "PT9/CT9 MONEY RECEIVED FROM CHLD/PAR" ;            
label variable  RT13V129     "PT9/CT9 MONEY RECEIVED FROM CHLD/PAR PER" ;        
label variable  RT13V130     "CT11 AMT GAVE MONEY FOR SCHOOL" ;                  
label variable  RT13V131     "CT13 AMT GAVE MONEY FOR HOME" ;                    
label variable  RT13V132     "CT15 AMT GAVE OTHER FINANCIAL HELP" ;              
label variable  RT13V133     "CATEGORICAL DISTANCE B/T FAM AND CHD/PAR" ;        
