#!/bin/bash

sudo docker rmi $(sudo docker image ls | grep none | grep -v hadoop_image | grep -v ubuntu | grep -v hello | cut -c41-52)
sudo docker stop $(sudo docker ps -q -a)
sudo docker rm $(sudo docker ps -q -a)
