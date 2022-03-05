create table charity_commission.charity_governing_document (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	governing_document_description text,
	charitable_objects text,
	area_of_benefit varchar(255),
	primary key (organisation_number)
) charset=utf8mb4;

