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

# echo "DEBUG: starting 1603_1.sh"

ROOTDIR="$(pwd)"
# DESTDIR is used to inform shell libs from main repository we're in another dir
DESTDIR="$ROOTDIR"
# NUMERORDINATIO_BASIM="$ROOTDIR"

# shellcheck source=1603_1.lib.sh
. "$ROOTDIR"/999999999/1603_1.lib.sh

# echo "TODO"

#### Quick tests _______________________________________________________________
# hxltmcli 999999/999999/hxltm-exemplum-linguam.tm.hxl.csv --objectivum-formulam='999999999/42302/exemplum-linguam.🗣️.json' --tmeta='999999/999999/hxltm-exemplum-linguam.tmeta.yml'
# gh_repo_edit_readme "1603_16_1" "🇧🇷"
gh_repo_edit_readme "1603_16_1" "🌐"
# gh_repo_edit_templated_file "999999999/42302/exemplum-linguam.🗣️.json" "999999/0/teste.json"

emoji_country_flag_from_iso3661p1a2 "br"

# echo ""
# emoji_from_alpha "b"
exit 0

#### Main ______________________________________________________________________

gh_repo_init_1603_16_1
# gh_repo_edit_1603_16_1__topics
