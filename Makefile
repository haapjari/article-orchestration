.PHONY: clone build up down


all: clone build up


clone:
	./sct/clone_repos.sh


build:
	docker-compose build


up:
	docker-compose up -d


down:
	docker-compose down
