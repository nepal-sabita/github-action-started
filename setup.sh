#!/bin/sh

# Update package list and install required dependencies
sudo apt update
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# Installing rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
export RBENV_ROOT="$HOME/.rbenv"
export PATH="$RBENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# Ruby installation
rbenv install -l
export RBENV_VERSION=2.7.7
rbenv install $RBENV_VERSION
rbenv global $RBENV_VERSION
ruby -v

# Installation of Bundler and Rails
gem install bundler --user-install
gem install rails -v '7.0.8'

# Installation of PostgreSQL
sudo apt install postgresql postgresql-contrib

# Creating a PostgreSQL user and database
sudo -u postgres createuser --no-superuser --no-createrole sabu
sudo -u postgres createdb --owner=sabu washing_solution_api_test
sudo -u postgres psql -d washing_solution_api_test -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO sabu;"
sudo -u postgres psql -d washing_solution_api_test -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO sabu;"
sudo -u postgres psql -d washing_solution_api_test -c "GRANT ALL PRIVILEGES ON DATABASE washing_solution_api_test TO sabu;"


# Cloning the repository
git clone git@github.com:Shatkon/jadibuti-api.git
cd jadibuti-api

# Installing dependencies
bundle install --gemfile ~/jadibuti-api/Gemfile

# Run database migrations and seed
bin/rails db:migrate
bin/rails db:seed

# Starting the Rails server
rails server

