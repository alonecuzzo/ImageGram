#!/bin/sh

if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
  gem update fastlane
  fastlane test
  exit $?
fi
