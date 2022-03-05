LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_published_report
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	linked_charity_number,
	report_name,
	report_location,
	date_published
)