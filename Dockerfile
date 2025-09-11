# Use official Python image as base
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project files
COPY . .

# Collect static files
ENV DJANGO_SETTINGS_MODULE=student_alerts_app.deployment
RUN python manage.py collectstatic --noinput

# Expose port
EXPOSE 8000

# Command to run the app using Gunicorn
CMD ["gunicorn", "student_alerts_app.wsgi:application", "--bind", "0.0.0.0:8000"]
