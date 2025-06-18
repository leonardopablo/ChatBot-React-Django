# FROM python:3.12.0-alpine3.20

# ENV PYTHONUNBUFFERED 1

# COPY ./requirements.txt /requirements.txt

# ENV PATH="/py/bin:$PATH"
# RUN python -m venv /py && \
#     pip install --upgrade pip && \
#     apk add --update --upgrade --no-cache postgresql-client && \
#     apk add --update --upgrade --no-cache --virtual .tmp \
#         build-base postgresql-dev

# RUN pip install -r /requirements.txt && apk del .tmp

# COPY ./backend /backend
# WORKDIR /backend

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
FROM python:3.12-alpine3.20 

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

ENV PATH="/py/bin:$PATH"
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    # Instala las dependencias del sistema.
    # postgresql-client proporciona la librería libpq, que aunque psycopg2-binary
    # la empaqueta, a veces es útil tener la versión del sistema por si acaso.
    # No necesitas build-base ni postgresql-dev con psycopg2-binary.
    apk add --update --upgrade --no-cache postgresql-client

# Instala los requisitos de Python desde requirements.txt
RUN /py/bin/pip install -r /requirements.txt

COPY ./backend /backend
WORKDIR /backend

CMD ["/py/bin/python", "manage.py", "runserver", "0.0.0.0:8000"]