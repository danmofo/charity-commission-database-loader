create table charity_commission.charity_other_names (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	charity_name_id int,
	charity_name_type varchar(255),
	charity_name varchar(255),
	primary key (organisation_number, charity_name_id)
) charset=utf8mb4;

