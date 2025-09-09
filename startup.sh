#!/bin/bash
set -e
LOGFILE="/home/site/wwwroot/startup.log"

echo "Starting startup script at $(date)" | tee -a "$LOGFILE"

# Activate Azure's default virtual environment
if [ -f "/antenv/bin/activate" ]; then
    source /antenv/bin/activate
elif [ -f "/home/site/wwwroot/antenv/bin/activate" ]; then
    source /home/site/wwwroot/antenv/bin/activate
else
    echo "❌ No virtual environment found!" | tee -a "$LOGFILE"
fi

# Upgrade pip and install dependencies
pip install --upgrade pip | tee -a "$LOGFILE"
pip install -r /home/site/wwwroot/requirements.txt | tee -a "$LOGFILE"

# Run database migrations
python /home/site/wwwroot/manage.py migrate | tee -a "$LOGFILE"

# Start Gunicorn server
exec gunicorn --bind=0.0.0.0:8000 student_alerts_app.wsgi:application | tee -a "$LOGFILE"
