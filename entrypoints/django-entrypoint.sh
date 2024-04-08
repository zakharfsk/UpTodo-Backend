#!/bin/sh

set -o errexit
set -o nounset

echo "Migrate collect static..."
python manage.py collectstatic --noinput

echo "Migrate..."
python manage.py migrate --noinput

echo "Create superuser..."
python manage.py createsuperuser --noinput && echo "Superuser created."

echo "Starting server..."
gunicorn 'config.wsgi' --reload --bind=0.0.0.0:8000