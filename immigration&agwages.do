//Report 2 Do File -- Emma Taylor//

use "C:\Users\emmat\OneDrive\Desktop\Report 2 490\Report 2 Data.dta"


//variable manipulation//
gen undocumented=0
replace undocumented=1 if currstat==4

gen logwages=ln(wage)

//calculating wage gap in every year//
**this is an example; I carried this out for every year in the survey**
summarize logwages if undocumented==1 & year==1989
summarize logwages if undocumented==0 & year==1989

gen u_wage=0
gen d_wage=0

**1.522036 and 1.525351 are the means calculated by the summarize commands**
replace u_wage==1.522036 if year==1989
replace d_wage==1.525351 if year==1989

//plotting wage gap//

scatter u_wage d_wage year

//summary statistics by documentation status//
summarize age english weeks education foreign gender migrant USfarmyears wage if undocumented==1
summarize age english weeks education foreign gender migrant USfarmyears wage if undocumented==0

//t-tests for statistically significant differences by documentation status//

ttest wage, by(undocumented)
ttest age, by(undocumented)
ttest gender, by(undocumented)
ttest english, by(undocumented)
ttest foreign, by(undocumented)
ttest migrant, by(undocumented)
ttest USfarmyears, by(undocumented)
ttest weeks, by(undocumented)

//panel regression for undocumented workers//
**i.year and i.region are the year and region fixed effects dummy variables**
reg logwages age english weeks education foregin gender migrant USfarmyears i.year i.region if undocumented==1

//post-estimation tests//

//residuals plot for heteroskedasticity//
rvfplot

//correlation matrix//
correlate

//vifs//
vif


//panel regression for documented workers//
**i.year and i.region are the year and region fixed effects dummy variables**
reg logwages age english weeks education foregin gender migrant USfarmyears i.year i.region if undocumented==0

//post-estimation tests//

//residuals plot for heteroskedasticity//
rvfplot

//correlation matrix//
correlate

//vifs//
vif



