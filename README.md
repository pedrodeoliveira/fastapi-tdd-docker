# Test-Driven Development with FastAPI and Docker

![CI/CD status](https://github.com/pedrodeoliveira/fastapi-tdd-docker/workflows/CI/CD%20status/badge.svg)

This repository is based on the paid course with the same name from [testdriven.io](https://testdriven.io), with some minor custom modifications.
The project consists in the development of an asynchronous **text summarization API** following Test-Driven Development (TDD) practices. 
The API follows RESTful design principles and enables the typical CRUD operations on the *summaries* entities.

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

 