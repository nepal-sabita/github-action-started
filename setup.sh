#this script is to run all the packages and dependencies for the app
#!/bin/bash

# Update package list and install required dependencies
sudo apt update
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# Installing rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Ruby installation
if [["$(ruby --version)"!= *"2.7.7"*]];
          then
          echo "Ruby version is not found. Installing...."
          rbenv install 2.7.7
          rbenv global 2.7.7
          else
          echo "ruby version 2.7.7 is already installed"
          fi
          ruby --version
echo 'export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Installation of Bundler and Rails
echo "gem: --no-document" > ~/.gemrc
gem env home
gem install bundler --user-install
if [["$(rails --version)"!= *"7.0.8"*]];
          then
          echo "Rails version is not found. Installing...."
          gem install rails -v 7.0.8
          else
          echo "rails version 7.0.8 is already installed"
          fi

rails -v

# Installation of PostgreSQL and libpq-dev
if ! dpkg -l | grep -q postgresql; then
    sudo apt install -y postgresql postgresql-contrib libpq-dev
    else
    echo "postgresql already install"
fi
psql --version
# sudo apt install postgresql postgresql-contrib libpq-dev

# Creating a PostgreSQL user and database
sudo -u postgres createuser --no-superuser --no-createrole --createdb $USER
sudo -u postgres createdb --owner=$USER DummyDb
sudo -u postgres psql -d DummyDb -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $USER;"
sudo -u postgres psql -d DummyDb -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $USER;"
sudo -u postgres psql -d DummyDb -c "ALTER USER $USER WITH CREATEDB;"
