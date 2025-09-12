# #!/bin/bash
# set -e
# LOGFILE="/home/site/wwwroot/startup.log"

# echo "🚀 Starting startup script at $(date)" | tee -a "$LOGFILE"

# # Activate Azure's virtual environment
# if [ -f "/antenv/bin/activate" ]; then
#     echo "🔹 Activating virtual environment: /antenv" | tee -a "$LOGFILE"
#     source /antenv/bin/activate
# elif [ -f "/home/site/wwwroot/antenv/bin/activate" ]; then
#     echo "🔹 Activating virtual environment: /home/site/wwwroot/antenv" | tee -a "$LOGFILE"
#     source /home/site/wwwroot/antenv/bin/activate
# else
#     echo "❌ No virtual environment found!" | tee -a "$LOGFILE"
# fi

# # Set Django settings module (adjust if you use prod.py)
# export DJANGO_SETTINGS_MODULE=student_alerts_app.deployment


# # Upgrade pip & install dependencies
# echo "📦 Installing dependencies..." | tee -a "$LOGFILE"
# pip install --upgrade pip >> "$LOGFILE" 2>&1
# pip install -r /home/site/wwwroot/requirements.txt >> "$LOGFILE" 2>&1

# # Run migrations
# echo "🛠️ Running migrations..." | tee -a "$LOGFILE"
# python /home/site/wwwroot/manage.py migrate --noinput >> "$LOGFILE" 2>&1

# # Collect static files
# echo "🎨 Collecting static files..." | tee -a "$LOGFILE"
# python /home/site/wwwroot/manage.py collectstatic --noinput >> "$LOGFILE" 2>&1

# # Start Gunicorn server
# echo "🔥 Starting Gunicorn..." | tee -a "$LOGFILE"
# exec gunicorn --workers=4 --threads=4 --timeout=120 \
#     --bind=0.0.0.0:8000 student_alerts_app.wsgi:application
