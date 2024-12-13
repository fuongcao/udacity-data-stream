# Run locally using Docker Compose

### Start:

```
docker compose up -d
```
### check again ...
```
docker-compose ps
```

### If you wish to stop and get back to it later, run:

```
docker compose down -v
```
### Removing

Run the following comand to terminate and to remove all volumes and images used:

```
docker compose down --volumes --rmi all
```

### Install Kafka CLI on local

**Install OpenJDK if need**

```
sudo apt-get install openjdk-11-jdk
```

**Download latest version of Apache Kafka from https://kafka.apache.org/downloads**

```
wget https://downloads.apache.org/kafka/3.9.0/kafka_2.12-3.9.0.tgz
tar xzf kafka_2.12-3.9.0.tgz
```

**Setup the $PATH environment variable**

```
sudo vi ~/.bashrc
```

and add

```
PATH="$PATH:~/kafka_2.12-3.9.0/bin"
alias kafka-topics=kafka-topics.sh
alias kafka-console-producer=kafka-console-producer.sh
alias kafka-console-consumer=kafka-console-consumer.sh
```

###

**First, let's create a topic**

```
kafka-topics --create --topic kafka-arch --partitions 1 --replication-factor 1 --bootstrap-server localhost:9092
```

```
kafka-topics --bootstrap-server localhost:9092 --list
```

Note: Kafka v2.2+ : --bootstrap-server replaced for --zookeeper

**We have the "kafka-arch" topic, let's produce some data into it**

```
kafka-console-producer --topic "kafka-arch" --broker-list localhost:9092
```

**let's consume the data from the "kafka-arch" topic**

```
kafka-console-consumer --bootstrap-server localhost:9092 --topic org.chicago.cta.station.arrivals.35th_bronzeville_iit --from-beginning
```

```
kafka-console-consumer --bootstrap-server localhost:9092 --topic org.chicago.cta.station.turnstiles --from-beginning
```
