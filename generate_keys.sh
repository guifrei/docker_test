#!/bin/bash
mkdir .ssh
ssh-keyscan -t rsa,dsa masterNode dataNode1 dataNode2 dataNode3 > ~/.ssh/known_hosts
ssh-keygen -P "" -b 4096
ssh-copy-id -i /home/hadoop/.ssh/id_rsa.pub masterNode
ssh-copy-id -i /home/hadoop/.ssh/id_rsa.pub dataNode1
ssh-copy-id -i /home/hadoop/.ssh/id_rsa.pub dataNode2
ssh-copy-id -i /home/hadoop/.ssh/id_rsa.pub dataNode3
