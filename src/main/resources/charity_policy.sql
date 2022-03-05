create table charity_commission.charity_policy (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	policy_name varchar(255),
	primary key (organisation_number, policy_name)
) charset=utf8mb4;

