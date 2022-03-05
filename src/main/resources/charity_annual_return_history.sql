create table charity_commission.charity_annual_return_history (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int, -- regno in the old schema
	fin_period_start_date date,
	fin_period_end_date date,
	ar_cycle_reference varchar(255),
	reporting_due_date date,
	date_annual_return_received date,
	date_accounts_received date,
	total_gross_income decimal,
	total_gross_expenditure decimal,
	accounts_qualified bit,
	suppression_ind bit,
	suppression_type varchar(255),
	primary key (organisation_number, ar_cycle_reference, fin_period_start_date, fin_period_end_date)
) charset=utf8mb4;

