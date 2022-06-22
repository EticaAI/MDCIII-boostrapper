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

# echo "DEBUG: starting 1603_1.lib.sh"

# shellcheck source=3133368.lib.sh
. "${ROOTDIR}/999999999/3133368.lib.sh"

#######################################
# Update all repositories (if necessary)
#
# Globals:
#   ROOTDIR
#   GH_ORG_DEST
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_edit_1603_16_1__topics() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  # echo "${FUNCNAME[0]} TODO..."

  gh_repo_name="1603_16_1"
  repo_topics="unm49-001,world"

  # echo gh repo edit "$GH_ORG_DEST/$gh_repo_name" --add-topic "$repo_topics"
  gh repo edit "$GH_ORG_DEST/$gh_repo_name" --add-topic "$repo_topics"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize "world level" level 1603_16
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_init_1603_16_1() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  gh_repo_create_numerordinatio "1603_16_1" "🌐"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"

}
