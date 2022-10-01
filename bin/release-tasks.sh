#!/usr/bin/env bash

set -e

bundle exec rake db:migrate
bundle exec rake import:from_yaml
