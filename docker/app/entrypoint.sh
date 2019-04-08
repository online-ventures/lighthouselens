#!/bin/bash

echo "Starting Rails in $RAILS_ENV environment"

echo "Running db:migrate"
rails db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  rails db:setup && rails db:migrate
fi

echo "Start puma server"
bundle exec puma -C config/puma.rb
