#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16.sh
#
#         USAGE:  #import on other scripts
#                 . "$ROOTDIR"/999999999/999999999.lib.sh
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


#######################################
# Initialize local repository with with very rudimentar content
#
# Globals:
#   ROOTDIR
# Arguments:
#   numerodinatio
# Outputs:
#   
#######################################
localdirs_permisions_fix() {
  numerodinatio="$1"

  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.apothecae.todo.txt"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"

  echo "${FUNCNAME[0]} [$numerodinatio]..."

  echo "RUN THIS:"
  echo "  sudo chown 1000:1603 -R 999999/"
  echo "  sudo chmod 1775 -R 999999/"


  # echo "$numerodinatio"
}


#######################################
# Initialize local repository with with very rudimentar content
#
# Globals:
#   ROOTDIR
# Arguments:
#   numerodinatio
# Outputs:
#   
#######################################
gh_repo_create_1603_16_N() {
  numerodinatio="$1"

  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.apothecae.todo.txt"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"

  echo "${FUNCNAME[0]} [$numerodinatio]..."

  if [ ! -d "$trivium_basi" ]; then
    echo "mkdir [$trivium_basi] ...."
    mkdir "$trivium_basi"
  else
    echo "INFO: base dir already exist (mkdir [$trivium_basi])"
  fi

  if [ ! -f "${trivium_basi}/README.md" ]; then
    echo "initialize [${trivium_basi}/README.md] ...."
    echo "# ${numerodinatio}" > "${trivium_basi}/README.md"
  else
    echo "INFO: already exist (${trivium_basi}/README.md)"
  fi
}
