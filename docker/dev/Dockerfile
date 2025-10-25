FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y libffi-dev build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - \
        && apt-get install -y nodejs

# app directory
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ENV PATH /app/bin:$PATH

# Entrypoint
ENTRYPOINT ["docker/dev/entrypoint.sh"]
