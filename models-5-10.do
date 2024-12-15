use "\\apporto.com\dfs\NTHW\Users\bmh7505_nthw\Desktop\Nel and Righarts ND and VCC final 20 June 2007"

* Ensure the data is sorted by state and year for lagged variables
sort state year

* Generate lagged variables
gen imr_lag1 = imr[_n-1] if state == state[_n-1]
gen imr_sq_lag1 = imr_sq[_n-1] if state == state[_n-1]
gen vccall_tp1 = vccall[_n+1] if state == state[_n+1]  // For t+1 dependent variable

* Model 1
relogit vccall allND_pc imr_lag1 imr_sq_lag1 mixedx gdpgrox brevity
outreg2 using "regression_results.doc", append ctitle(Model 1)

* Model 2
relogit vccall allND_pc imr_lag1 imr_sq_lag1 mixed gdpgro brevity
outreg2 using "regression_results.doc", append ctitle(Model 2)

* Model 3
relogit vccall allND_pc gdppc_ln mixed gdpgro brevity
outreg2 using "regression_results.doc", append ctitle(Model 3)

* Model 4
relogit vccall allND_pc mixed gdpgro youth_bulge brevity
outreg2 using "regression_results.doc", append ctitle(Model 4)

* Model 5
relogit vccall_tp1 allND_pc imr_lag1 imr_sq_lag1 mixed gdpgro brevity
outreg2 using "regression_results.doc", append ctitle(Model 5)

* Open the results table
shell "regression_results.doc"
