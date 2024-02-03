#!/bin/bash

REPOS=("glass-ui" "glass-api" "glass-draw")
BASE_URL="https://github.com/haapjari"

for repo in "${REPOS[@]}"; do
  git clone "${BASE_URL}/${repo}.git"
done