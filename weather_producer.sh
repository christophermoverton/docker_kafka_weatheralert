#!/bin/bash

# Set Kafka topic and API endpoint
KAFKA_TOPIC="weather-alerts"
WEATHER_API="https://api.weather.gov/alerts/active"

while true; do
    # Fetch weather alert data
    ALERTS=$(curl -s $WEATHER_API | jq -c '.features[]')

    # Loop through each alert and send to Kafka
    for ALERT in $ALERTS; do
        echo $ALERT | kafka-console-producer.sh --broker-list localhost:9092 --topic $KAFKA_TOPIC
    done

    # Sleep for a minute before fetching new data
    sleep 60
done
