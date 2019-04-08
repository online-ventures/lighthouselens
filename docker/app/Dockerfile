FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for a JS runtime
RUN apt-get install -y nodejs

# an editor
RUN apt-get install -y vim

# app directory
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Production build
ENV RAILS_ENV production
ENV RACK_ENV production

# setup bundler
COPY Gemfile* $APP_HOME/
RUN bundle install --jobs 20 --retry 5 --without development test
ENV PATH="${BUNDLE_BIN}:${PATH}"

# app files
COPY . $APP_HOME

# Precompile assets here
RUN rails assets:precompile

# Document what port should be exposed
EXPOSE 3000

# Entrypoint
ENTRYPOINT ["docker/app/docker-entrypoint.sh"]
