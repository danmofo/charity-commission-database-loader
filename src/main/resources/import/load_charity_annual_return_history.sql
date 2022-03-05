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
	fin_period_start_date,
	fin_period_end_date,
	ar_cycle_reference,
	reporting_due_date,
	date_annual_return_received,
	date_accounts_received,
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
	suppression_type = nullif(@suppression_type, '')