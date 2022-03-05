create table charity_commission.charity_classification (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	classification_code int,
	classification_type varchar(255),
	classification_description varchar(255),
	primary key (organisation_number, classification_code)
) charset=utf8mb4;

