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

- Interface is compiled in `ubuntu 22.04 lts server` environment. If you're getting errors, that means your `glibc` version is not compatible with the binary. You can compile the binary yourself, or upgrade your environment and retry.

### Preparation

- Clone this Repository.
- Install Prerequisites to the Environment.
- Export your "GITHUB_TOKEN" as an environment variable.
- Export `SEARCH_API_HOST=http://127.0.0.1:8000` and `DATABASE_API_HOST=http://127.0.0.1:9000` as environment variables.
- Install Required Services: `./sct/start.sh`
- If the Database API Errors (Check Logs: `docker-compose logs -f`), just restart the service with `docker-compose -f docker-compose.yml up -d` in the project root. This happens, becaus even if the PostgreSQL Container is running, the DB was not bootstrapped before the API tried to connect.
- Interface Entrypoint is now at `./interface`
- Print the Help Command: `./services/analysis-interface/dist/main --help`

## Dataset Collection

- Execute Collect Procedure: `./interface --collect 2008-01-01 2024-04-29 Go 100 150000 desc`
  - First Go Project is released at ~ Spring 2008. Most Stars is ~ 125000, so this query pretty much covers the whole Go Ecosystem available GitHub.
- Test Run Took: `TBD h`

## Dataset Cleaning

- TBD (?)
- This can be done with DBeaver, or any other SQL Client. Just connect to the Database, and execute the necessary queries, to clean empty or broken entries.
 
## Dataset Normalization 
 
- Execute the Normalize Procedure: `./interface --normalize`

## Composite Variables

- Composite Variable for Popularity: `./interface --composite --variables stargazer_count forks subscriber_count watcher_count --name popularity`
- Composite Variable for Activity: `./interface --composite --variables open_issues closed_issues commit_count open_pull_request_count closed_pull_request_count network_count contributor_count --name activity`
- Composite Variable for Maturity: `./interface --composite --variables created_at latest_release total_releases_count --name maturity`
 
## Distributions

- Latest Release: `./interface -dist --variables latest_release --output ./latest_release_dist.png`
- Creation Date: `./interface -dist --variables created_at --output ./created_at_dist.png`
- Stars: `./interface -dist --variables stargazer_count --output ./stargazer_count_dist.png`
- Open Issues: `./interface -dist --variables open_issues --output ./open_issues_dist.png`
- Closed Issues: `./interface -dist --variables closed_issues --output ./closed_issues_dist.png`
- Open Pull Requests: `./interface -dist --variables open_pull_request_count --output ./open_pull_request_count_dist.png`
- Closed Pull Requests: `./interface -dist --variables closed_pull_request_count --output ./closed_pull_request_count_dist.png`
- Forks: `./interface -dist --variables forks --output ./forks_dist.png`
- Watchers: `./interface -dist --variables watcher_count --output ./watcher_count_dist.png`
- Subscribers: `./interface -dist --variables subscriber_count --output ./subscriber_count_dist.png`
- Commits: `./interface -dist --variables commit_count --output ./commit_count_dist.png`
- Network Events: `./interface -dist --variables network_count --output ./network_count_dist.png`
- Total Releases: `./interface -dist --variables total_releases_count --output ./total_releases_count_dist.png`
- Contributors: `./interface -dist --variables contributor_count --output ./contributor_count_dist.png`
- Third Party LOC: `./interface -dist --variables third_party_loc --output ./third_party_loc_dist.png`
- Self Written LOC: `./interface -dist --variables self_written_loc --output ./self_written_loc_dist.png`
- Popularity: `./interface -dist --variables popularity --output ./popularity_dist.png`
- Activity: `./interface -dist --variables activity --output ./activity_dist.png`
- Maturity: `./interface -dist --variables maturity --output ./maturity_dist.png`
- Self-Written LOC Proportion: `./interface -dist --variables self_written_loc_proportion --output ./self_written_loc_proportion_dist.png`
- Third-Party LOC Proportion: `./interface -dist --variables third_party_loc_proportion --output ./third_party_loc_proportion_dist.png`

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