#!/bin/bash

BASE_DIR=$(pwd)

check_prerequisites() {
    local missing_tools=0

    for tool in git make docker docker-compose wget; do
        if ! command -v $tool &> /dev/null; then
            echo "$tool is not installed. Please install $tool to continue."
            missing_tools=1
        fi
    done

    if [ $missing_tools -eq 1 ]; then
        exit 1
    fi
}

check_prerequisites

clone_repo() {
    local repo_url=$1
    local tag=$2
    local dir_name=$3

    git clone -b $tag --depth 1 $repo_url $dir_name
}

mkdir -p $BASE_DIR/services/search-api
mkdir -p $BASE_DIR/services/database-api

export SEARCH_API_HOST=http://127.0.0.1:8000
export DATABASE_API_HOST=http://127.0.0.1:9000

clone_repo https://github.com/haapjari/repository-search-api.git v1.0.0 $BASE_DIR/services/search-api
clone_repo https://github.com/haapjari/repository-database-api.git v1.0.1 $BASE_DIR/services/database-api

wget https://github.com/haapjari/repository-analysis-interface/releases/download/v1.0.1/rai-linux-x86_64 -O $BASE_DIR/interface
chmod +x $BASE_DIR/interface

cd $BASE_DIR

docker-compose build
docker-compose up -d
