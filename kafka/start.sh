#!/bin/bash

IP=$(grep "\s${HOSTNAME}$" /etc/hosts | head -n 1 | awk '{print $1}')

# Concatenate the IP:PORT for ZooKeeper to allow setting a full connection
# string with multiple ZooKeeper hosts
[ -z "$ZOOKEEPER_CONNECTION_STRING" ] && ZOOKEEPER_CONNECTION_STRING="${ZOOKEEPER_IP}:${ZOOKEEPER_PORT:-2181}"

cat /kafka/config/server.properties.template | sed \
  -e "s|{{KAFKA_ADVERTISED_HOST_NAME}}|${KAFKA_ADVERTISED_HOST_NAME:-$IP}|g" \
  -e "s|{{KAFKA_ADVERTISED_PORT}}|${KAFKA_ADVERTISED_PORT:-9092}|g" \
  -e "s|{{KAFKA_AUTO_CREATE_TOPICS_ENABLE}}|${KAFKA_AUTO_CREATE_TOPICS_ENABLE:-true}|g" \
  -e "s|{{KAFKA_BROKER_ID}}|${KAFKA_BROKER_ID:-0}|g" \
  -e "s|{{KAFKA_DEFAULT_REPLICATION_FACTOR}}|${KAFKA_DEFAULT_REPLICATION_FACTOR:-1}|g" \
  -e "s|{{KAFKA_DELETE_TOPIC_ENABLE}}|${KAFKA_DELETE_TOPIC_ENABLE:-false}|g" \
  -e "s|{{KAFKA_DELETE_TOPIC_ENABLE}}|${KAFKA_DELETE_TOPIC_ENABLE:-false}|g" \
  -e "s|{{KAFKA_GROUP_MAX_SESSION_TIMEOUT_MS}}|${KAFKA_GROUP_MAX_SESSION_TIMEOUT_MS:-300000}|g" \
  -e "s|{{KAFKA_LOG_RETENTION_HOURS}}|${KAFKA_LOG_RETENTION_HOURS:-168}|g" \
  -e "s|{{KAFKA_NUM_PARTITIONS}}|${KAFKA_NUM_PARTITIONS:-1}|g" \
  -e "s|{{KAFKA_REPLICATION_FACTOR}}|${KAFKA_REPLICATION_FACTOR:-1}|g" \
  -e "s|{{KAFKA_PORT}}|${KAFKA_PORT:-9092}|g" \
  -e "s|{{ZOOKEEPER_CHROOT}}|${ZOOKEEPER_CHROOT:-}|g" \
  -e "s|{{ZOOKEEPER_CONNECTION_STRING}}|${ZOOKEEPER_CONNECTION_STRING}|g" \
  -e "s|{{ZOOKEEPER_CONNECTION_TIMEOUT_MS}}|${ZOOKEEPER_CONNECTION_TIMEOUT_MS:-10000}|g" \
  -e "s|{{ZOOKEEPER_SESSION_TIMEOUT_MS}}|${ZOOKEEPER_SESSION_TIMEOUT_MS:-10000}|g" \
  -e "s|{{KAFKA_MESSAGE_MAX_BYTES}}|${KAFKA_MESSAGE_MAX_BYTES:-1000012}|g" \
  -e "s|{{KAFKA_REPLICA_FETCH_MAX_BYTES}}|${KAFKA_REPLICA_FETCH_MAX_BYTES:-1048576}|g" \
   > /kafka/config/server.properties


echo "Starting kafka"
exec /kafka/bin/kafka-server-start.sh /kafka/config/server.properties
