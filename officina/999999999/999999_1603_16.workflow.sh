#!/bin/bash
#===============================================================================
#
#          FILE:  999999_1603_16.workflow.sh
#
#         USAGE:  ./999999999/999999_1603_16.workflow.sh
#                 time ./999999999/999999_1603_16.workflow.sh
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
#       CREATED:  2022-06-18 20:08 UTC started. based on 999999_1603_16.sh
#      REVISION:  ---
#===============================================================================
set -e


# ROOTDIR="$(pwd)"
# # DESTDIR is used to inform shell libs from main repository we're in another dir
# DESTDIR="$ROOTDIR"
# NUMERORDINATIO_BASIM="$ROOTDIR"

# # shellcheck source=1603_16.lib.sh
# . "$ROOTDIR"/999999999/1603_16.lib.sh

# # Temporary function to initialize 999999_1603_16 first time. May be kept
# # for historical proposes but is not mean to be used in long run
# __temp_999999_1603_16_boostraper() {
#   numerodinatio="999999_1603_16"
#   trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"
#   lsf_xlsx="/workspace/git/EticaAI/lexicographi-sine-finibus/officina/999999/1603/45/16/xlsx"
#   if [ -d "$trivium_basi" ]; then
#     echo "TODO"
#     objectivum_basi="$trivium_basi/999999/1603/45/16/xlsx"

#     if [ ! -d "$objectivum_basi" ]; then
#       # echo "creating dir [$objectivum_basi]"
#       mkdir -p "$objectivum_basi"
#     fi

#     for file_path in "${lsf_xlsx}"/*.xlsx; do
#       file_xlsx=$(basename "$file_path")
#       # ISO3166p1a3_original=$(basename --suffix=.xlsx "$file_path")
#       # ISO3166p1a3=$(echo "$ISO3166p1a3_original" | tr '[:lower:]' '[:upper:]')
#       # UNm49=$(numerordinatio_codicem_locali__1603_45_49 "$ISO3166p1a3")

#       # echo "file_xlsx [$file_xlsx]"
#       archivum_copiae_simplici "$file_path" "$objectivum_basi/$file_xlsx"
#     done
#   else
#     echo "ERROR repo [$numerodinatio] not initialized"
#     exit 1
#   fi
#   echo "TODO"
# }

# #### main ______________________________________________________________________

# gh_repo_create_numerordinatio "999999_1603_16"
# __temp_999999_1603_16_boostraper
# gh_repo_sync_push "999999_1603_16"

echo "999999_1603_16.workflow.sh already done via standard GitHub Actions"
echo "or via manual operations. Nothing to to."

exit 0
