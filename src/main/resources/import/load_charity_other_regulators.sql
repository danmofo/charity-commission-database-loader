LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_other_regulators
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	regulator_order,
	regulator_name,
	@regulator_web_url
)
SET
	-- Convert '' to NULL
	regulator_web_url = if(length(@regulator_web_url) = 1, null, @regulator_web_url)