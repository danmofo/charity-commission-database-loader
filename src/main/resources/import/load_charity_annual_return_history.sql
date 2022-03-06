LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_annual_return_history
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	@fin_period_start_date,
	@fin_period_end_date,
	ar_cycle_reference,
	@reporting_due_date,
	@date_annual_return_received,
	@date_accounts_received,
	total_gross_income,
	total_gross_expenditure,
	@accounts_qualified,
	@suppression_ind,
	@suppression_type
)
SET 
	-- Convert True/False to 1/0
	accounts_qualified = if(@accounts_qualified = 'True', 1, 0),
	suppression_ind = if(@suppression_ind = 'True', 1, 0),

	-- Convert '' to NULL
	suppression_type = nullif(@suppression_type, ''),

	-- Convert zero dates to NULL
	fin_period_start_date = if(@fin_period_start_date = 0, null, @fin_period_start_date),
	fin_period_end_date = if(@fin_period_end_date = 0, null, @fin_period_end_date),
	reporting_due_date = if(@reporting_due_date = 0, null, @reporting_due_date),
	date_annual_return_received = if(@date_annual_return_received = 0, null, @date_annual_return_received),
	date_accounts_received = if(@date_accounts_received = 0, null, @date_accounts_received)
