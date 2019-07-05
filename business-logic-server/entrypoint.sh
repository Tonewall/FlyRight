#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."
    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

cd business-logic-server && python3.7 manage.py makemigrations icarus_backend
python3.7 manage.py migrate
echo "MIGRATED"
python3.7 manage.py createsuperuser --username admin --email admin@email.com

exec "$@"
