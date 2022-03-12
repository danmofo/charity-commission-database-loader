LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	linked_charity_number,
	charity_name,
	charity_type,
	charity_registration_status,
	@date_of_registration,
	@date_of_removal,
	charity_reporting_status,
	@latest_acc_fin_period_start_date,
	@latest_acc_fin_period_end_date,
	latest_income,
	latest_expenditure,
	@charity_contact_address1,
	@charity_contact_address2,
	@charity_contact_address3,
	@charity_contact_address4,
	@charity_contact_address5,
	@charity_contact_postcode,
	@charity_contact_phone,
	@charity_contact_email,
	@charity_contact_web,
	@charity_company_registration_number,
	@charity_insolvent,
	@charity_in_administration,
	@charity_previously_excepted,
	charity_is_cdf_or_cif,
	@charity_is_cio,
	@cio_is_dissolved,
	@date_cio_dissolution_notice,
	@charity_activities,
	@charity_gift_aid,
	@charity_has_land
)
SET 
	-- Convert True/False to 1/0
	charity_insolvent = if(@charity_insolvent = 'True', 1, 0),
	charity_in_administration = if(@charity_in_administration = 'True', 1, 0),
	charity_previously_excepted = if(@charity_previously_excepted = 'True', 1, 0),
	charity_is_cio = if(@charity_is_cio = 'True', 1, 0),
	cio_is_dissolved = if(@cio_is_dissolved = 'True', 1, 0),
	charity_has_land = if(@charity_has_land = 'True', 1, 0),

	-- Special field which has three states
	charity_gift_aid = if(
		@charity_gift_aid = 'True', 
		'Yes', 
		if(@charity_gift_aid = 'False', 'No', 'Unknown')
	),

	-- Convert '' to NULL
	charity_contact_address1 = nullif(@charity_contact_address1, ''),
	charity_contact_address2 = nullif(@charity_contact_address2, ''),
	charity_contact_address3 = nullif(@charity_contact_address3, ''),
	charity_contact_address4 = nullif(@charity_contact_address4, ''),
	charity_contact_address5 = nullif(@charity_contact_address5, ''),
	charity_contact_postcode = nullif(@charity_contact_postcode, ''),
	charity_contact_phone = nullif(@charity_contact_phone, ''),
	charity_contact_email = nullif(@charity_contact_email, ''),
	charity_contact_web = if(
		@charity_contact_web = '',
		null,
		lower(
			if(
				locate('http', @charity_contact_web) = 1,
				@charity_contact_web,
				concat('https://', @charity_contact_web)
			)
		)
	),
	charity_company_registration_number = nullif(@charity_company_registration_number, ''),
	charity_activities = nullif(@charity_activities, ''),

	-- Convert zero dates to NULL
	date_of_registration = if(@date_of_registration = 0, null, @date_of_registration),
	date_of_removal = if(@date_of_removal = 0, null, @date_of_removal),
	date_cio_dissolution_notice = if(@date_cio_dissolution_notice = 0, null, @date_cio_dissolution_notice),
	latest_acc_fin_period_start_date = if(@latest_acc_fin_period_start_date = 0, null, @latest_acc_fin_period_start_date),
	latest_acc_fin_period_end_date = if(@latest_acc_fin_period_end_date = 0, null, @latest_acc_fin_period_end_date)