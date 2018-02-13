FROM java:8

ENV KAFKA_VERSION=1.0.0 KAFKA_SCALA_VERSION=2.12

RUN mkdir /kafka /data /logs
ADD http://www.us.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}.tgz /tmp/
WORKDIR /tmp
RUN tar -zx -C /kafka --strip-components=1 -f kafka_${KAFKA_SCALA_VERSION}-${KAFKA_VERSION}.tgz && rm -rf kafka_*
ADD config /kafka/config
ADD start.sh /start.sh
ENV PATH /kafka/bin:$PATH
WORKDIR /kafka
CMD ["/start.sh"]