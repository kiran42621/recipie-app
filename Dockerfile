FROM python:3.11.5-alpine3.18 
LABEL maintainer="Kcube"

ENV PYTHONUNBUFFERED 1

ENV VIRTUAL_ENV=/py

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8500

ARG DEV=false

RUN     pip install --upgrade pip && \
        pip install -r /tmp/requirements.txt && \
        if [ $DEV = "true" ]; \
        then pip install -r /tmp/requirements.dev.txt ; \
        fi && \
        rm -rf /tmp && \
        adduser \ 
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH = "$VIRTUAL_ENV/bin:$PATH"

USER django-user