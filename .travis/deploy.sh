#! /bin/bash

#
# A simple script to publish our artifacts on a push to the "master" branch.
# Publishes snapshots or, if our version isn't a snapshot, stable artifacts.
#

if [[ "$TRAVIS_BRANCH" == "master" && "$TRAVIS_PULL_REQUEST" == "false" ]]; then
  PROJECT_VERSION=$(mvn -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec)
  SETTINGS_FILE=$(find . -name settings.xml)

  if [[ "$PROJECT_VERSION" == *"SNAPSHOT"* ]]; then
    echo "[INFO] Deploying Jar(s) to the snapshot repository defined in the settings.xml file"
    mvn deploy -s "$SETTINGS_FILE" -Pdeploy -Dmaven.main.skip -Dmaven.test.skip=true
  fi
fi
