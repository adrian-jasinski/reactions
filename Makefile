.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build:	## Build project with compose
	docker-compose up --build --detach

.PHONY: up
up:	## Run project with compose
	docker-compose up  --detach

.PHONY: down
down: ## Reset project containers with compose
	docker-compose down

.PHONY: lock
lock:	## Refresh pipfile.lock
	pipenv lock --pre

.PHONY: requirements
requirements:	## Refresh requirements.txt from pipfile.lock
	pipenv lock -r > requirements.txt

.PHONY: test
test:	## Run project tests
	docker-compose run --rm web pytest -vv

.PHONY: run
run: ## Run uvicorn localy
	cd reactions_api; uvicorn main:app --reload