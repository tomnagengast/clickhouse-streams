-- Quickstart: https://clickhouse.com/docs/en/quick-start
-- Play: http://161.35.112.251:8123/play
-- Upload CSV with:
-- ~/clickhouse client -h 161.35.112.251 --password \
--     --query='insert into helloworld.my_first_table format CSV' < /Users/tomnagengast/Desktop/data.csv
show databases;

create database if not exists helloworld;

create table helloworld.my_first_table
(
    user_id   UInt32,
    message   String,
    timestamp DateTime,
    metric    Float32
)
    engine = MergeTree()
        primary key (user_id, timestamp);

insert into
    helloworld.my_first_table (user_id, message, timestamp, metric)
values
    (101, 'Hello, ClickHouse!', now(), -1.0),
    (102, 'Insert a lot of rows per batch', yesterday(), 1.41421),
    (102, 'Sort your data based on your commonly-used queries', today(), 2.718),
    (101, 'Granules are the smallest chunks of data read', now() + 5, 3.14159);

SELECT *
FROM helloworld.my_first_table
ORDER BY timestamp
FORMAT TabSeparated;
