#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16_1.sh
#
#         USAGE:  ./999999999/1603_16_1.sh
#                 time ./999999999/1603_16_1.sh
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

# echo "DEBUG: starting 1603_16_1.sh"

ROOTDIR="$(pwd)"
# DESTDIR is used to inform shell libs from main repository we're in another dir
DESTDIR="$ROOTDIR"
# NUMERORDINATIO_BASIM="$ROOTDIR"

# shellcheck source=1603_16_1.lib.sh
. "$ROOTDIR"/999999999/1603_16_1.lib.sh

# echo "TODO"

#### Quick tests _______________________________________________________________
# hxltmcli 999999/999999/hxltm-exemplum-linguam.tm.hxl.csv --objectivum-formulam='999999999/42302/exemplum-linguam.🗣️.json' --tmeta='999999/999999/hxltm-exemplum-linguam.tmeta.yml'
# gh_repo_edit_readme "1603_16_1" "🇧🇷"
# gh_repo_edit_readme "1603_16_1" "🌐"
# gh_repo_edit_templated_file "999999999/42302/exemplum-linguam.🗣️.json" "999999/0/teste.json"

# emoji_country_flag_from_iso3661p1a2 "br"

# echo ""
# emoji_from_alpha "b"
# gh_repo_update_1603_16_1
# gh_repo_update_1603_16_1__boostrap_0 "data-localibus"
# gh_repo_update_1603_16_1__boostrap_0 ""

# Check the status with like
# git -C /workspace/git/EticaAI/MDCIII-boostrapper/officina/1603 status
# git -C /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999/3133368/1603_16_1 status
gh_repo_init_1603_16_1
gh_repo_update_1603_16_1
exit 0

#### Main ______________________________________________________________________
# @TODO note to self: thsi file is named 1603_16_1.sh, but calling 1603_16_1.
#       this need to be changed eventually
gh_repo_init_1603_16_1
# gh_repo_edit_1603_16_1__topics
gh_repo_update_1603_16_1


# ./999999999/0/999999999_7200235.py --methodus='cod_ab_ad_no1_csv' --numerordinatio-praefixo="1603_16"

# ./999999999/0/1603_3_12.py --help
# printf "P17\n" | ./999999999/0/1603_3_12.py --actionem-sparql --de=P --query --ex-interlinguis
# printf "P17\n" | ./999999999/0/1603_3_12.py --actionem-sparql --de=P --query --ex-interlinguis | ./999999999/0/1603_3_12.py --actionem-sparql --csv --hxltm

# https://github.com/topics/csvw
# https://github.com/bencomp/csvw-mustaches
# https://github.com/rdf-ext/rdf-parser-csvw/issues/11
