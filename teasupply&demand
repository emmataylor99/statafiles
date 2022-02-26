//US Imports-based Supply & Demand Model//

import excel "C:\Users\emmat\OneDrive\Desktop\EconS 490\Tea Supply & Demand (JUST US IMPORTS).xlsx", sheet("Sheet1") firstrow case(lower)

//renaming variables//
rename (importtonnes) (quantity)
rename (subpricecoffee) (coffee)
rename (marketpricetea) (price)
rename (disposableincome) (income)
rename (factorpricewages) (wages)
rename (factorpriceoil) (oil)

//declaring data as time series//

tsset year

//summary stats//

summarize quantity price coffee income wages oil

//original model: OLS for Demand//

 reg quantity price income coffee
 
*testing for heteroskedasticity, autocorrelation, multicollinearity*

*looking for distribution of error, heteroskedasticity*
rvfplot

*Breush-Pagan/Cook-Weisberg heteroskedasticity test*
estat hettest

*note: null hypothesis is no heteroskedasticity*

*testing for multicollinearity*

vif

*testing for autocorrelation*

estat bgodfrey
*note: I found autocorrelation in the original demand model, so I'll go on to correct it*

*correcting for autocorrelation*

prais quantity price coffee income, corc

//original model: OLS for Supply//

reg quantity price wages oil

*looking for distribution of error, heteroskedasticity*
rvfplot

*Breush-Pagan/Cook-Weisberg heteroskedasticity test*
estat hettest

*note: null hypothesis is no heteroskedasticity*

*testing for multicollinearity*

vif

*testing for autocorrelation*

estat bgodfrey

//manual two-stage least squares//

*price prediction using exogeneous variables*
reg price coffee wages income oil

*price prediction*
predict pricehat

*demand equation*
reg quantity pricehat income coffee

*supply equation*
reg quantity pricehat wages oil

//ivregress shortcut//

*demand equation* 
ivregress 2sls quantity coffee income (price = wages oil)

*post-estimation tests*

estat endog
estat firststage
estat overid

*supply equation*
ivregress 2sls quantity wages oil (price = income coffee)

*post-estimation tests*

estat endog
estat firststage
estat overid

*supply equation without overidentification*

ivregress 2sls quantity wages oil (price = income)

estat firststage

ivregress 2sls quantity wages oil (price = coffee)

estat firststage

//elasticities//

//generating log variables to do log-log regression//

gen lnquantity=log(quantity)
gen lnprice=log(price)
gen lncoffee=log(coffee)
gen lnwages=log(wages)
gen lnoil=log(oil)
gen lnincome=log(income)

//log-log demand equation//

ivregress 2sls lnquantity lncoffee lnincome (lnprice = lnwages lnoil)

//log-log supply equation//

ivregress 2sls lnquantity lnwages lnoil (lnprice = lncoffee lnincome)

//log-log demand equation autocorrelation corrected OLS model//

prais lnquantity lnprice lnincome lncoffee, corc


