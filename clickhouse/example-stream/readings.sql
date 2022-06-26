create database kafka;

-- Target table
create table kafka.readings
(
    readings_id Int32 codec (DoubleDelta, LZ4),
    created_at  DateTime codec (DoubleDelta, LZ4),
    temperature Decimal(5, 2) codec (T64, LZ4)
) engine = MergeTree
      order by created_at
      partition by toYYYYMM(created_at);

-- Kafka Engine table
create table kafka.readings_queue
(
    readings_id Int32,
    created_at  DateTime,
    temperature Decimal(5, 2)
) engine = Kafka settings
    kafka_broker_list = 'localhost:9092',
    kafka_topic_list = 'readings',
    kafka_group_name = 'readings_consumer_group1',
    kafka_num_consumers = '1',
    kafka_format = 'CSV';

-- Materialize view to transfer data
create materialized view kafka.readings_queue_mv to kafka.readings as
    select * from kafka.readings_queue;

select count() from kafka.readings_queue_mv;
-- select count() from kafka.readings_queue; -- can't select this
select count() from kafka.readings;
select
    readings_id,
    count()
from kafka.readings
-- from kafka.readings_queue_mv
group by 1;
