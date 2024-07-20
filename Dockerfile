# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file from the testWeb directory into the container at /app
COPY testWeb/requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Install MySQL client
RUN apt-get update && apt-get install -y default-mysql-client  netcat-traditional && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app/

# Set the working directory to where manage.py is located
WORKDIR /app/testWeb

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Define environment variable
ENV DJANGO_SETTINGS_MODULE=testWeb.settings

# Run the application using a script that waits for the DB to be ready
COPY testWeb/entrypoint.sh /entrypoint.sh
# Make sure the script is executable
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
