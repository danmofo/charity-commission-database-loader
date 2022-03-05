LOAD DATA LOCAL INFILE 'DATA_PATH'
INTO TABLE charity_commission.charity_event_history
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
	charity_event_order,
	event_type,
	date_of_event,
	@reason,
	@assoc_organisation_number,
	@assoc_registered_charity_number,
	@assoc_charity_name
)
SET
	-- Convert '' to NULL
	reason = nullif(@reason, ''),
	assoc_charity_name = if(length(@assoc_charity_name) = 1, null, @assoc_charity_name),

	-- Convert 0 to NULL
	assoc_registered_charity_number = if(@assoc_registered_charity_number = 0, null, @assoc_registered_charity_number),
	assoc_organisation_number = if(@assoc_organisation_number = 0, null, @assoc_organisation_number)