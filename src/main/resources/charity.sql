create table charity_commission.charity (
	date_of_extract date,
	organisation_number int primary key,
	registered_charity_number int, -- regno in the old schema
	linked_charity_number int, -- subno in the old schema, 0 means they're the parent charity
	charity_name varchar(255),
	charity_type varchar(255), -- only the parent has a value for this
	charity_registration_status varchar(255),
	date_of_registration date,
	date_of_removal date, -- date they were removed from the register, not when they ceased to exist
	charity_reporting_status varchar(255),
	latest_acc_fin_period_start_date date,
	latest_acc_fin_period_end_date date,
	latest_income decimal,
	latest_expenditure decimal,
	charity_contact_address1 varchar(255),
	charity_contact_address2 varchar(255),
	charity_contact_address3 varchar(255),
	charity_contact_address4 varchar(255),
	charity_contact_address5 varchar(255),
	charity_contact_postcode varchar(255),
	charity_contact_phone varchar(255),
	charity_contact_email varchar(255),
	charity_contact_web varchar(255),
	charity_company_registration_number varchar(255),
	charity_insolvent bit,
	charity_in_administration bit,
	charity_previously_excepted bit,
	charity_is_cdf_or_cif varchar(255),
	charity_is_cio bit,
	cio_is_dissolved bit,
	date_cio_dissolution_notice date,
	charity_activities text,
	charity_gift_aid varchar(255),
	charity_has_land bit
) charset=utf8mb4;

