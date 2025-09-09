#!/bin/bash

touch /home/site/wwwroot/started.txt

# Create venv if not exists
if [ ! -d "/home/site/wwwroot/venv" ]; then
    python3 -m venv /home/site/wwwroot/venv
fi

# Activate venv
source /home/site/wwwroot/venv/bin/activate

# Upgrade pip and install dependencies
pip install --upgrade pip
pip install -r /home/site/wwwroot/requirements.txt

# Run migrations
python /home/site/wwwroot/manage.py migrate

# Start the app with gunicorn
gunicorn --bind=0.0.0.0:8000 student_alerts_app.wsgi:application
