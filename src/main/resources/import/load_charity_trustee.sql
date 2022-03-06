LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_trustee
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	linked_charity_number,
	trustee_id,
	trustee_name,
	trustee_is_chair,
	individual_or_organisation,
	@trustee_date_of_appointment
)
SET
	-- Convert zero dates to NULL
	trustee_date_of_appointment = if(@trustee_date_of_appointment = 0, null, @trustee_date_of_appointment)