#!/bin/bash
#===============================================================================
#
#          FILE:  0_3.sh
#
#         USAGE:  ./999999999/0_3.sh
#
#   DESCRIPTION:  Install dependencies and fech
#                 github.com/EticaAI/lexicographi-sine-finibus (but without
#                 yet additional dependencies) so other scripts can reuse
#                 the 999999999.lib.sh and etc
#
#       OPTIONS:  ---
#
#  REQUIREMENTS:  - Bash shell (or better)
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Emerson Rocha <rocha[at]ieee.org>
#       COMPANY:  EticaAI
#       LICENSE:  Public Domain dedication or Zero-Clause BSD
#                 SPDX-License-Identifier: Unlicense OR 0BSD
#       VERSION:  v1.0
#       CREATED:  2022-06-15 23:40 UTC
#===============================================================================
# Comment next line if not want to stop on first error
set -e

ROOTDIR="$(pwd)"
# shellcheck disable=SC2034
NUMERORDINATIO_BASIM="$ROOTDIR"

# The next part is necessary because we assume 999999999.lib.sh is not at the
# disk yet, but we can show colorful messages
#### Fancy colors constants - - - - - - - - - - - - - - - - - - - - - - - - - -
tty_blue=$(tput setaf 4)
tty_green=$(tput setaf 2)
# tty_red=$(tput setaf 1)
tty_normal=$(tput sgr0)

## Example
# printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
# printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
# printf "\t%40s\n" "${tty_blue} INFO: [] ${tty_normal}"
# printf "\t%40s\n" "${tty_red} ERROR: [] ${tty_normal}"
#### Fancy colors constants - - - - - - - - - - - - - - - - - - - - - - - - - -

