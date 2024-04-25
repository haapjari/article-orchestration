# Greetings

Hello! I am Jari Haapasaari ([mail](mailto:haapjari@gmail.com)). This repository consists tooling to spin up, and if you want, repeat the research setup for my thesis.

---

## Internals

This repository contains `docker-compose.yml` file and instructions, how to replicate the thesis setup. 

## Architecture

![Dataset Collection](/img/dataset-collection.png)
![Dataset Cleaning](/img/dataset-cleaning.png)
![Dataset Analysis](/img/dataset-analysis.png)

---

### Components

### Repository Analysis Interface

- [Interface](https://github.com/haapjari/repository-analysis-interface)
- TBD

### Repository Search API

- [Search API](https://github.com/haapjari/repository-search-api/releases/tag/v1.0.0)
- API to Interact with the [GitHub REST API](https://docs.github.com/en/rest?apiVersion=2022-11-28).
- Version Used: `v1.0.0`.

### Repository Database API

- [Database API](https://github.com/haapjari/repository-database-api/releases/tag/v1.0.0)
- CRUD API for the Database Interaction.
- Version Used: `v1.0.0`.

### Database

- [PostgreSQL](https://www.postgresql.org/)
- Simple relational Database.
- Version Used: `16.2`.

---

### How-To: Run

- This guide will walk you through the steps to clone, build, and run the `glass` application components using `docker-compose.yml`. This process involves cloning the necessary repositories, building DOcker Images for each component, and running the services using `docker-compose.yml`. This could be done with docker registry, but I opted not to use public registry, and instead just rely on versioning GitHub repositories. 

#### Prerequisites

- Before you begin, ensure you have the following installed on your system:

```bash
    git
    docker
    docker-compose
```
