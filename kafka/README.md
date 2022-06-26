# Kafka

Follow the quickstart: https://kafka.apache.org/quickstart

## Running on Mac

Resources
- https://hevodata.com/learn/install-kafka-on-mac
- https://medium.com/@Ankitthakur/apache-kafka-installation-on-mac-using-homebrew-a367cdefd273

1. Install Java
    ```sh
    brew tap homebrew/cask
    arch -arm64 brew install java
    echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> ~/.dotfiles/path.zsh
    source ~/.zshrc
    java -version
    ```
2. Install Kafka
    ```sh
    arch -arm64 brew install kafka
    ```
3. Start kafka
    ```
    # brew services start kafka
    # brew services stop kafka
    # or
    zookeeper-server-start /opt/homebrew/etc/kafka/zookeeper.properties
    kafka-server-start /opt/homebrew/etc/kafka/server.properties
    ```
4. Create a topic
    ```sh
    kafka-topics --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic test
    ```
5. List topic
    ```sh
    kafka-topics --list --bootstrap-server localhost:9092
    ```
6. Produce messages
    ```sh
    kafka-console-producer --broker-list localhost:9092 --topic test
    ```
7. Consume messages
    ```sh
    kafka-console-consumer --bootstrap-server localhost:9092 --topic test --from-beginning
    ```
8. Delete topic
    ```sh
    kafka-topics --delete --bootstrap-server localhost:9092 --topic test
    ```
9. Delete all topics
    ```sh
    kafka-topics --delete --bootstrap-server localhost:9092 --topic '*'
    ```
