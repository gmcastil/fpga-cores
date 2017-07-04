#!/usr/bin/env bash

# Configures a status bar containing icons for alert or statsu:
# - Dropbox status
# - Email status (with a number for unread emails)
# - A flag that can be used to indicate build status
# - Date and time
# - Indicator that uncommitted changes live in code repos

set -o errexit
set -o pipefail
set -o nounset

SLEEP=1

while true; do
    echo "Status script"
    sleep $SLEEP
done
