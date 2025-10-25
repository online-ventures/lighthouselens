FROM ruby:2.7.8

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

# Production build
ENV RAILS_ENV production
ENV RACK_ENV production

# setup bundler
COPY Gemfile* $APP_HOME/
RUN gem install bundler:2.4.22
RUN bundle config set --local without 'development test'
RUN bundle install --jobs 10 --retry 5

# Document what port should be exposed
EXPOSE 3000

# Entrypoint
COPY ./docker/app/entrypoint.sh /usr/local/bin
ENTRYPOINT ["entrypoint.sh"]

# App files
COPY . $APP_HOME
