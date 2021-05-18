--  Haversine formula
--  doesn't account for the Earth being a spheroid
--  Source : https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula
create table cities(
	name varchar(50),
    latitude float,
    longitude float
);

insert into cities values
	("Seoul",37.5665,126.9780),
	("New York City",40.7128,-74.006),
    ("London",51.5074,-0.1278),
    ("Singapore",1.3521,103.8198),
    ("Sydney",-33.8688,151.2093);
    
drop function if exists getDistanceFromLatLonInKm;
DELIMITER $$
Create function getDistanceFromLatLonInKm(lat1 float,lon1 float,lat2 float,lon2 float)
	returns float
begin
	declare r float;
    declare dlat float ;
    declare dlon float;
    declare dist float;
    declare a float;
    declare c float;
    set r = 6371;
    set dlat = radians(lat2-lat1);
    set dlon = radians(lon2-lon1);
    set a = pow(sin(dlat/2),2)+cos(radians(lat1))*cos(radians(lat2))*pow(sin(dlon/2),2);
    set c = 2 * atan2(sqrt(a),sqrt(1-a));
    return c*r;
end $$
DELIMITER ;

select concat("From ",city1.name," To ",city2.name) as 'Between', getDistanceFromLatLonInKm(city1.latitude,city1.longitude,city2.latitude,city2.longitude) as 'Distance'
	from cities as city1, cities as city2
    where city1.name="Seoul" and city2.name="London";