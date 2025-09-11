# Use official Python image as base
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies and Python packages in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy project files
COPY . .

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' appuser
USER appuser

# Expose the port Gunicorn will run on
EXPOSE 8000

# Collect static files & start Gunicorn at runtime
# Using a startup command ensures environment variables (DB, secret key) are available
CMD python manage.py collectstatic --noinput && \
    gunicorn student_alerts_app.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --timeout 120
