deploy: build push restart

sha = $(shell git rev-parse HEAD)
image = gcr.io/web-online-ventures/lighthouselens:$(sha)

build:
	docker build --platform linux/amd64 -t $(image) -f docker/app/Dockerfile .

push:
	docker push $(image)

restart:
	kubectl set image deploy/lighthouselens rails=$(image) sidekiq=$(image)

backup:
	pg_dump -h localhost -p 4000 -U mce --no-owner --no-privileges --schema=public --clean --if-exists mce > tmp/db/prod.sql

import:
	psql -v ON_ERROR_STOP=1 -h localhost -p 5484 -U postgres mce -f tmp/db/prod.sql
