#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

font="Arkitech 10"

fg_color="000000"
bg_color="ffffff"

dzen_params="-fg $fg_color -bg $bg_color -fn $font -h 14 -e onstart=lower"

# Top bars
./dzen_main.sh    | dzen2 -y 0    -x 0    -w 2880 -ta r & # $dzen_params &
./dzen_status.sh  | dzen2 -y 0    -x 2881 -w 1920 -ta r & # $dzen_params &
# Bottom bars
./dzen_audio.sh   | dzen2 -y 1200 -x 0    -w 1920 -ta r & # $dzen_params &
./dzen_storage.sh | dzen2 -y 1200 -x 1921 -w 1920 -ta r & # $dzen_params &
