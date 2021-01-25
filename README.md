# Test-Driven Development with FastAPI and Docker

![CI/CD status](https://github.com/pedrodeoliveira/fastapi-tdd-docker/workflows/CI/CD%20status/badge.svg)

This repository is based on the paid course with the same name from [testdriven.io](https://testdriven.io), with some 
minor custom modifications (original repo [here](https://github.com/testdrivenio/fastapi-tdd-docker)).
The project consists in the development of an asynchronous **text summarization API** 
following Test-Driven Development (TDD) practices. The API follows RESTful design 
principles and enables the typical CRUD operations on **summaries**. 

These summaries represent condensed descriptions of web pages, each *summary* resource 
will have a `url` and the respective `summary`. This project uses the `newspaper3k` 
library that provides both the web scraping and summarizing parts.

## Technologies

The following technologies have been used:

- **Python** API developed in Python which supports many popular web frameworks.
- **FastAPI** a recent and trendy Python web framework supporting async out-of-the-box and
data validation based on *type hints*.
- **Pytest** a Python test framework which makes it easy to write and run unit and integration
tests.
- **Tortoise ORM** a Python library used as an async Object Relational Mapper (ORM), allowing
us to seamlessly interact with relational database from an async context.
- **PostgresSQL** the relational database where the API's data will live.
- **Docker** container platform used to quickly, easily and reliably deploy our web application
into production.
- **GitHub Packages** where the Docker images will be stored.
- **GitHub Actions** the CI/CD solution that automates the build, test and deployment of 
the web app code to the production.
- **Heroku** the PaaS solution for hosting our web app (in production).

## API Endpoints

This API implements the following routes:

| **Endpoint**     	| **HTTP method**   | **CRUD method** 	| **Description**      	|
|-----------------	|----------------  	|---------------	|----------------------	|
| `/summaries`     	| GET           	| READ        	    | get all summaries    	|
| `/summaries/<id>`	| GET         	    | READ        	    | get summary by id    	|
| `/summaries`     	| POST        	    | INSERT      	    | add a new summary 	|
| `/summaries/<id>`	| DELETE      	    | DELETE      	    | delete summary by id 	|
| `/summaries/<id>`	| PUT         	    | UPDATE      	    | update summary by id 	|

## Build the API image

To build, test and run this API we'll be using `docker-compose`. As such, the first step
is to build the images defined in the `docker-compose.yml` file.

```bash
$ docker-compose build
```

This will build two images:

- `fastapi-tdd-docker_web` image with REST API.
- `fastapi-tdd-docker_web-db` image with Postgres database.

## Run the Containers
 
To run the containers previously built, execute the following:
 
```bash
$ docker-compose up -d
```

This will launch two services named `web` (the API) and `web-db` (the underlying 
database) in background. The `web` service will be running on port `8002` on localhost. 
Whereas the database will be exposed to the `web` service. To make sure the
app is running correctly open [http://localhost:8002/ping](http://localhost:8002/ping) in 
your web browser (and/or run `docker-compose logs -f` from the command line). 

## Create the Database

The database can be created by running the following command:

```bash
$ docker-compose exec web python app/db.py
```

One can confirm that the database was properly created by accessing the database container
and starting a psql console.

```bash
$ docker-compose exec web-db psql -U postgres
```

Next, one can connect to the `web_dev` database and list all the tables:

```bash
# \c web_dev
# \dt
```

## Run the Tests

The tests can be executed with:

```bash
$ docker-compose exec web pytest
```

Or including a coverage check:

```bash
$ docker-compose exec web pytest --cov="."
```

## Check for Code Quality

Another step to ensure the code contains the desired quality is to perform *linting*, that 
is, to check for stylistic or programming errors. The following command will run the 
`flake8` linter throughout the source code:

```bash
$ docker-compose exec web flake8 .
```

Next, we perform additional checks to verify, and possibly correct, the code formatting 
(using `black`) and the ordering and organization of import statements (using `isort`).

```bash
$ docker-compose exec web black . --check
$ docker-compose exec web isort . --check-only
```
