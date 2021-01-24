# pull official base image
FROM python:3.8.6-slim-buster as builder

# install system dependencies
RUN apt-get update \
  && apt-get -y install gcc postgresql \
  && apt-get clean

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt

# lint
COPY . /usr/src/app/
RUN pip install black==19.10b0 flake8===3.8.3 isort==5.4.2
RUN flake8 .
RUN black --exclude=migrations .
RUN isort .


# pull official base image
FROM python:3.8.6-slim-buster as final

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
RUN addgroup --system app && adduser --system --group app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/web
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV ENVIRONMENT prod
ENV TESTING 0

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc postgresql \
  && apt-get clean

# install python dependencies
COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache /wheels/*
RUN pip install "uvicorn[standard]==0.13.1"

# add app
COPY . .

# chown all the files to the app user
RUN chown -R app:app $HOME

# change to the app user
USER app

# run gunicorn
CMD gunicorn --bind 0.0.0.0:$PORT app.main:app -k uvicorn.workers.UvicornWorker