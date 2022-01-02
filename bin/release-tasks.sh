#!/usr/bin/env bash

set -e

bundle exec rake db:migrate

rake assets:clean
rake assets:precompile
