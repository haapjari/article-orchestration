# Greetings

Hello! I am Jari Haapasaari ([mail](mailto:haapjari@gmail.com)). This repository consists tooling to spin up, and if you want, repeat the research setup for my thesis.

---

## Internals

This repository contains necessary tooling how to replicate my thesis setup. There is `start.sh` script that will clone all necessary repositories, and start the services with `docker-compose.yml`. 

## Procedure Overview

1. Collect Dataset
2. Normalize Dataset
3. Add Composite Variables (Predefined Weighted Sums)
4. Draw Distributions, Plots and Heatmaps

---

### Components

### Repository Analysis Interface

- [Interface](https://github.com/haapjari/repository-analysis-interface/releases/tag/v1.0.0)
- Will be compiled into a single binary, with `pyinstaller`.
- Version Used: `v1.0.9`.

### Repository Search API

- [Search API](https://github.com/haapjari/repository-search-api/releases/tag/v1.0.0)
- API to Interact with the [GitHub REST API](https://docs.github.com/en/rest?apiVersion=2022-11-28).
- Version Used: `v1.0.0`.

### Repository Database API

- [Database API](https://github.com/haapjari/repository-database-api/releases/tag/v1.0.0)
- CRUD API for the Database Interaction.
- Version Used: `v1.0.1`.

### Database

- [PostgreSQL](https://www.postgresql.org/)
- Simple relational Database.
- Version Used: `16.2`.

---

## How-To: Reproduce

### Prerequisites

- Before you begin, ensure you have the following tools:

```bash
    git
    docker
    docker-compose
    make
```

- If you're getting errors while using `Interface` it, that means the environments `glibc` version is not compatible with the compiled binary. Binary has to be recompiled to your corresponding environment.

### Preparation

- Clone this Repository.
- Install Prerequisites to the Environment.
- Export your `GITHUB_TOKEN` as an environment variable. (This makes generating the dataset faster, due to the GitHub API Rate Limit. 
    - Export `SEARCH_API_HOST=http://127.0.0.1:8000` and `DATABASE_API_HOST=http://127.0.0.1:9000` as environment variables. These can be set for example to the `~./bashrc` file, or just export them in the terminal session you're using.
- Run the Start Script, to Clone and Build Services (Database API, Search API and Database): `./sct/start.sh`
- If the Database API Logs Errors, and Shuts Down (Check Logs: `docker-compose logs -f`), just restart the service with `docker-compose -f docker-compose.yml up -d` in the project root. This happens, because `depends_on` is unreliable in this kind of situation. Even if the PostgreSQL database container has started, database within the container might not be ready. DB API starts quickly, and might try to connect to the database container, even if the database within the database has not started yet.
- Interface Entrypoint is now at `./interface`
- Print the Help Command: `./interface --help`

### Examples

## Collection

- NOTE: Collection will take multiple days, due to the GitHub API Rate Limits: For example, dataset collection of 16400 records took 8 days.
- Execute Collect Procedure: `./interface --collect 2008-01-01 2024-04-29 Go 100 150000 desc`
  - First Go Project (with enough stars) is released at ~ Spring 2008. Most Stars within a single project is ~ 125000, so this query pretty much covers the whole Go Ecosystem available GitHub.

## Normalization 
 
- Execute the Normalize Procedure: `./interface --normalize`

## Cleaning

- See the `./interface --help` Command and Execute Drop Command as Needed.

## Distribution

- Distributions: `./interface --dist --variables created_at stargazer_count open_issues closed_issues open_pull_request_count closed_pull_request_count forks commit_count total_releases_count contributor_count third_party_loc self_written_loc self_written_loc_proportion third_party_loc_proportion --output ./dist.png`

## Clustering

- Clustering: `./interface --cluster --method hierarchical --variables created_at stargazer_count open_issues closed_issues open_pull_request_count closed_pull_request_count forks commit_count total_releases_count contributor_count third_party_loc self_written_loc self_written_loc_proportion third_party_loc_proportion --output ./cluster.png`

## Heatmap 

- Heatmap: `./interface --heatmap --variables  created_at stargazer_count open_issues closed_issues open_pull_request_count closed_pull_request_count forks commit_count total_releases_count contributor_count third_party_loc self_written_loc self_written_loc_proportion third_party_loc_proportion --correlation spearman --output ./heatmap.png`

## Plot

- See the `./interface --help` Command and Execute Plot Command as Needed.

## Regression 

- See the `./interface --help` Command and Execute Regression Commands as Needed.

---
