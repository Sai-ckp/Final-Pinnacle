#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
LOGFILE="/home/site/wwwroot/startup.log"

echo "Starting startup script at $(date)" | tee -a "$LOGFILE"

# Create a marker file
touch /home/site/wwwroot/started.txt

# Create virtual environment if it doesn't exist
if [ ! -d "/home/site/wwwroot/venv" ]; then
    echo "Creating virtual environment..." | tee -a "$LOGFILE"
    python3 -m venv /home/site/wwwroot/venv
else
    echo "Virtual environment already exists." | tee -a "$LOGFILE"
fi

# Activate virtual environment
source /home/site/wwwroot/venv/bin/activate
echo "Virtual environment activated." | tee -a "$LOGFILE"

# Upgrade pip and install dependencies
echo "Upgrading pip..." | tee -a "$LOGFILE"
pip install --upgrade pip | tee -a "$LOGFILE"

echo "Installing dependencies from requirements.txt..." | tee -a "$LOGFILE"
pip install -r /home/site/wwwroot/requirements.txt | tee -a "$LOGFILE"

# Run database migrations
echo "Running migrations..." | tee -a "$LOGFILE"
python /home/site/wwwroot/manage.py migrate | tee -a "$LOGFILE"

# Start Gunicorn server
echo "Starting Gunicorn server..." | tee -a "$LOGFILE"
exec gunicorn --bind=0.0.0.0:8000 student_alerts_app.wsgi:application | tee -a "$LOGFILE"
