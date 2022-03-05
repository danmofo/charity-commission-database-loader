LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_annual_return_parta
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	@latest_fin_period_submitted,
	fin_period_order_number,
	ar_cycle_reference,
	fin_period_start_date,
	fin_period_end_date,
	ar_due_date,
	ar_received_date,
	total_gross_income,
	total_gross_expenditure,
	@charity_raises_fund_from_public,
	@charity_professional_fundraiser,
	@charity_agreement_professional_fundraiser,
	@charity_commercial_participator,
	@charity_agreement_commercial_participator,
	@grant_making_is_main_activity,
	@charity_receives_govt_funding_contracts,
	count_govt_contracts,
	@charity_receives_govt_funding_grants,
	count_govt_grants,
	income_from_government_contracts,
	income_from_government_grants,
	@charity_has_trading_subsidiary,
	@trustee_also_director_of_subsidiary,
	@does_trustee_receive_any_benefit,
	@trustee_payments_acting_as_trustee,
	@trustee_receives_payments_services,
	@trustee_receives_other_benefit,
	@trustee_resigned_employment,
	@employees_salary_over_60k,
	count_salary_band_60001_70000,
	count_salary_band_70001_80000,
	count_salary_band_80001_90000,
	count_salary_band_90001_100000,
	count_salary_band_100001_110000,
	count_salary_band_110001_120000,
	count_salary_band_120001_130000,
	count_salary_band_130001_140000,
	count_salary_band_140001_150000,
	count_salary_band_150001_200000,
	count_salary_band_200001_250000,
	count_salary_band_250001_250000,
	count_salary_band_300001_350000,
	count_salary_band_350001_400000,
	count_salary_band_400001_450000,
	count_salary_band_450001_500000,
	count_salary_band_over_500000,
	count_volunteers
)

SET 
	-- Convert True/False to 1/0
	latest_fin_period_submitted = if(@latest_fin_period_submitted = 'True', 1, 0),
	charity_raises_fund_from_public = if(@charity_raises_fund_from_public = 'True', 1, 0),
	charity_professional_fundraiser = if(@charity_professional_fundraiser = 'True', 1, 0),
	charity_agreement_professional_fundraiser = if(@charity_agreement_professional_fundraiser = 'True', 1, 0),
	charity_commercial_participator = if(@charity_commercial_participator = 'True', 1, 0),
	charity_agreement_commercial_participator = if(@charity_agreement_commercial_participator = 'True', 1, 0),
	grant_making_is_main_activity = if(@grant_making_is_main_activity = 'True', 1, 0),
	charity_receives_govt_funding_contracts = if(@charity_receives_govt_funding_contracts = 'True', 1, 0),
	charity_receives_govt_funding_grants = if(@charity_receives_govt_funding_grants = 'True', 1, 0),
	charity_has_trading_subsidiary = if(@charity_has_trading_subsidiary = 'True', 1, 0),
	trustee_also_director_of_subsidiary = if(@trustee_also_director_of_subsidiary = 'True', 1, 0),
	does_trustee_receive_any_benefit = if(@does_trustee_receive_any_benefit = 'True', 1, 0),
	trustee_payments_acting_as_trustee = if(@trustee_payments_acting_as_trustee = 'True', 1, 0),
	trustee_receives_payments_services = if(@trustee_receives_payments_services = 'True', 1, 0),
	trustee_receives_other_benefit = if(@trustee_receives_other_benefit = 'True', 1, 0),
	trustee_resigned_employment = if(@trustee_resigned_employment = 'True', 1, 0),
	employees_salary_over_60k = if(@employees_salary_over_60k = 'True', 1, 0)