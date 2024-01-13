#!/bin/sh

#Update package list and install required dependencies
echo
          echo 4. Which build installed?
          gradle --version
          if [["$(ruby --version)"!= *"2.7.7"*]];
          then
          echo "Ruby version is not found. Installing...."
          rbenv install 2.7.7
          rbenv global 2.7.7
          else
          echo "ruby version 2.7.7 is already installed"
          fi
          ruby --version
          if ! gem list -i "^rails$" > /dev/null 2>&1; then
            echo "Rails not found. Installing..."
            export GEM_HOME=$HOME/gems
            export PATH=$GEM_HOME/bin:$PATH
            gem install rails
          else
            echo "Rails is already installed."
          fi
          # Verify Rails installation
          rails --version
          if ! command -v flutter > /dev/null 2>&1;
          then
          echo "flutter not found. Installing ...."
          git clone https://github.com/flutter/flutter.git -b stable --depth 1
          export PATH="$PATH:`pwd`/flutter/bin"
          flutter --version
          flutter precache
          else
          echo "flutter is already installed"
          fi
          
          flutter --version
          dart --version
          if ! command -v dart > /dev/null 2>&1;
          then
          echo "dart not found. Installing ..."
          mkdir -p $HOME/dart
            curl -fsSL https://dart.dev/get/dart.zip -o dart.zip
            unzip dart.zip -d $HOME/dart
            export PATH="$PATH:$HOME/dart/dart-sdk/bin"
            else
            echo "dart is already installed"
            fi
            dart --version
          echo 5. Where is Android SDK Root
          echo $ANDROID_SDK_ROOT
          echo
          echo 6. What is the workspace Location
          echo $RUNNER_WORKSPACE
          echo
          echo 7. Who is running the script
          whoami
          echo 8. How is the disc laid out
          df
          echo 9. What environment variables are available
          env
          
          
          
          
          
