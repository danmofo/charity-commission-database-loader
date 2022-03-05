create table charity_commission.charity_event_history (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	charity_name varchar(255),
	charity_event_order bigint,
	event_type varchar(255),
	date_of_event date,
	reason varchar(255),
	assoc_organisation_number int,
	assoc_registered_charity_number int,
	assoc_charity_name varchar(255),
	primary key (organisation_number, charity_event_order)
) charset=utf8mb4;

