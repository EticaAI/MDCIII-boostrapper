#!/bin/bash
#===============================================================================
#
#          FILE:  999999_1603_16.sh
#
#         USAGE:  ./999999999/999999_1603_16.sh
#                 time ./999999999/999999_1603_16.sh
#
#   DESCRIPTION:  Create/prepare/fetch new cache data for:
#                   - @MDCIII/999999_1603_16
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
#       CREATED:  2022-06-17 16:36 UTC started.
#      REVISION:  ---
#===============================================================================
set -e


ROOTDIR="$(pwd)"
# DESTDIR is used to inform shell libs from main repository we're in another dir
DESTDIR="$ROOTDIR"
NUMERORDINATIO_BASIM="$ROOTDIR"

# shellcheck source=1603_16.lib.sh
. "$ROOTDIR"/999999999/1603_16.lib.sh

gh_repo_create_numerordinatio "999999_1603_16"


# 1603_16_24 Angola
# gh_repo_create_numerordinatio "1603_16_24"
# 1603_16_508 Mozambique
# gh_repo_create_numerordinatio "1603_16_508"

# gh_repo_fetch_lexicographi_sine_finibus

# echo "Login shell?"
# shopt login_shell
