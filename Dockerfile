# Use the official Python image from the Docker Hub
FROM python:3.10

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Install the Cloud SQL Proxy
RUN curl -o /cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 && \
    chmod +x /cloud_sql_proxy

# Copy the rest of the application code into the container
COPY . .

# Set the environment variables
ENV PYTHONUNBUFFERED=1

# Copy the service account key file
COPY path/to/your-service-account-file.json /app/service-account.json

# Run the Cloud SQL Proxy and the application
CMD /cloud_sql_proxy -dir=/cloudsql -instances=apis-424409:us-central1:storyvord -credential_file=/app/service-account.json & \
    gunicorn myproject.wsgi:application --bind 0.0.0.0:8000
