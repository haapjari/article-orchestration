#!/bin/bash

REPOS=("repository-analysis-interface" "repository-search-api" "repository-database-api")
BASE_URL="https://github.com/haapjari"

for repo in "${REPOS[@]}"; do
  git clone "${BASE_URL}/${repo}.git"
done