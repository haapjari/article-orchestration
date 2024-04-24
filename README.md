# Greetings

Hello! I am Jari Haapasaari ([mail](mailto:haapjari@gmail.com)). This repository consists necessary orchestration tools to repeat the setup of my thesis project.

---

## About

This repository contains `docker-compose.yml` file and instructions, how to replicate the thesis setup. 

![Dataset Collection](/img/dataset-collection.png)
![Dataset Cleaning](/img/dataset-cleaning.png)
![Dataset Analysis](/img/dataset-analysis.png)

---

### Components

### Repository Analysis Interface

- [Repository](https://github.com/haapjari/repository-analysis-interface)
- TBD

### Repository Search API

- [Repository](https://github.com/haapjari/repository-search-api/releases/tag/v1.0.0)
- TBD

### Repository Database API

- [Repository](https://github.com/haapjari/repository-database-api)
- Add the Version.

### Database

- PostgreSQL Database.

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
