LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_other_names
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	linked_charity_number,
	charity_name_id,
	charity_name_type,
	charity_name
)