//do-file for undergraduate honors thesis by Emma Taylor//
//All's Fair in Love and War: Fairness, Cooperation, and Competition in Love Island//

clear

//Survival Analysis Data//
use "C:\Users\emmat\OneDrive\Desktop\Love Island Thesis\Data\LoveIslandThesis_SurvivalTraitsData.dta"

//Summary statistics for anti-social behavior points//
by season, sort: sum points

//Summary statistics for characteristic data//
by season, sort: sum age height gender hair eye race model trainer athlete essex london

//Setting the data as survival analysis data//
stset survivaltime, failure(fail==1)

//Cox Proportional Hazard Regression Model for Weighted Points//
stcox points

//Proportional Hazard Assumption Test//
estat phtest
**PH test interpretation: p>.05, fail to reject assumption of proportional hazard**

//Cox PHM Regression for Weighted Points and Characteristic Data//
stcox points age height gender hair eye race model trainer athlete essex london

//Proportional Hazard Assumption Test//
estat phtest
**PH test interpretation: p>.05, fail to reject assumption of proportional hazard**

//Switching to Audience Vote Data Set//
clear

use "C:\Users\emmat\OneDrive\Desktop\Love Island Thesis\Data\LoveIslandThesis_AudienceVoteData.dta"

//Summary statistics for Audience Vote Data//
sum vote points epsin romantic

//Baseline OLS of Audience Vote Data//
reg vote points romantic epsin

//Heteroskedasticity Test//
estat hettest

//Multicollinearity Test, VIFs//
vif

//Summary statistics for logged variables//
sum logpoints logeps logvote

//Log-Log Form OLS of Audience Vote Data//
reg logvote logeps logpoints romantic

//Heteroskedasticity Test//
estat hettest

//Multicollinearity Test, VIFs//
vif
