drop table trips;
create table trips
(
    trip_id               UInt32,
    vendor_id             Enum8('1' = 1, '2' = 2, '3' = 3, '4' = 4, 'CMT' = 5, 'VTS' = 6, 'DDS' = 7, 'B02512' = 10, 'B02598' = 11, 'B02617' = 12, 'B02682' = 13, 'B02764' = 14, '' = 15),
    pickup_date           Date,
    pickup_datetime       DateTime,
    dropoff_date          Date,
    dropoff_datetime      DateTime,
    store_and_fwd_flag    UInt8,
    rate_code_id          UInt8,
    pickup_longitude      Float64,
    pickup_latitude       Float64,
    dropoff_longitude     Float64,
    dropoff_latitude      Float64,
    passenger_count       UInt8,
    trip_distance         Float64,
    fare_amount           Float32,
    extra                 Float32,
    mta_tax               Float32,
    tip_amount            Float32,
    tolls_amount          Float32,
    ehail_fee             Float32,
    improvement_surcharge Float32,
    total_amount          Float32,
    payment_type          Enum8('UNK' = 0, 'CSH' = 1, 'CRE' = 2, 'NOC' = 3, 'DIS' = 4),
    trip_type             UInt8,
    pickup                FixedString(25),
    dropoff               FixedString(25),
    cab_type              Enum8('yellow' = 1, 'green' = 2, 'uber' = 3),
    pickup_nyct2010_gid   Int8,
    pickup_ctlabel        Float32,
    pickup_borocode       Int8,
    pickup_ct2010         String,
    pickup_boroct2010     String,
    pickup_cdeligibil     String,
    pickup_ntacode        FixedString(4),
    pickup_ntaname        String,
    pickup_puma           UInt16,
    dropoff_nyct2010_gid  UInt8,
    dropoff_ctlabel       Float32,
    dropoff_borocode      UInt8,
    dropoff_ct2010        String,
    dropoff_boroct2010    String,
    dropoff_cdeligibil    String,
    dropoff_ntacode       FixedString(4),
    dropoff_ntaname       String,
    dropoff_puma          UInt16
)
    engine = MergeTree
        partition by toYYYYMM(pickup_date)
        order by pickup_datetime;


insert into trips
select * from s3(
        'https://datasets-documentation.s3.eu-west-3.amazonaws.com/nyc-taxi/trips_{1..2}.gz',
        'TabSeparatedWithNames'
    );

select * from trips limit 10;

select count() from trips;

select distinct(pickup_ntaname) from trips;

select avg(tip_amount) from trips;

select
    passenger_count,
    ceil(avg(total_amount), 2) as average_total_amount
from trips
group by 1;

select
    pickup_date,
    pickup_ntaname,
    SUM(1) as number_of_trips
from trips
group by pickup_date, pickup_ntaname
order by pickup_date;

select
    avg(tip_amount) as avg_tip,
    avg(fare_amount) as avg_fare,
    avg(passenger_count) as avg_passenger,
    count() as count,
    truncate(date_diff('second', pickup_datetime, dropoff_datetime) / 3600) as trip_minutes
from trips
where trip_minutes > 0
group by trip_minutes
order by trip_minutes desc;

select
    pickup_datetime,
    dropoff_datetime,
    total_amount,
    pickup_nyct2010_gid,
    dropoff_nyct2010_gid,
    case
        when dropoff_nyct2010_gid = 138 then 'LGA'
        when dropoff_nyct2010_gid = 132 then 'JFK'
        end as airport_code,
    EXTRACT(year from pickup_datetime) as year,
    EXTRACT(day from pickup_datetime) as day,
    EXTRACT(hour from pickup_datetime) as hour
from trips
where dropoff_nyct2010_gid in (132, 138)
order by pickup_datetime;

create dictionary taxi_zone_dictionary (
    LocationID UInt16 default 0,
    Borough String,
    Zone String,
    service_zone String
    )
    primary key LocationID
    source (HTTP(
        url 'https://datasets-documentation.s3.eu-west-3.amazonaws.com/nyc-taxi/taxi_zone_lookup.csv'
        format 'CSVWithNames'
        ))
    lifetime (0)
    layout (HASHED());

select * from taxi_zone_dictionary;

select dictGet('taxi_zone_dictionary', 'Borough', 132) as Borough;
select dictHas('taxi_zone_dictionary', 4567) as Borough;

select
    count(1) as total,
    Borough
from trips
join taxi_zone_dictionary
on toUInt64(trips.pickup_nyct2010_gid) = taxi_zone_dictionary.LocationID
where dropoff_nyct2010_gid = 132
   or dropoff_nyct2010_gid = 138
group by Borough
order by total desc;
