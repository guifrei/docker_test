#!/bin/bash

name=$1
sudo docker run -d \
	--add-host masterNode:172.17.0.2 \
	--add-host dataNode1:172.17.0.3 \
	--add-host dataNode2:172.17.0.4 \
	--add-host dataNode3:172.17.0.5 \
	--hostname $name \
	--name $name \
	--mount type=bind,source="$(pwd)"/"$name"/data,target=/home/hadoop/data \
        --mount type=bind,source="$(pwd)"/"$name"/ssh,target=/home/hadoop/.ssh \
        --mount type=bind,source="$(pwd)"/common,target=/home/hadoop/common \
	-t hadoop_image 
