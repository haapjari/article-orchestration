clone:
	./sct/clone.sh
.PHONY: clone


build:
	docker-compose build
.PHONY: build

up:
	docker-compose up -d
.PHONY: up

down:
	docker-compose down
.PHONY: down
