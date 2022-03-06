LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_annual_return_partb
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	@latest_fin_period_submitted_ind,
	fin_period_order_number,
	ar_cycle_reference,
	@fin_period_start_date,
	@fin_period_end_date,
	@ar_due_date,
	@ar_received_date,
	income_donations_and_legacies,
	income_charitable_activities,
	income_other_trading_activities,
	income_investments,
	income_other,
	income_total_income_and_endowments,
	income_legacies,
	income_endowments,
	expenditure_raising_funds,
	expenditure_charitable_expenditure,
	expenditure_other,
	expenditure_total,
	expenditure_investment_management,
	expenditure_grants_institution,
	expenditure_governance,
	expenditure_support_costs,
	expenditure_depreciation,
	gain_loss_investment,
	gain_loss_pension_fund,
	gain_loss_revaluation_fixed_investment,
	gain_loss_other,
	reserves,
	assets_total_fixed,
	assets_own_use,
	assets_long_term_investment,
	defined_benefit_pension_scheme,
	assets_other_assets,
	assets_total_liabilities,
	assets_current_investment,
	assets_total_assets_and_liabilities,
	creditors_one_year_total_current,
	creditors_falling_due_after_one_year,
	assets_cash,
	funds_endowment,
	funds_unrestricted,
	funds_restricted,
	funds_total,
	count_employees,
	@charity_only_accounts,
	@consolidated_accounts
)

SET 
	-- Convert True/False to 1/0
	latest_fin_period_submitted_ind = if(@latest_fin_period_submitted_ind = 'True', 1, 0),
	charity_only_accounts = if(@charity_only_accounts = 'True', 1, 0),
	consolidated_accounts = if(@consolidated_accounts = 'True', 1, 0),

	-- Convert zero dates to NULL
	fin_period_start_date = if(@fin_period_start_date = 0, null, @fin_period_start_date),
	fin_period_end_date = if(@fin_period_end_date = 0, null, @fin_period_end_date),
	ar_due_date = if(@ar_due_date = 0, null, @ar_due_date),
	ar_received_date = if(@ar_received_date = 0, null, @ar_received_date)