#######################################
# (Re)fech github.com/EticaAI/lexicographi-sine-finibus (if necessary)
#
# @see - https://github.blog
#        /2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/
#      - https://stackoverflow.com/questions/6802145
#        /how-to-convert-a-git-shallow-clone-to-a-full-clone
#
# Note: this function is both at 1603_16.lib.sh and 0_3.sh
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_fetch_lexicographi_sine_finibus() {
  # numerodinatio="$1"
  # shallow="${1:-"0"}"
  # @TODO remove shallow option
  shallow="0"

  _lsf_repo="https://github.com/EticaAI/lexicographi-sine-finibus.git"
  trivium_basi="${ROOTDIR}/999999/3133368/lexicographi-sine-finibus"

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"

  if [ ! -d "$trivium_basi" ]; then
    echo "mkdir [$trivium_basi] ...."
    mkdir "$trivium_basi"

    pwd

    cd "${trivium_basi}" || exit

    pwd
    ls -lha

    if [ "$shallow" -eq "1" ]; then
      echo "git clone --depth=1 \"$_lsf_repo\" ."
      git clone --depth=1 "$_lsf_repo" .
    else
      echo "git clone --filter=blob:none \"$_lsf_repo\" ."
      git clone --filter=blob:none "$_lsf_repo" .
    fi
    ls -lha

  else
    printf "\t%40s\n" "${tty_blue} INFO: base dir already exist [$trivium_basi] ${tty_normal}"
    set -x
    cd "${trivium_basi}" || exit
    # ls -lha
    # If the folder already exist, and the user is re-requesting again
    # we cannot use --dept 1
    # @see
    # git fetch --unshallow

    git status
    echo "git --git-dir /workspace/git/EticaAI/n-data.git-metadata --work-tree ${trivium_basi} gui"

    git pull
    # ls -lha
    cd "$ROOTDIR" || exit
    set +x
  fi

  # @TODO 1603_1_99 is used to generate documentation. We need better way
  #       to have a cache of files such as this. For now just a quick hacky
  _temp_1603_1_99="$trivium_basi/officina/1603/1/99/1603_1_99.no1.tm.hxl.csv"
  _temp_1603_1_99_lsfcache="https://raw.githubusercontent.com/EticaAI/lsf-cache/main/1603/1/99/1603_1_99.no1.tm.hxl.csv"
  if [ ! -f "$_temp_1603_1_99" ]; then
    curl --output "$_temp_1603_1_99" "$_temp_1603_1_99_lsfcache"
  fi

  # https://raw.githubusercontent.com/EticaAI/lsf-cache/main/1603/1/99/1603_1_99.no1.tm.hxl.csv

  echo "TO PURGE:"
  echo "    rm -r ${trivium_basi}"

  echo "Note: if this is first time, you need to initialize also the data"
  echo "   gh_repo_fetch_lexicographi_sine_finibus_1603_16_init"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# (Re)fech github.com/EticaAI/lexicographi-sine-finibus (if necessary)
#
# @see - https://github.blog
#        /2020-12-21-get-up-to-speed-with-partial-clone-and-shallow-clone/
#      - https://stackoverflow.com/questions/6802145
#        /how-to-convert-a-git-shallow-clone-to-a-full-clone
#
# Note: this function is both at 1603_16.lib.sh and 0_3.sh
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_fetch_lexicographi_sine_finibus_1603_16_init_xslx() {
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  echo "@TODO zzzzmake this function more flexible. for now is just a quick workaround"

  trivium_basi_lsf="${ROOTDIR}/999999/3133368/lexicographi-sine-finibus/officina"
  trivium_basi_cache="/workspace/git/EticaAI/lexicographi-sine-finibus/officina"
  _basim_fontem="${trivium_basi_cache}/999999/1603/45/16/xlsx"
  _basim_objectivum="${trivium_basi_lsf}/999999/1603/45/16/xlsx"

  # /workspace/git/EticaAI/lexicographi-sine-finibus/officina/999999/1603/45/16/1603_45_16.index.hxl.csv
  # fontem_index="${ROOTDIR}/999999/1603/45/16/1603_45_16.index.hxl.csv"
  fontem_index="${trivium_basi_cache}/999999/1603/45/16/1603_45_16.index.hxl.csv"
  # objectivum_index="${trivium_basi_cache}/999999/1603/45/16/1603_45_16.index.hxl.csv"
  objectivum_index="${ROOTDIR}/999999/1603/45/16/1603_45_16.index.hxl.csv"

  # for file_path in "${ROOTDIR}"/999999/1603/45/16/xlsx/*.xlsx; do

  echo "ls $_basim_fontem"
  ls "${_basim_fontem}"

  echo "ls $_basim_objectivum"
  ls "${_basim_objectivum}"

  for file_path in "${_basim_fontem}"/*.xlsx; do
    # ISO3166p1a3_original=$(basename --suffix=.xlsx "$file_path")
    nomen=$(basename "$file_path")
    # echo "$file_path $ISO3166p1a3_original $nomen"
    if [ ! -f "${_basim_objectivum}/$nomen" ]; then
      echo "cp [$nomen] ..."
      # echo "cp $file_path ${_basim_objectivum}/$nomen"
      cp "$file_path" "${_basim_objectivum}/$nomen"
    fi
  done

  if [ ! -f "${objectivum_index}" ]; then
    echo "cp [$fontem_index] [$objectivum_index] ..."
    # echo "cp $file_path ${_basim_objectivum}/$nomen"
    cp "$fontem_index" "${objectivum_index}"
  else
    echo "Index okay [${objectivum_index}]"
    ls -lha "${objectivum_index}"
  fi

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize local repository with with very rudimentar content
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#
#######################################
local_permisions_fix() {
  echo "${FUNCNAME[0]}..."

  echo "RUN THIS:"
  echo "  sudo chown 1000:1603 -R 999999/"
  echo "  sudo chmod 1775 -R 999999/"
  echo "  sudo chown 1603:1603 -R 999999/3133368/"
  echo ""
  # echo "  sudo mkdir 1603/"
  # echo "  sudo chown 1000:1603 -R 1603/"
  # echo "  sudo chmod 1775 -R 1603/"
  # echo "  sudo chown 1603:1603 -R 1603/"
  echo ""
  echo "AFTER main LSF already be ready"
  echo "  sudo ln --relative --symbolic 999999/3133368/lexicographi-sine-finibus/officina/999999999/0 999999999/0"
  echo "  sudo ln --relative --symbolic 999999/3133368/lexicographi-sine-finibus/officina/999999/1603 999999/1603"
  echo "  sudo ln --relative --symbolic 999999/3133368/lexicographi-sine-finibus/officina/1603 1603"
  # echo "  sudo chown 1000:1603 -R 1603/"
  # echo "  sudo chmod 1775 -R 1603/"
  # echo "  sudo chown 1603:1603 -R 1603/"

  # echo "$numerodinatio"
}

#######################################
# (Re) install python dependencies, if necessary
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#
#######################################
local_system_dependencies_python() {
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"

  pip3 install hxltm-eticaai
  pip3 install libhxl
  pip3 install openpyxl
  pip3 install frictionless

  echo "Testing versions"

  echo "hxltmcli --versionem"
  hxltmcli --versionem

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#### main ______________________________________________________________________

## This is manual step
# local_permisions_fix
local_system_dependencies_python
gh_repo_fetch_lexicographi_sine_finibus
gh_repo_fetch_lexicographi_sine_finibus_1603_16_init_xslx
