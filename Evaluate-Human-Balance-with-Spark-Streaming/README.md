# Evaluate Human Balance with Spark Streaming
## STEDI Ecosystem

You work for the data science team at STEDI, a small startup focused on assessing balance for seniors. STEDI has an application that collects data from seniors during a small exercise. The user logs in, and then selects the customer they are working with. Then the user starts a timer, and clicks a button with each step the senior takes. When the senior has reached 30 steps, their test is finished. The data transmitted enables the application to monitor seniors’ balance risk. 

## STEDI STREAMING DIAGRAM
![STEDI-Project.png](images/STEDI-Project.png)

* The STEDI data science team has configured some real-time data sources using Kafka Connect. One of those data sources is Redis. When a customer is first assessed in the STEDI application, their record  is added to a sorted set called Customer in redis. Redis is running in a docker container on the default redis port (6379). Redis is configured as a Kafka source, and whenever any data is saved to Redis (including Customer information), a payload is published to the Kafka topic called redis-server.
----
* The application development team has programmed certain business events to be published automatically to Kafka. Whenever a customer takes an assessment, their risk score is generated, as long as they have four or more completed assessments. The risk score is transmitted to a Kafka topic called `stedi-events`. The `stedi-events` Kafka topic has a String key and a String value as a JSON object with this format:

    ```json
    {"customer":"Jason.Mitra@test.com",
    "score":7.0,
    "riskDate":"2020-09-14T07:54:06.417Z"
    }
    ```
* The application development team was not able to complete the feature as the graph is currently not receiving any data. Because the graph is currently not receiving any data, you need to generate a new payload in a Kafka topic and make it available to the STEDI application to consume. The new Kafka topic to transmit the complete risk score with birth date, so the data can be viewed in the STEDI application graph.
    ```json
    {"customer":"Santosh.Fibonnaci@test.com",
    "score":"28.5",
    "email":"Santosh.Fibonnaci@test.com",
    "birthYear":"1963"
    } 
    ```
* Once the data is populated in the configured kafka topic, the graph should have real-time data points
----
# PROJECT RUBRIC

## Initialize Spark Components
1. Start a Spark cluster. The log contains a statement “Successfully registered with master spark”
- [spark/logs/spark-master.log](spark/logs/spark-master.log)
- [spark/logs/spark-worker.log](spark/logs/spark-worker.log)

2. The Spark application successfully executes on the Spark cluster.
- [spark/logs/kafkajoinconsole.log](spark/logs/kafkajoinconsole.log)


## Continuous Application
1. The data pipeline provides continuous output of customer risk scores
![risk-graph-1.png](images/risk-graph-1.png)
![risk-graph-2.png](images/risk-graph-2.png)
2. The spark streaming application doesn’t exit prematurely  
- [sparkpykafkajoin.py](sparkpykafkajoin.py)
![customer-risk.png](images/customer-risk.png)

## Consume and Process Data
1. The spark streaming application consumes data from the redis-server Kafka topic
2. The spark streaming application consumes data from the stedi-events Kafka topic
3. The spark streaming application parses JSON and Base64 decodes (where applicable) the data received from Kafka
- [sparkpykafkajoin.py](sparkpykafkajoin.py)

##  Aggregation of Streaming Dataframes
1. The Spark streaming application instantiates two distinct streaming dataframes
2. The Spark streaming application joins the two streaming dataframes emailAndBirthYear and emailAndRiskScore to create riskScoreByBirthYear
- [sparkpykafkajoin.py](sparkpykafkajoin.py)

## Sink Datastream
1. The spark streaming application produces a sink to Kafka  
![docker-compose.png](images/docker-compose.png)
2. The streaming dataframe being sinked with Kafka contains JSON formatted data  
![custumer-risk-logs.png](images/custumer-risk-logs.png)

## Validation
1. Outputs a log which contains customer risk information in a console output format  
- [sparkpyeventskafkastreamtoconsole.py](sparkpyeventskafkastreamtoconsole.py)  
- [spark/logs/eventstream.log](spark/logs/eventstream.log)  
![sparkpyeventskafkastreamtoconsole.png](images/sparkpyeventskafkastreamtoconsole.png)  

2. Outputs a log which contains customer birth year information in a console output format  
- [sparkpyrediskafkastreamtoconsole.py](sparkpyrediskafkastreamtoconsole.py)  
- [spark/logs/redis-kafka.log](spark/logs/redis-kafka.log)  
![sparkpyrediskafkastreamtoconsole.png](images/sparkpyrediskafkastreamtoconsole.png)  