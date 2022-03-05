create table charity_commission.charity_area_of_operation (
	date_of_extract date,
	organisation_number int,
	registered_charity_number int,
	linked_charity_number int,
	geographic_area_type varchar(255),
	geographic_area_description varchar(255),
	parent_geographic_area_type varchar(255),
	parent_geographic_area_description varchar(255),
	welsh_ind bit,
	primary key (organisation_number, geographic_area_type, geographic_area_description)
) charset=utf8mb4;

