select
    trip_id,
    pickup_date,
    pickup_ntaname,
    passenger_count,
    tip_amount,
    total_amount
from {{ source('helloworld', 'trips') }}
-- from helloworld.trips
