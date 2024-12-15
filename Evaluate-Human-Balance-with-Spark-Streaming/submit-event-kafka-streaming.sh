#!/bin/bash
docker cp -L sparkpyeventskafkastreamtoconsole.py evaluate-human-balance-with-spark-streaming-spark-1:/opt/bitnami/spark/sparkpyeventskafkastreamtoconsole.py
docker exec -it evaluate-human-balance-with-spark-streaming-spark-1 /opt/bitnami/spark/bin/spark-submit \
                --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.2.1 sparkpyeventskafkastreamtoconsole.py | tee spark/logs/eventstream.log 