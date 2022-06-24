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
    #  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    #                                 Dload  Upload   Total   Spent    Left  Speed
    #100  1292    0  1292    0     0    994      0 --:--:--  0:00:01 --:--:--   993
    #
    #Will download https://builds.clickhouse.com/master/amd64/clickhouse
    #
    #  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    #                                 Dload  Upload   Total   Spent    Left  Speed
    #100 2109M  100 2109M    0     0  29.5M      0  0:01:11  0:01:11 --:--:-- 56.4M
    #
    #Successfully downloaded the ClickHouse binary, you can run it as:
    #    ./clickhouse
    #
    #You can also install it:
    #    sudo ./clickhouse install
    root@bountiful-shelter:/home/clickhouse# sudo ./clickhouse install
    #Copying ClickHouse binary to /usr/bin/clickhouse.new
    #Renaming /usr/bin/clickhouse.new to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-server to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-client to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-local to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-benchmark to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-copier to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-obfuscator to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-git-import to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-compressor to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-format to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-extract-from-config to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-keeper to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-keeper-converter to /usr/bin/clickhouse.
    #Creating symlink /usr/bin/clickhouse-disks to /usr/bin/clickhouse.
    #Creating clickhouse group if it does not exist.
    # groupadd -r clickhouse
    #Creating clickhouse user if it does not exist.
    # useradd -r --shell /bin/false --home-dir /nonexistent -g clickhouse clickhouse
    #Will set ulimits for clickhouse user in /etc/security/limits.d/clickhouse.conf.
    #Creating config directory /etc/clickhouse-server.
    #Creating config directory /etc/clickhouse-server/config.d that is used for tweaks of main server configuration.
    #Creating config directory /etc/clickhouse-server/users.d that is used for tweaks of users configuration.
    #Data path configuration override is saved to file /etc/clickhouse-server/config.d/data-paths.xml.
    #Log path configuration override is saved to file /etc/clickhouse-server/config.d/logger.xml.
    #User directory path configuration override is saved to file /etc/clickhouse-server/config.d/user-directories.xml.
    #OpenSSL path configuration override is saved to file /etc/clickhouse-server/config.d/openssl.xml.
    #Creating log directory /var/log/clickhouse-server.
    #Creating data directory /var/lib/clickhouse.
    #Creating pid directory /var/run/clickhouse-server.
    # chown -R clickhouse:clickhouse '/var/log/clickhouse-server'
    # chown -R clickhouse:clickhouse '/var/run/clickhouse-server'
    # chown  clickhouse:clickhouse '/var/lib/clickhouse'
    #Enter password for default user: 
    #Password for default user is saved in file /etc/clickhouse-server/users.d/default-password.xml.
    #Setting capabilities for clickhouse binary. This is optional.
    #Allow server to accept connections from the network (default is localhost only), [y/N]: y
    #The choice is saved in file /etc/clickhouse-server/config.d/listen.xml.
    # chown -R clickhouse:clickhouse '/etc/clickhouse-server'
    #
    #ClickHouse has been successfully installed.
    #
    #Start clickhouse-server with:
    # sudo clickhouse start
    #
    #Start clickhouse-client with:
    # clickhouse-client --password
    
    root@bountiful-shelter:/home/clickhouse# sudo clickhouse start
    root@bountiful-shelter:/home/clickhouse# clickhouse-client --password
    #ClickHouse client version 22.7.1.614 (official build).
    #Password for user (default): 
    #Connecting to localhost:9000 as user default.
    #Connected to ClickHouse server version 22.7.1 revision 54456.
    #
    #Warnings:
    # * Linux is not using a fast TSC clock source. Performance can be degraded. Check /sys/devices/system/clocksource/clocksource0/current_clocksource
    # * Linux threads max count is too low. Check /proc/sys/kernel/threads-max
    # * Available memory at server startup is too low (2GiB).
    # * Maximum number of threads is lower than 30000. There could be problems with handling a lot of simultaneous queries.
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
