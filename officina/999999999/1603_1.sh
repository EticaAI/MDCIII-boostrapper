#!/bin/bash
#===============================================================================
#
#          FILE:  1603_1.sh
#
#         USAGE:  ./999999999/1603_1.sh
#                 time ./999999999/1603_1.sh
#
#   DESCRIPTION:  ---
#
#       OPTIONS:  ---
#
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication
#                 SPDX-License-Identifier: Unlicense
#       VERSION:  v1.0
#       CREATED:  2022-06-22 21:20 UTC started.
#      REVISION:  ---
#===============================================================================
set -e

echo "DEBUG: starting 1603_1.sh"

ROOTDIR="$(pwd)"
# DESTDIR is used to inform shell libs from main repository we're in another dir
DESTDIR="$ROOTDIR"
NUMERORDINATIO_BASIM="$ROOTDIR"

# shellcheck source=1603_1.lib.sh
. "$ROOTDIR"/999999999/1603_1.lib.sh

echo "TODO"
