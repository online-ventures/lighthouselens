#!/bin/bash

set -e

rails db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  rails db:setup && rails db:migrate
fi

rails assets:precompile

rails server
