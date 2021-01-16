#!/bin/bash

set -e

CHROMEDRIVER_RELEASE="$(curl -4Ls https://chromedriver.storage.googleapis.com/LATEST_RELEASE)"
curl -4Ls https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_RELEASE}/chromedriver_linux64.zip | zcat > /usr/bin/chromedriver
chmod +x /usr/bin/chromedriver
