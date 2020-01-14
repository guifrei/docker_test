#!/bin/sh

export JAVA_OPTS=a
HADOOP_USER_NAME=hadoop ./apache-hive-3.1.2-bin/bin/hive -hiveconf fs.defaultFS=hdfs://masterNode:9500 -S
