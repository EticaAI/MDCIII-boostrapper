#!/bin/bash
#===============================================================================
#
#          FILE:  1603_1.lib.sh
#
#         USAGE:  #import on other scripts
#                 . "$ROOTDIR"/999999999/1603_1.lib.sh
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

echo "DEBUG: starting 1603_1.lib.sh"

# shellcheck source=3133368.lib.sh
. "${ROOTDIR}/999999999/3133368.lib.sh"

# # __lsf_clone_local="${ROOTDIR}/999999/3133368/lexicographi-sine-finibus"
# __3133368_lib="${ROOTDIR}/999999999/3133368.lib.sh"
# # # __lsf_999999999_lib="${__lsf_clone_local}/officina/999999999/999999999.lib.sh"
# # # __lsf_999999999_lib="${__lsf_clone_local}/officina/999999999/999999999.lib.sh"
# # # __lsf_1603_45_16_lib="${__lsf_clone_local}/officina/999999999/1603_45_16.lib.sh"
# # _ROOTDIR="${__lsf_clone_local}/officina"

# # GH_ORG="${GH_ORG:-"MDCIII"}"
# # GH_ORG_DEST="${GH_ORG_DEST:-$GH_ORG}"

# if [ -f "$__3133368_lib" ]; then
#   # shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/999999999.lib.sh
#   . "$__3133368_lib"
# else
#   echo "ERROR: LSF not cached."
#   exit 1
# fi
