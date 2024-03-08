FROM ruby:2.6.1-alpine

RUN apk add --update --no-cache build-base postgresql-dev postgresql-client tzdata nodejs yarn bash git vim shared-mime-info xz-libs

ENV PATH /app/bin:$PATH

RUN mkdir /app
WORKDIR /app

# Entrypoint
ENTRYPOINT ["docker/dev/entrypoint.sh"]
