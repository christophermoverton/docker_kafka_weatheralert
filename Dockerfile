FROM bitnami/kafka:latest

# Install necessary packages as root user
USER root
RUN apt-get update && apt-get install -y curl jq netcat-openbsd

# Copy the weather producer and startup scripts
COPY weather_producer.sh /opt/weather_producer.sh
COPY start.sh /opt/start.sh

# Make the scripts executable
RUN chmod +x /opt/weather_producer.sh /opt/start.sh

# Copy the server.properties file into the Kafka config directory
COPY server.properties /opt/bitnami/kafka/config/server.properties

# Switch back to the default non-root user (for security purposes)
USER 1001

# Set the entrypoint to your startup script
ENTRYPOINT ["/opt/start.sh"]
