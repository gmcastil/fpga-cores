#!/usr/bin/env bash

# Configures the main dzen2 status bar containing the following
# (generally from left to right):
# - XMonad workspaces
# - CPU load and temperatures for all four cores
# - GPU load and temperatures
# - Network traffic for both interfaces
# - Color changes as a function of load and alerts for high temps
# - Notifications too

set -o errexit
set -o pipefail
set -o nounset

SLEEP=1
