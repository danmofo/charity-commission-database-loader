create table charity_commission.charity_published_report (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	report_name varchar(255),
	report_location varchar(255),
	date_published date,
	primary key (organisation_number, report_name, report_location)
) charset=utf8mb4;

