LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_area_of_operation
CHARACTER SET UTF8MB4
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	date_of_extract,
	organisation_number,
	registered_charity_number,
	linked_charity_number,
	geographic_area_type,
	geographic_area_description,
	parent_geographic_area_type,
	parent_geographic_area_description,
	@welsh_ind
)

SET 
	-- Convert True/False to 1/0
	welsh_ind = if(@welsh_ind = 'True', 1, 0),

	-- Convert '' to NULL
	parent_geographic_area_type = nullif(@parent_geographic_area_type, ''),
	parent_geographic_area_description = nullif(@parent_geographic_area_description, '')