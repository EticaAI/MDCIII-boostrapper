#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16.sh
#
#         USAGE:  ./999999999/1603_16.sh
#                 time ./999999999/1603_16.sh
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
#       CREATED:  2022-06-15 17:25 UTC started.
#      REVISION:  ---
#===============================================================================
set -e

ROOTDIR="$(pwd)"

# shellcheck source=1603_16.lib.sh
. "$ROOTDIR"/999999999/1603_16.lib.sh

gh_repo_create_1603_16_N "1603_16_24"
