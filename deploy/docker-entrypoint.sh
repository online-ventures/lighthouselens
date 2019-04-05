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

echo "Precompile assets"
rails assets:precompile

echo "Start rails server"
rails server -b 0.0.0.0 -p 3000
