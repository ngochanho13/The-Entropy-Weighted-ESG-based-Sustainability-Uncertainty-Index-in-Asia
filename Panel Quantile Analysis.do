* SET UP 
egen missings = rowmiss(*)
drop if missings > 0
encode Country, gen(Country_id)
xtset Country_id Year, yearly

* DESCRIPTIVE STATISTIC
xtdescribe
summarize, detail
tabstat EW_ESGUI INF AFF LPR UT PG GDP FDI WUI REEC TO EUI CO2E, statistics(n mean sd min p25 median p75 max) columns(statistics)
tabstat EW_ESGUI INF AFF LPR UT PG GDP FDI WUI REEC TO EUI CO2E, by(Country_id) statistics(n mean sd)
misstable summarize

* NOMALITY TEST
sktest REEC EW_ESGUI GDP FDI WUI TO EUI CO2E
gen lnREEC = ln(REEC)

* CROSS SECTIONAL DEPENDENCE 
xtcdf lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E

* SLOPE HOMOGENEITY TEST
xthst lnREEC EW_ESGUI CO2E EUI GDP TO WUI FDI

* STATIONARY TEST
xtcips EW_ESGUI, maxlags(2) bglags(1)
xtcips d.EW_ESGUI, maxlags(2) bglags(1)
xtcips lnREEC, maxlags(2) bglags(1)
xtcips d.lnREEC, maxlags(2) bglags(1)
xtcips GDP, maxlags(2) bglags(1)
xtcips d.GDP, maxlags(2) bglags(1)
xtcips WUI, maxlags(2) bglags(1)
xtcips d.WUI, maxlags(2) bglags(1)
xtcips TO, maxlags(2) bglags(1)
xtcips d.TO, maxlags(2) bglags(1)
xtcips EUI, maxlags(2) bglags(1)
xtcips d.EUI, maxlags(2) bglags(1)
xtcips CO2E, maxlags(2) bglags(1)
xtcips d.CO2E, maxlags(2) bglags(1)
xtcips FDI, maxlags(2) bglags(1)
xtcips d.FDI, maxlags(2) bglags(1)

* COINTEGRATION
xtwest lnREEC EUI CO2E WUI FDI TO, lags(1) leads(0) lrwindow(3) bootstrap(100)

* MMQR
mmqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, q(25)
mmqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, q(50)
mmqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, q(75)
mmqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, q(90)

* Bootstrapped quantile regression
bsqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, quantile(0.1) reps(500)
bsqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, quantile(0.25) reps(500)
bsqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, quantile(0.5) reps(500)
bsqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, quantile(0.75) reps(500)
bsqreg lnREEC EW_ESGUI GDP FDI WUI TO EUI CO2E, quantile(0.9) reps(500)

* Causality analysis
ssc install xtgcause
xtgcause lnREEC EW_ESGUI
xtgcause lnREEC GDP
xtgcause lnREEC FDI
xtgcause lnREEC WUI
xtgcause lnREEC TO
xtgcause lnREEC EUI
xtgcause lnREEC CO2E