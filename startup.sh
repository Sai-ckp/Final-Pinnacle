#!/bin/bash


# Avoid writing to read-only directory
touch /home/started.txt

# Install dependencies
pip install -r /home/site/wwwroot/requirements.txt

# Apply database migrations
python /home/site/wwwroot/manage.py migrate

# Start the Django app using gunicorn
gunicorn --chdir /home/site/wwwroot/student_alerts_app student_alerts_app.wsgi:application --bind=0.0.0.0:8000
