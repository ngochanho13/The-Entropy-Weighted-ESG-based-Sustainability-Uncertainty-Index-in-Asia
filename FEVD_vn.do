
* Encode panel id & xtset
encode Country, gen(Country_id)
xtset Country_id Year, yearly

gen EW_ESGUI_diff = D.EW_ESGUI
gen ESGUI_diff = D.ESGUI
gen INF_diff       = D.INF
gen CO2E_diff       = D.CO2E
gen AFF_diff       = D.AFF
gen UT_diff    = D.UT
gen LPR_diff   = D.LPR 

* ENVIRONMENT

varsoc EW_ESGUI_diff AFF_diff CO2E_diff  , maxlag(10)

*==== 2) Ước lượng VAR (ví dụ p=1 hoặc theo varsoc) ====
var EW_ESGUI_diff  AFF_diff CO2E_diff , lags(1)

*==== 3) Tạo IRF/FEVD với 10 kỳ (step=10) 90% CI, Cholesky ====
local H = 8
irf set myirf, replace
irf create base, step(`H') level(90)  
  
* Kiểm tra đã tạo đủ 10 kỳ chưa
irf describe base

*==== 4) Bảng FEVD (10 kỳ) ====
irf table fevd, irf(base) step(`H')
irf table fevd, irf(base) impulse(EW_ESGUI_diff ) step(`H')
irf graph oirf, irf(base) impulse(EW_ESGUI_diff ) response(AFF_diff CO2E_diff) byopts(title("IRF (Cholesky, 90% CI)")cols(1) yrescale xrescale) yscale(range(-1 1)) ysize(6) xsize(7) scheme(s1color)

* SOCIAL
*==== 1) Chọn độ trễ (xem gợi ý) ====
varsoc EW_ESGUI_diff UT_diff PG , maxlag(10)

*==== 2) Ước lượng VAR (ví dụ p=1 hoặc theo varsoc) ====
var EW_ESGUI_diff  UT_diff PG , lags(1)

*==== 3) Tạo IRF/FEVD với 10 kỳ (step=10) 90% CI, Cholesky ====
local H = 8
irf set myirf, replace
irf create base, step(`H') level(90)  
  
* Kiểm tra đã tạo đủ 10 kỳ chưa
irf describe base

*==== 4) Bảng FEVD (10 kỳ) ====
irf table fevd, irf(base) step(`H')
irf table fevd, irf(base) impulse(EW_ESGUI_diff) step(`H')
*==== 5) Vẽ IRF (10 kỳ) ====

irf graph oirf, irf(base) impulse(EW_ESGUI_diff) response(UT_diff PG) byopts(title("IRF (Cholesky, 90% CI)") cols(1) yrescale xrescale) yscale(range(-1 1)) ysize(6) xsize(7) scheme(s1color)

* GOV
*==== 1) Chọn độ trễ (xem gợi ý) ====
varsoc EW_ESGUI_diff  GDP INF_diff, maxlag(10)

*==== 2) Ước lượng VAR (ví dụ p=1 hoặc theo varsoc) ====
var EW_ESGUI_diff  GDP INF_diff, lags(1)

*==== 3) Tạo IRF/FEVD với 10 kỳ (step=10) 90% CI, Cholesky ====
local H = 8
irf set myirf, replace
irf create base, step(`H') level(90)  
  
* Kiểm tra đã tạo đủ 10 kỳ chưa
irf describe base

*==== 4) Bảng FEVD (10 kỳ) ====
irf table fevd, irf(base) step(`H')
* Hoặc chỉ shock ESGUI_new_diff:
irf table fevd, irf(base) impulse(EW_ESGUI_diff) step(`H')

*==== 5) Vẽ IRF (10 kỳ) ====
**# Bookmark #1

irf graph oirf, irf(base) impulse(EW_ESGUI_diff) response(GDP INF_diff) byopts(title("IRF (Cholesky, 90% CI)") cols(1) yrescale xrescale) yscale(range(-1 1)) ysize(6) xsize(7) scheme(s1color)



* ESGUI CŨ

varsoc ESGUI_diff AFF_diff CO2E_diff  , maxlag(10)

*==== 2) Ước lượng VAR (ví dụ p=1 hoặc theo varsoc) ====
var ESGUI_diff  AFF_diff CO2E_diff , lags(1)

*==== 3) Tạo IRF/FEVD với 10 kỳ (step=10) 90% CI, Cholesky ====
local H = 8
irf set myirf, replace
irf create base, step(`H') level(90)  
  
* Kiểm tra đã tạo đủ 10 kỳ chưa
irf describe base

*==== 4) Bảng FEVD (10 kỳ) ====
irf table fevd, irf(base) step(`H')
irf table fevd, irf(base) impulse(ESGUI_diff ) step(`H')
irf graph oirf, irf(base) impulse(ESGUI_diff ) response(AFF_diff CO2E_diff) byopts(title("IRF (Cholesky, 90% CI)")cols(1) yrescale xrescale) yscale(range(-1 1)) ysize(6) xsize(7) scheme(s1color)

* SOCIAL
*==== 1) Chọn độ trễ (xem gợi ý) ====
varsoc ESGUI_diff UT_diff PG , maxlag(10)

*==== 2) Ước lượng VAR (ví dụ p=1 hoặc theo varsoc) ====
var ESGUI_diff  UT_diff PG , lags(1)

*==== 3) Tạo IRF/FEVD với 10 kỳ (step=10) 90% CI, Cholesky ====
local H = 8
irf set myirf, replace
irf create base, step(`H') level(90)  
  
* Kiểm tra đã tạo đủ 10 kỳ chưa
irf describe base

*==== 4) Bảng FEVD (10 kỳ) ====
irf table fevd, irf(base) step(`H')
irf table fevd, irf(base) impulse(ESGUI_diff) step(`H')
*==== 5) Vẽ IRF (10 kỳ) ====

irf graph oirf, irf(base) impulse(ESGUI_diff) response(UT_diff PG) byopts(title("IRF (Cholesky, 90% CI)") cols(1) yrescale xrescale) yscale(range(-1 1)) ysize(6) xsize(7) scheme(s1color)

* GOV
*==== 1) Chọn độ trễ (xem gợi ý) ====
varsoc ESGUI_diff  GDP INF_diff, maxlag(10)

*==== 2) Ước lượng VAR (ví dụ p=1 hoặc theo varsoc) ====
var ESGUI_diff  GDP INF_diff, lags(1)

*==== 3) Tạo IRF/FEVD với 10 kỳ (step=10) 90% CI, Cholesky ====
local H = 8
irf set myirf, replace
irf create base, step(`H') level(90)  
  
* Kiểm tra đã tạo đủ 10 kỳ chưa
irf describe base

*==== 4) Bảng FEVD (10 kỳ) ====
irf table fevd, irf(base) step(`H')
* Hoặc chỉ shock ESGUI_new_diff:
irf table fevd, irf(base) impulse(ESGUI_diff) step(`H')

*==== 5) Vẽ IRF (10 kỳ) ====
**# Bookmark #1

irf graph oirf, irf(base) impulse(ESGUI_diff) response(GDP INF_diff) byopts(title("IRF (Cholesky, 90% CI)") cols(1) yrescale xrescale) yscale(range(-1 1)) ysize(6) xsize(7) scheme(s1color)













