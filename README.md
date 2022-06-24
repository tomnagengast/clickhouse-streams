# Learn Clickhouse

## First locally

## Then on the cloud
1. SSH to the server
2. Open up the required ports
    ```shell
    ufw allow 8123
    ufw allow 9000
    ufw status # show all the rules
    ```
3. Install Clickhouse
    ```shell
    root@bountiful-shelter:/home# mkdir clickhouse
    root@bountiful-shelter:/home# cd clickhouse/
    root@bountiful-shelter:/home/clickhouse# curl https://clickhouse.com/ | sh
    root@bountiful-shelter:/home/clickhouse# sudo ./clickhouse install
    root@bountiful-shelter:/home/clickhouse# sudo clickhouse start
    root@bountiful-shelter:/home/clickhouse# clickhouse-client --password
    ```
4. Connect to the Play interface: http://161.35.112.251:8123/play
5. Start remote client
    ```shell
    ~/clickhouse client --host 161.35.112.251 --password
    ```
6. Follow quickstart: https://clickhouse.com/docs/en/quick-start
7. Upload from local file:
    ```shell
    ~/clickhouse client -h 161.35.112.251 --password \
        --query='insert into helloworld.my_first_table format CSV' < /Users/tomnagengast/Desktop/data.csv
    ```


If this error pops up: `DB::NetException: Connection refused (localhost:9000). (NETWORK_ERROR)`,
check that the service is running:
    ```shell
    service clickhouse-server status
    ```
If it isn't, restart with
    ```shell
    sudo clickhouse start
    > Server started
    ```
