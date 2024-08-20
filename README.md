


# Weather Alert Kafka Producer/Consumer

This project is part of a larger application that streams weather alerts from a weather API and sends them to a Kafka topic. The Kafka consumer then listens to the topic and processes the alerts in real-time.

## Table of Contents
- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Running the Kafka Broker](#running-the-kafka-broker)
- [Running the Producer Script](#running-the-producer-script)
- [Consuming the Weather Alerts](#consuming-the-weather-alerts)
- [Environment Variables](#environment-variables)
- [Known Issues](#known-issues)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

This part of the project sets up a Kafka broker to manage real-time streaming of weather alerts. It uses a producer script that pulls alerts from the [National Weather Service API](https://www.weather.gov/documentation/services-web-api) and publishes them to a Kafka topic (`weather-alerts`). The consumer script listens to the topic and processes incoming alerts.

## Prerequisites

- Docker
- Docker Compose
- Bash shell
- Access to the [National Weather Service API](https://api.weather.gov/alerts)

## Setup Instructions

1. Clone this repository to your local machine:
    ```bash
    git clone https://github.com/christophermoverton/weather-alert-kafka.git
    cd weather-alert-kafka
    ```

2. Ensure Docker and Docker Compose are installed and running.

3. Create a Docker Network

You can create a Docker network using the following command:

```bash
docker network create kafka-network
```

This creates a custom bridge network named `kafka-network` that allows your Kafka and Zookeeper containers to communicate.

Verify the Network Setup

You can verify that the containers are attached to the `kafka-network` by running the following command:

```bash
docker network inspect kafka-network
```

4. Make sure your Kafka and Zookeeper services are set up and ready to use. You can use Docker Compose to start both services:
    ```bash
    docker-compose up -d --build
    ```

5. Copy the environment variables from `.env.example` to `.env` and modify the variables as needed:
    ```bash
    cp .env.example .env
    ```



## Running the Kafka Broker

To run the Kafka broker and Zookeeper services, simply use Docker Compose:

```bash
docker-compose up -d --build
```

This will start Zookeeper and Kafka containers. Kafka will be exposed on port `9092`.

## Running the Producer Script

The producer script fetches data from the weather alerts API and sends it to the Kafka topic `weather-alerts`.

### Running the Producer Inside the Container
Note: These are instructions for manually running the producer script.  This is already automated once the docker container is built and running.

1. Connect to the running Kafka container:
    ```bash
    docker exec -it weather-alert-kafka-1 /bin/bash
    ```

2. Run the producer script:
    ```bash
    /opt/weather_producer.sh
    ```

The script will continuously poll the weather API for active alerts and send them to the Kafka topic `weather-alerts`.

### Running the Producer Locally

If you prefer running the producer locally, ensure you have access to Kafka and Zookeeper. Then run:

```bash
cd opt
bash weather_producer.sh
```

This script will also fetch alerts from the weather API and send them to Kafka.

## Consuming the Weather Alerts

To consume messages from the `weather-alerts` topic, you can use the Kafka console consumer.

1. Open a new terminal session.
2. Run the following command:
    ```bash
    docker exec -it weather-alert-kafka-1 /bin/bash
    cd opt/bitnami/kafka/bin
    kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic weather-alerts --from-beginning
    ```

This will print all the weather alerts that have been produced to the topic.

## Environment Variables

Make sure to configure the following environment variables in the `.env` file:

- `KAFKA_TOPIC`: The topic name to produce and consume messages from (e.g., `weather-alerts`).
- `KAFKA_BROKER`: The Kafka broker URL (e.g., `localhost:9092`).
- `WEATHER_API`: The URL of the weather alerts API (e.g., `https://api.weather.gov/alerts/active`).

## Known Issues

- **Connection Issues**: If the producer cannot connect to Kafka, verify that Kafka and Zookeeper are running and accessible.
- **API Rate Limits**: The weather API might have rate limits, so ensure your polling interval in the producer script is appropriate.

## Contributing

Contributions are welcome! Please fork the repository, create a new branch, and submit a pull request with your changes. Make sure to follow the coding guidelines and add appropriate tests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
```

