#!/bin/sh

if [ "$DATABASE" = "mysql" ]
  # Wait for MySQL to be ready
  while ! nc -z db 3306; do
    echo "Waiting for MySQL..."
    sleep 1
  done
  echo "MySQL started"

fi

# Execute Django commands
python manage.py makemigrations
python manage.py migrate

exec "$@"