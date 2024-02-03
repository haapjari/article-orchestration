# Greetings

Hello! I am Jari Haapasaari ([mail](mailto:haapjari@gmail.com)), and this is an orchestration repository, for my research tool, that I built for my thesis.

---

## About

This repository contains `docker-compose.yml` file and instructions, how to replicate the thesis setup. 

Project is called `glass`, because I's like magnifying glass to open-source repositories hosted in GitHub. 

---

### Components

### Glass UI

- [Repository](https://github.com/haapjari/glass-ui)
- Visualizes the results.
- Offers orchestration methods and ability to visualize the results.

### Glass API

- [Repository](https://github.com/haapjari/glass-api)
- REST API, that fetches data from GitHub.
- API also calculates the missing fields from the data.

### Glass Draw

- [Repository](https://github.com/haapjari/glass-draw)
- Component leverages scientific libraries in 
- Component reads data from the database, and  

### Database

- PostgreSQL database.

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

#### Step 1: Clone the Orchestration Repository

- clone the `glass-orchestration`repository to your local machine:

``` bash
    git clone https://github.com/haapjari/glass-orchestration.git
    cd glass-orchestration
```

#### Step 2: Clone Component Repositories

- Run the provided script to clone the individual component repositories:

```bash
    ./sct/clone_repos.sh
```

- This script clones the following repositories into the current directory:

```bash
    glass-ui
    glass-api
    glass-draw
```

#### Step 3: Build Docker Images

- Build docker images for each component. This step uses the Dockerfiles located in each component's repository to create the images:

```bash
    make build
```

#### Step 4: Run the Application

Start the application by launching all services defined in the Docker Compose configuration:

```bash
    make up
```

This command runs the services in detached mode. To view logs from all services, you can use:

```bash
    docker-compose logs -f
```

#### Step 5: Accessing the Application

After starting the services, you can access the application components as follows:

- Glass UI: Open your web browser and navigate to http://localhost:3000
- Glass API: The API is available at http://localhost:4000
- Glass Draw: Access the drawing component at http://localhost:5000

Shutting Down

To stop and remove all running containers associated with the application, use the following command:

```bash
    make down
```

---