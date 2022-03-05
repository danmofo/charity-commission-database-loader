create table charity_commission.charity_trustee (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	trustee_id int,
	trustee_name varchar(255),
	trustee_is_chair bit,
	individual_or_organisation char,
	trustee_date_of_appointment date,
	primary key (organisation_number, trustee_id)
) charset=utf8mb4;

