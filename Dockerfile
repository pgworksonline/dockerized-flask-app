# Use official Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Install dependencies and curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/* \
    && pip install flask

# Expose the application port
EXPOSE 5000

# Docker health check that pings the /health endpoint every 30 seconds
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:5000/health || exit 1

# Command to run the application
CMD ["python", "app.py"]

