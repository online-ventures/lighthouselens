#!/bin/bash

# Context info
echo "Entrypoint starting directory: $(pwd)"
echo "Directory contents"
ls
echo "Rails environment: $RAILS_ENV"

# Database migrations
echo "Running db:migrate"
bundle exec rails db:migrate
if [[ $? != 0 ]]; then
  echo "== Failed to migrate. Running setup first."
  bundle exec rails db:setup && bundle exec rails db:migrate
fi

# Sidekiq
if [[ $@ = 'sidekiq' ]]; then
  bundle exec sidekiq
else
  # Rails
  echo "Precompile assets"
  bundle exec rails assets:precompile

  echo "Start puma server"
  bundle exec puma -C config/puma.rb
fi
