LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_governing_document
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	linked_charity_number,
	governing_document_description,
	charitable_objects,
	@area_of_benefit
)
SET
	-- Convert '' to NULL
	area_of_benefit = if(length(@area_of_benefit) = 1, null, @area_of_benefit)