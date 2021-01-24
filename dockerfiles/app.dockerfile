FROM python:3.8.3-slim-buster

# set working directory
WORKDIR /usr/src/app

# set environment varibles
# prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE 1
# prevents Python from buffering stdout and stderr
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update && \
    apt-get -y install netcat gcc && \
    apt-get clean

# install python dependencies
RUN pip install --upgrade pip
COPY requirements.txt .
COPY requirements-dev.txt .
RUN pip install -r requirements-dev.txt

# add app
COPY . .

# run entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]