# Test-Driven Development with FastAPI and Docker

![CI/CD status](https://github.com/pedrodeoliveira/fastapi-tdd-docker/workflows/CI/CD%20status/badge.svg)

This repository is based on the paid course with the same name from [testdriven.io](https://testdriven.io), with some 
minor custom modifications (original repo [here](https://github.com/testdrivenio/fastapi-tdd-docker)).
The project consists in the development of an asynchronous **text summarization API** 
following Test-Driven Development (TDD) practices. The API follows RESTful design 
principles and enables the typical CRUD operations on the *summaries* entities.

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

## How to Run the API
 
To build, test and run this API we'll be using `docker-compose`. As such, the first step
is to run (and build, if it's the first time) the services defined in the 
`docker-compose.yml` file.
 
```bash
$ docker-compose up -d
```

This will launch two services named `web` (the API) and `web-db` (the underlying 
database). The `web` service will be running on port `8002` on localhost. To make sure the
app is running correctly open [http://localhost:8002/ping] in your web browser (and/or 
run `docker-compose logs -f` in the command line). 

## 
