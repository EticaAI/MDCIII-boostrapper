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
  echo "  sudo chown 1603:1603 -R 999999/3133368/"

  # echo "$numerodinatio"
}

#######################################
# Initialize local repository with with very rudimentar content
#
# Globals:
#   ROOTDIR
# Arguments:
#   numerodinatio please use _ as delimitator (eg. 1603_16_24)
# Outputs:
#
#######################################
gh_repo_create_1603_16_N() {
  numerodinatio="$1"

  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.apothecae.todo.txt"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"
  _gh_homepage='https://github.com/EticaAI/lexicographi-sine-finibus'
  _gh_description="${numerodinatio}"
  _gh_commit_fiatlux="fīat lūx, ${numerodinatio}!"

  echo "${FUNCNAME[0]} [$numerodinatio]..."

  if [ ! -d "$trivium_basi" ]; then
    echo "mkdir [$trivium_basi] ...."
    mkdir "$trivium_basi"
  else
    echo "INFO: base dir already exist (mkdir [$trivium_basi])"
  fi

  if [ ! -f "${trivium_basi}/README.md" ]; then
    echo "initialize [${trivium_basi}/README.md] ...."
    echo "# ${numerodinatio}" >"${trivium_basi}/README.md"
  else
    echo "INFO: already exist (${trivium_basi}/README.md)"
  fi

  # echo "git -C '${trivium_basi}' init"
  # echo "git -C '${trivium_basi}' checkout master"
  # echo "git -C '${trivium_basi}' branch -m main"
  # echo "git -C '${trivium_basi}' add ."
  # echo "git -C '${trivium_basi}' commit -m '${_gh_commit_fiatlux}'"
  # echo "gh repo create 'MDCIII/${numerodinatio}' --source='${trivium_basi}' --public --description='${_gh_description}' --homepage='${_gh_homepage}' --disable-issues --disable-wiki"
  # echo "git -C '${trivium_basi}' push --set-upstream origin main"
  # echo "cd ${trivium_basi}"
  # echo "gh repo sync MDCIII/${numerodinatio}'"
  # echo "gh repo edit 'MDCIII/${numerodinatio}' --enable-projects=false"
  set -x
  cd "${trivium_basi}" || echo "ERROR FIX ME"
  git init
  git add .
  git commit -m "${_gh_commit_fiatlux}"

  git checkout master
  git branch -m main

  gh repo create "MDCIII/${numerodinatio}" --source="${trivium_basi}" \
    --public \
    --description="${_gh_description}" \
    --homepage="${_gh_homepage}" \
    --disable-issues --disable-wiki

  git push --set-upstream origin main
  gh repo edit "MDCIII/${numerodinatio}" --enable-projects=false

  set +x
  # DISPLAY=$DISPLAY git gui
}
