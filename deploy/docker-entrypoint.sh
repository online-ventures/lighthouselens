#!/bin/bash

echo "Starting Rails in $RAILS_ENV environment"

rails db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  rails db:setup && rails db:migrate
fi

rails assets:precompile

rails server -b 0.0.0.0 -p 3000
