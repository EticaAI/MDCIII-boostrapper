#!/bin/bash
#===============================================================================
#
#          FILE:  3133368.lib.sh
#
#         USAGE:  #import on other scripts
#                 . "${ROOTDIR}/999999999/3133368.lib.sh"
#
#   DESCRIPTION:  This is a shared library used by MDCIII-boostrapper.
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
#       CREATED:  2022-06-22 21:20 UTC started based on 1603_16.lib.sh
#      REVISION:  ---
#===============================================================================

# echo "DEBUG: starting 3133368.lib.sh"

__lsf_clone_local="${ROOTDIR}/999999/3133368/lexicographi-sine-finibus"
__lsf_999999999_lib="${__lsf_clone_local}/officina/999999999/999999999.lib.sh"
_ROOTDIR="${__lsf_clone_local}/officina"

GH_ORG="${GH_ORG:-"MDCIII"}"
GH_ORG_DEST="${GH_ORG_DEST:-$GH_ORG}"

if [ -f "$__lsf_999999999_lib" ]; then
  # shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/999999999.lib.sh
  ROOTDIR="$_ROOTDIR" . "$__lsf_999999999_lib"
else
  echo "ERROR: LSF not cached. Hardcoded requeriment for 3133368.lib.sh"
  exit 1
fi

