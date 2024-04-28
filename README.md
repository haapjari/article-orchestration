# Greetings

Hello! I am Jari Haapasaari ([mail](mailto:haapjari@gmail.com)). This repository consists tooling to spin up, and if you want, repeat the research setup for my thesis.

---

## Internals

This repository contains necessary tooling how to replicate my thesis setup. There is `start.sh` script that will clone all necessary repositories, and start the services with `docker-compose.yml`. 

## Architecture

![Dataset Collection](/img/dataset-collection.png)
![Dataset Cleaning](/img/dataset-cleaning.png)
![Dataset Analysis](/img/dataset-analysis.png)

---

### Components

### Repository Analysis Interface

- [Interface](https://github.com/haapjari/repository-analysis-interface/releases/tag/v1.0.0)
- Will be compiled into a single binary, with `pyinstaller`.
- Version Used: `v1.0.0`.

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

python -m src.main --composite --variables stargazer_count, forks, subscriber_count, watcher_count --name 'popularity'


python -m src.main --composite --variables open_issues, closed_issues, commit_count, network_count, open_pull_request_count, closed_pull_request_count, contributor_count --name 'activity'

python -m src.main --composite --variables created_at, latest_release, total_releases_count --name 'maturity


- TBD

#### Prerequisites

- Before you begin, ensure you have the following installed on your system:

```bash
    git
    docker
    docker-compose
    make
    pip
    python
```

---

# Executed Commands

## Preparation

- Install Prerequisites to the Environment.
- Export your "GITHUB_TOKEN" as a environment variable.
- Run the Start Script: `./sct/start.sh`
- Interface Entrypoint is now at `./services/analysis-interface/dist/main`
- Verify the Interface: `./services/analysis-interface/dist/main --help`

## Dataset Collection

- Execute Collect Procedure: `/path/to/interface --collect 2008-01-01 2024-04-28 Go 100 150000 desc`
  - First Go Project is released at ~ Spring 2008. Most Stars is ~ 125000, so this query pretty much covers the whole Go Ecosystem in GitHub.
 
## Dataset Normalization 
 
- Normalize: `python -m src.main --normalize`
- Composite Variable for Popularity ...
- Composite Variable for Activity ...
- Composite Variable for Maturity ...
- python -m src.main --heatmap --variables latest_release created_at open_issues closed_issues open_pull_request_count closed_pull_request_count watcher_count subscriber_count network_count total_releases_count contributor_count third_party_loc self_written_loc popularity activity maturity stargazer_count forks commit_count --correlation pearson --output ./output.png


---

- Update Orchestration Repository to Compile a Binary from this Python Package.
- Update Excalidraw Diagrams
- Update Excalidraw Pictures
- Update Orchestration Repository for Executed Commands