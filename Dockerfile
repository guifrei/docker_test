FROM ubuntu:xenial

RUN apt update && apt install -y net-tools inetutils-ping ssh pdsh openssh-server vim

RUN useradd hadoop
RUN mkdir /home/hadoop	
RUN chown hadoop /home/hadoop

WORKDIR /home/hadoop
COPY jre-8u211-linux-x64.tar.gz /home/hadoop
COPY jdk-8u221-linux-x64.tar.gz /home/hadoop
COPY hadoop-3.2.1.tar.gz /home/hadoop
RUN su - hadoop -c "tar xvfz jre-8u211-linux-x64.tar.gz"
RUN su - hadoop -c "tar xvfz jdk-8u221-linux-x64.tar.gz"
RUN su - hadoop -c "tar xvfz hadoop-3.2.1.tar.gz"
RUN echo export JAVA_HOME=/home/hadoop/jre1.8.0_211 >> /home/hadoop/.profile
RUN echo export HADOOP_HOME=/home/hadoop/hadoop-3.2.1 >> /home/hadoop/.profile
RUN echo export PDSH_RCMD_TYPE=ssh >> /home/hadoop/.profile
RUN echo export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin >> /home/hadoop/.profile
RUN echo export JAVA_HOME=/home/hadoop/jre1.8.0_211 >> /home/hadoop/hadoop-3.2.1/etc/hadoop/hadoop-env.sh
COPY core-site.xml /home/hadoop/hadoop-3.2.1/etc/hadoop/core-site.xml
COPY hdfs-site.xml /home/hadoop/hadoop-3.2.1/etc/hadoop/hdfs-site.xml
COPY mapred-site.xml /home/hadoop/hadoop-3.2.1/etc/hadoop/mapred-site.xml
COPY yarn-site.xml /home/hadoop/hadoop-3.2.1/etc/hadoop/yarn-site.xml
COPY workers /home/hadoop/hadoop-3.2.1/etc/hadoop/workers
COPY generate_keys.sh /home/hadoop/generate_keys.sh
COPY start_sshd.sh /home/hadoop/start_sshd.sh
RUN chmod +x /home/hadoop/generate_keys.sh
RUN chmod +x /home/hadoop/start_sshd.sh

RUN mkdir /var/run/sshd
RUN echo hadoop:hadoop | chpasswd
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
EXPOSE 8020
EXPOSE 8032
EXPOSE 9000
EXPOSE 9500
EXPOSE 50070
EXPOSE 50470
EXPOSE 8020 
EXPOSE 8088 
EXPOSE 50075
EXPOSE 50475
EXPOSE 50010
EXPOSE 50020
EXPOSE 50090
EXPOSE 9864
EXPOSE 9866
EXPOSE 9867
EXPOSE 38131
CMD ["/bin/bash", "./start_sshd.sh"]
#CMD ["/usr/sbin/sshd", "-D", "&"]
#CMD ["su", "-", "hadoop"]
