create table charity_commission.charity_other_regulators (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	regulator_order bigint,
	regulator_name varchar(255),
	regulator_web_url varchar(255),
	primary key (organisation_number, regulator_order)
) charset=utf8mb4;

