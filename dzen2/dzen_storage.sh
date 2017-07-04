#!/usr/bin/env bash

# Configures another dzen2 status bar containing the following:
# - Free and total space of all currently mounted filesystems
# - Color changes at 90%

set -o errexit
set -o pipefail
set -o nounset

SLEEP=1

while true; do
    echo "Storage script"
    sleep $SLEEP
done
