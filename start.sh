#!/bin/bash

set -e  # Exit on error

# Start Kafka server
echo "Starting Kafka server..."
/opt/bitnami/kafka/bin/kafka-server-start.sh /opt/bitnami/kafka/config/server.properties &

# Wait for Kafka to be ready
echo "Waiting for Kafka to start..."
while ! nc -z localhost 9092; do   
  sleep 5
  echo "Kafka is still not ready, waiting..."
done

echo "Kafka started successfully."

# Create Kafka topic if not exists
echo "Creating Kafka topic..."
/opt/bitnami/kafka/bin/kafka-topics.sh --create --topic weather-alerts --bootstrap-server localhost:9092 --partitions 3 --replication-factor 1 --if-not-exists

# Start weather producer
echo "Starting weather alert producer..."
/opt/weather_producer.sh