#######################################
# Convert a ISO 3166 part 1 alpha 2 into Unicode emoji
#
# Globals:
#
# Arguments:
#   iso3661p1a2
# Outputs:
#   Emoji  (may be not well formated)
#######################################
emoji_country_flag_from_iso3661p1a2() {
  iso3661p1a2="$1"

  emoji_flag=""
  for ((i = 0; i < ${#iso3661p1a2}; i++)); do
    # echo "${iso3661p1a2:$i:1}"
    emoji_part=$(emoji_from_alpha "${iso3661p1a2:$i:1}")
    emoji_flag="${emoji_flag}${emoji_part}"
  done
  echo "$emoji_flag"
}

#######################################
# Convert an Latin Letter to Unicode-style Emojis. The way implementers
# merge the final result may render things like country flags (see
# emoji_country_flag_from_iso3661p1a2)
#
# Globals:
#
# Arguments:
#   iso3661p1a2
# Outputs:
#   Emoji  (may be not well formated)
#######################################
emoji_from_alpha() {
  alpha="$1"
  alpha=${alpha^^}

  char_int=$(printf '%d' "'$alpha")
  char_int_unicode=$((char_int + 127397))
  emoji=$(echo $char_int_unicode | awk '{printf("%c", $1)}')
  echo "$emoji"
}

#######################################
# For two repositories already saved at officina/999999/3133368, copy files
# from first repository to the second repository.
#
# IMPORTANT: do not add "/" at the end of final of the paths. The function
#            will add it based on what rsync required
#
# Globals:
#   ROOTDIR
#   DESTDIR
# Arguments:
#   fons                (Exemplum: "999999_1603_16")
#   objectivus          (Exemplum: "lexicographi-sine-finibus")
#   trivium_fonti       (Exemplum: "999999")
#   trivium_objectivo   (Exemplum: "officina/999999")
# Outputs:
#
#######################################
gh_repo_combine() {
  fons="$1"
  objectivus="$2"
  trivium_fonti="$3"
  trivium_objectivo="$4"
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [$numerodinatio] ${tty_normal}"
  set -x
  rsync --dry-run --verbose --human-readable --checksum --recursive \
    "${ROOTDIR}/999999/3133368/${fons}/${trivium_fonti}/" \
    "${DESTDIR}/999999/3133368/${objectivus}/${trivium_objectivo}"
  set +x
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize local repository with with very rudimentar content.
# If directory does not exist locally, will try check from remote first.
#
# Globals:
#   ROOTDIR
#   GH_ORG
# Arguments:
#   numerodinatio  (please use _ as delimitator (eg. 1603_16_24))
# Outputs:
#
#######################################
gh_repo_create_numerordinatio() {
  numerodinatio="$1"
  suffixa="${2:-""}"

  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.apothecae.todo.txt"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"
  _gh_homepage='https://GitHub.com/EticaAI/lexicographi-sine-finibus'
  _gh_description="${numerodinatio}"
  _gh_commit_fiatlux="fīat lūx, ${numerodinatio}!"

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [$numerodinatio] ${tty_normal}"

  # @TODO check if repository exists on remote, then sync to local
  #       repo if already not in sync
  # gh repo list MDCIII --json=name
  # @see https://stackoverflow.com/questions/23914896/check-that-git-repository-exists

  if [ ! -d "$trivium_basi" ]; then
    echo "local repo not exist. Trying to pull remote first ..."
    gh_repo_sync_pull "$numerodinatio"
  fi

  if [ ! -d "$trivium_basi" ]; then
    echo "mkdir [$trivium_basi] ...."
    mkdir "$trivium_basi"
  else
    echo "INFO: base dir already exist (mkdir [$trivium_basi]). Trying to pull"
    gh_repo_sync_pull "$numerodinatio"
    printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
    return 0
  fi

  if [ ! -f "${trivium_basi}/README.md" ]; then
    echo "initialize [${trivium_basi}/README.md] ...."
    echo "# ${numerodinatio}" >"${trivium_basi}/README.md"
  else
    echo "INFO: already exist (${trivium_basi}/README.md)"
  fi

  if [ "$suffixa" != "" ]; then
    _gh_description="$_gh_description $suffixa"
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

  echo "INFO: since its first time, adding an seep 15 to avoid create "
  echo "      repositories too fast"
  sleep 15

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize local repository with with very rudimentar content.
# WARNING. This does not handle cases where the remote repository already exist
# but does not exist locallu
#
# Globals:
#   ROOTDIR
#   GH_ORG
# Arguments:
#   numerodinatio please use _ as delimitator (eg. 1603_16_24)
# Outputs:
#   Local repository syncronized with remote. If neither local git or
#   remote have reference to the requested numerodinatio, it will make
#   no changes
#######################################
gh_repo_sync_pull() {
  numerodinatio="$1"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"
  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [$numerodinatio] ${tty_normal}"

  if [ -d "$trivium_basi" ]; then
    # echo "local repo exist. Trying to pull ..."
    set -x
    git -C "${trivium_basi}" pull
    set +x
  else
    gh_name_remote=$(curl --silent https://api.GitHub.com/repos/${GH_ORG}/${numerodinatio} | jq .name)

    # echo "gh_name_remote [curl --silent https://api.GitHub.com/repos/${GH_ORG}/${numerodinatio} | jq .name]"
    # echo "gh_name_remote [$gh_name_remote]"

    if [ "$gh_name_remote" != "null" ]; then
      # echo "TODO pull to local dir"
      set -x
      mkdir "$trivium_basi"
      git clone "git@GitHub.com:${GH_ORG}/${numerodinatio}.git" "$trivium_basi"
      set +x
    else
      echo "Either API error or remote not exist. Continuing without changes"
    fi
  fi

  # echo "DEBUG ABORTING NOW"
  # exit 0

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Submit changes from local repository (only if necessary)
#
# Globals:
#   ROOTDIR
# Arguments:
#   numerodinatio please use _ as delimitator (eg. 1603_16_24)
# Outputs:
#
#######################################
gh_repo_sync_push() {
  numerodinatio="$1"

  # @TODO make

  _DEPLOY_0_9_COMMIT_MESSAGE="$(TZ=":Zulu" date +"%Y-%m-%d %T") 🤖🧮💾"
  DEPLOY_0_9_COMMIT_MESSAGE="${DEPLOY_0_9_COMMIT_MESSAGE:-${_DEPLOY_0_9_COMMIT_MESSAGE}}"

  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.apothecae.todo.txt"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"
  _gh_homepage='https://GitHub.com/EticaAI/lexicographi-sine-finibus'
  _gh_description="${numerodinatio}"
  # _gh_commit_fiatlux="fīat lūx, ${numerodinatio}!"
  # _gh_commit_fiatlux="$DEPLOY_0_9_COMMIT_MESSAGE"

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [$numerodinatio] ${tty_normal}"

  if [ ! -d "$trivium_basi" ]; then
    printf "\t%40s\n" "${tty_red} ERROR: local repo must already exist [$trivium_basi] ${tty_normal}"
    return 1
  fi

  cd "${trivium_basi}" || exit
  if [[ $(git status --porcelain) ]]; then
    # Changes
    echo "changes exist"
    set -x
    # pwd
    git -C "${trivium_basi}" add .
    git -C "${trivium_basi}" commit -m "${DEPLOY_0_9_COMMIT_MESSAGE}"
    git -C "${trivium_basi}" push
    set +x
  else
    # No changes
    echo "no changes"
  fi
  cd "${ROOTDIR}" || exit

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Fetch files from individual repository-like
# 999999/3133368/NNNN_NN_NN/NNNN/NN/NN/NNNN_NN.NN_NN.ext to
# NNNN/NN/NN/NNNN_NN.NN_NN.ext
#
# Globals:
#   ROOTDIR
# Arguments:
#   gh_repo_name           (Exemplum: 1603_16_24)
#   archivum_relative_path (Exemplum: 1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv)
#   basim_fontem           (Exemplum: "${ROOTDIR}")
# Outputs:
#    Only if necessary: create paths and (if not same hash) replace targed file
#    The base final path witll be "999999/3133368/${gh_repo_name}"
#######################################
lsf1603_to_gh_repo_local_file() {
  gh_repo_name="$1"
  archivum_relative_path="$2"
  basim_fontem="$3"

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [${gh_repo_name}] [${archivum_relative_path}] [${basim_fontem}] ${tty_normal}"

  fontem_archivum="${ROOTDIR}/${archivum_relative_path}"
  objectivum_archivum_repo_basi="${ROOTDIR}/999999/3133368/${gh_repo_name}"
  objectivum_archivum="${objectivum_archivum_repo_basi}/${archivum_relative_path}"
  objectivum_archivum_basi=$(dirname "${objectivum_archivum}")

  if [ ! -d "$objectivum_archivum_repo_basi" ]; then
    printf "\t%40s\n" "${tty_red} ERROR: dest repo not initialized [$objectivum_archivum_repo_basi] ${tty_normal}"
    exit 1
  fi
  if [ ! -d "$objectivum_archivum_basi" ]; then
    echo "Creating path [$objectivum_archivum_basi]..."
    mkdir -p "$objectivum_archivum_basi"
  fi

  # echo "${FUNCNAME[0]} TODO... [$objectivum_archivum_basi]"

  archivum_copiae_simplici "${fontem_archivum}" "${objectivum_archivum}"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}
