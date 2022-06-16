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

# The next part is necessary because we assume 999999999.lib.sh is not at the
# disk yet, but we can show colorful messages
#### Fancy colors constants - - - - - - - - - - - - - - - - - - - - - - - - - -
tty_blue=$(tput setaf 4)
tty_green=$(tput setaf 2)
tty_red=$(tput setaf 1)
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
  shallow="${1:-"0"}"

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
    echo "INFO: base dir already exist (mkdir [$trivium_basi])"
    set -x
    cd "${trivium_basi}" || exit
    ls -lha
    # If the folder already exist, and the user is re-requesting again
    # we cannot use --dept 1
    # @see
    # git fetch --unshallow
    git pull
    ls -lha
    set +x
  fi

  echo "TO PURGE:"
  echo "    rm -r ${trivium_basi}"

  echo "Note: if this is first time, you need to initialize also the data"
  echo "   gh_repo_fetch_lexicographi_sine_finibus_1603_16_init"
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

  echo "Testing versions"

  echo "hxltmcli --versionem"
  hxltmcli --versionem

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#### main ______________________________________________________________________

## This is manual step
# local_permisions_fix
gh_repo_fetch_lexicographi_sine_finibus
local_system_dependencies_python
