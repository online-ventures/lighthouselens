deploy: build push restart
sync: backup import

sha = $(shell git rev-parse HEAD)
image = nickgronow/lighthouselens:$(sha)

build:
	docker build --platform linux/amd64 -t $(image) -f docker/app/Dockerfile .

push:
	docker push $(image)

restart:
	kubectl set image deploy/lighthouselens rails=$(image) sidekiq=$(image)

backup:
	pg_dump -h localhost -p 4000 -U lighthouselens --no-owner --no-privileges --schema=public --clean --if-exists lighthouse > tmp/prod.sql

import:
	psql -v ON_ERROR_STOP=1 -h localhost -p 5482 -U postgres lighthouse -f tmp/prod.sql
