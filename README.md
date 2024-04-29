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

## How-To: Reproduce

### Prerequisites

- Before you begin, ensure you have the following tools:

```bash
    git
    docker
    docker-compose
    make
```

- Interface is compiled in `Ubuntu LTS 22.04` environment with `pyinstaller`. If you're getting errors while using it, that means your `glibc` version is not compatible with the generated binary. Binary has to be recompiled to your corresponding environment.

### Preparation

- Clone this Repository.
- Install Prerequisites to the Environment.
- Export your `GITHUB_TOKEN` as an environment variable. (This makes generating the dataset faster, due to the GitHub API Rate Limit. Export `SEARCH_API_HOST=http://127.0.0.1:8000` and `DATABASE_API_HOST=http://127.0.0.1:9000` as environment variables. These can be set for example to the `~./bashrc` file, or just export them in the terminal session you're using.
- Run the Start Script, to Clone and Build Services (Database API, Search API and Database): `./sct/start.sh`
- If the Database API Logs Errors, and Shuts Down (Check Logs: `docker-compose logs -f`), just restart the service with `docker-compose -f docker-compose.yml up -d` in the project root. This happens, because `depends_on` is unreliable in this kind of situation. Even if the PostgreSQL database container has started, database within the container might've not started. DB API starts quickly, and might try to connect to the database container, even if the database within the database has not started yet.
- Interface Entrypoint is now at `./interface`
- Print the Help Command: `./services/analysis-interface/dist/main --help`

## Dataset Collection

- Execute Collect Procedure: `./interface --collect 2008-01-01 2024-04-29 Go 100 150000 desc`
  - First Go Project (with enough stars) is released at ~ Spring 2008. Most Stars within a single project is ~ 125000, so this query pretty much covers the whole Go Ecosystem available GitHub.
- NOTES: Collection will take multiple days: For example, test run for 16000 records took 4 days.

## Dataset Cleaning # TODO

- TBD (?)
- This can be done with DBeaver, or any other SQL Client. Just connect to the Database, and execute the necessary queries, to clean empty or broken entries.
 
## Dataset Normalization 
 
- Execute the Normalize Procedure: `./interface --normalize`

## Composite Variables

- Composite Variable for Popularity: `./interface --composite --variables stargazer_count forks subscriber_count watcher_count --name popularity`
- Composite Variable for Activity: `./interface --composite --variables open_issues closed_issues commit_count open_pull_request_count closed_pull_request_count network_count contributor_count --name activity`
- Composite Variable for Maturity: `./interface --composite --variables created_at latest_release total_releases_count --name maturity`
 
## Distribution

- Distributions: `./interface --dist --variables latest_release created_at stargazer_count open_issues closed_issues open_pull_request_count closed_pull_request_count forks watcher_count subscriber_count commit_count network_count total_releases_count contributor_count third_party_loc self_written_loc popularity activity maturity self_written_loc_proportion third_party_loc_proportion --output ./dist.png`

## Plots

- Library LOC Proportion vs. Activity `./interface -plot --variables activity third_party_loc_proportion --correlation spearman --output ./activity_third_party_loc_proportion_plot.png`
- Library LOC Proportion vs. Maturity: `./interface -plot --variables maturity third_party_loc_proportion --correlation spearman --output ./maturity_third_party_loc_proportion_plot.png`
- Library LOC Proportion vs. Popularity: `./interface -plot --variables popularity third_party_loc_proportion --correlation spearman --output ./popularity_third_party_loc_proportion_plot.png`
- Popularity vs. Activity: `./interface -plot --variables popularity activity --correlation spearman --output ./popularity_activity_plot.png`
- Popularity vs. Maturity: `./interface -plot --variables popularity maturity --correlation spearman --output ./popularity_maturity_plot.png`
- Activity vs. Maturity: `./interface -plot --variables activity maturity --correlation spearman --output ./activity_maturity_plot.png`
- Popularity vs. Self-Written LOC: `./interface -plot --variables popularity self_written_loc --correlation spearman --output ./popularity_self_written_loc_plot.png`
- Popularity vs. Third-Party LOC: `./interface -plot --variables popularity third_party_loc --correlation spearman --output ./popularity_third_party_loc_plot.png`
- Activity vs. Self-Written LOC: `./interface -plot --variables activity self_written_loc --correlation spearman --output ./activity_self_written_loc_plot.png`
- Activity vs. Third-Party LOC: `./interface -plot --variables activity third_party_loc --correlation spearman --output ./activity_third_party_loc_plot.png`
- Maturity vs. Self-Written LOC: `./interface -plot --variables maturity self_written_loc --correlation spearman --output ./maturity_self_written_loc_plot.png`
- Maturity vs. Third-Party LOC: `./interface -plot --variables maturity third_party_loc --correlation spearman --output ./maturity_third_party_loc_plot.png`

## Heatmaps

- Heatmap, for Popularity, Activity, Maturity, Self-Written LOC, Third-Party LOC, Third-Party LOC Proportion, Self-Written LOC Proportion: `./interface --heatmap --variables popularity activity maturity self_written_loc third_party_loc third_party_loc_proportion self_written_loc_proportion --correlation pearson --output ./heatmap.png`

---