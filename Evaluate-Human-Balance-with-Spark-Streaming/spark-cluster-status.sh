#!/bin/bash
docker logs evaluate-human-balance-with-spark-streaming-spark-1 >& spark/logs/spark-master.log
docker logs evaluate-human-balance-with-spark-streaming-spark-worker-1-1 >& spark/logs/spark-worker.log