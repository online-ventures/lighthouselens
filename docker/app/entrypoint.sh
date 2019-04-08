#!/bin/sh

echo "Starting Rails in $RAILS_ENV environment"

echo "Running db:migrate"
rails db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  rails db:setup && rails db:migrate
fi

if [ $@ = 'sidekiq' ]; then
  bundle exec sidekiq
else
  # Precompile assets here
  echo "Precompile assets"
  rails assets:precompile

  echo "Start puma server"
  bundle exec puma -C config/puma.rb
fi
