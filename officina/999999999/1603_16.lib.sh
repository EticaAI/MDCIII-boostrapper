#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16.lib.sh
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

__lsf_clone_local="${ROOTDIR}/999999/3133368/lexicographi-sine-finibus"
__lsf_999999999_lib="${__lsf_clone_local}/officina/999999999/999999999.lib.sh"
__lsf_1603_45_16_lib="${__lsf_clone_local}/officina/999999999/1603_45_16.lib.sh"
_ROOTDIR="${__lsf_clone_local}/officina"

# DESTDIR="" ## this need to be defined to reuse libs from main repository

if [ -f "$__lsf_999999999_lib" ]; then
  # echo "OKAY: previous LSF already cached"
  # shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/999999999.lib.sh
  ROOTDIR="$_ROOTDIR" . "$__lsf_999999999_lib"
  # shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/1603_45_16.lib.sh
  ROOTDIR="$_ROOTDIR" . "$__lsf_1603_45_16_lib"
else
  echo "ERROR: LSF not cached."
  exit 1
fi

# @TODO move this to 999999999.lib.sh and delete from 1603_16.lib.sh
#######################################
# Copy file from source to destiny if hashs are not equal. Simpler version
# than archivum_copiae since will do no validation checks
#
# Globals:
#
# Arguments:
#   fontem_archivum
#   objectivum_archivum
#
# Outputs:
#
#######################################
# archivum_copiae_simplici() {
#   fontem_archivum="$1"
#   objectivum_archivum="$2"

#   echo "${FUNCNAME[0]} ... [$fontem_archivum] --> [$objectivum_archivum]"

#   if [ -f "$objectivum_archivum" ]; then
#     objectivum_archivum_hash=$(sha256sum "$objectivum_archivum" | cut -d ' ' -f 1)
#     fontem_archivum_hash=$(sha256sum "$fontem_archivum" | cut -d ' ' -f 1)
#     if [[ "$fontem_archivum_hash" != "$objectivum_archivum_hash" ]]; then
#       echo "INFO: Not equal. Replacing now..."
#       # echo "Not equal. Copy now... [$fontem_archivum] --> [$objectivum_archivum]"
#       # sha256sum "$objectivum_archivum"
#       # sha256sum "$fontem_archivum"
#       rm "$objectivum_archivum"
#       cp "$fontem_archivum" "$objectivum_archivum"
#     else
#       echo "INFO: already equal. No need to copy"
#     fi
#   else
#     echo "INFO: copy for the first time"
#     cp "$fontem_archivum" "$objectivum_archivum"
#   fi

#   return 0
# }

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
    echo "SKIPING NOW all steps"
    return 0
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

  echo "TO PURGE:"
  echo "    rm -r ${trivium_basi}"

  echo "Note: if this is first time, you need to initialize also the data"
  echo "   gh_repo_fetch_lexicographi_sine_finibus_1603_16_init"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_fetch_lexicographi_sine_finibus_1603_16_init() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  echo "${FUNCNAME[0]} TODO..."

  # bootstrap_1603_45_16__item_no1 "1603_16" "24" "AGO" "AO" "3" "1" "0"
  # bootstrap_1603_45_16__item_rdf "1603_16" "24" "AGO" "AO" "3" "1" "0"

  gh_repo_name="1603_16_24"
  gh_repo_local="${ROOTDIR}/999999/3133368/${gh_repo_name}"
  archivum_relative_path="1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv"

  # lsf1603_to_gh_repo_local_file "1603_16_24" "1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv" "${ROOTDIR}"
  lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_relative_path" "${ROOTDIR}"
  # archivum_copiae_simplici "${ROOTDIR}/1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv" "${ROOTDIR}/999999/3133368/1603_16_24/1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv"
  archivum_copiae_simplici "${ROOTDIR}/1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv" "${gh_repo_local}/${archivum_relative_path}"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize
#
# Globals:
#   ROOTDIR
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_fetch_lexicographi_sine_finibus_1603_16_init__all() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  echo "${FUNCNAME[0]} TODO..."

  opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.todo.tsv"

  # set -x
  NUMERORDINATIO_BASIM="$NUMERORDINATIO_BASIM" "${ROOTDIR}/999999999/0/999999999_7200235.py" \
    --methodus='cod_ab_index' \
    --punctum-separato-ad-tab \
    --cum-columnis='#country+code+v_unm49,#country+code+v_iso3,#country+code+v_iso2,#meta+source+cod_ab_level,#date+created,#date+updated' \
    >"${opus_temporibus_temporarium}"
  # set +x

  echo ""
  echo "  LIST HERE <${opus_temporibus_temporarium}>"
  echo ""

  # while IFS=, read -r iso3 source_url; do
  {
    # remove read -r to not skip first line
    read -r
    while IFS=$'\t' read -r -a linea; do
      unm49="${linea[0]}"
      v_iso3="${linea[1]}"
      v_iso2="${linea[2]}"
      cod_ab_level_max="${linea[3]}"
      # numerordinatio_praefixo="1603_45_16"
      echo ""
      echo "        ${linea[*]}"
      # echo "unm49 $unm49"
      # echo "v_iso3 $v_iso3"
      # echo "v_iso2 $v_iso2"

      if [ "$unm49" = "426" ]; then
        echo " 2022-05-23: we will skip LSA admin1 for now as it cannot extract"
        echo " number (it use 3-letter P-codes)"
        ## 2022-05-23: we will skip LSA admin1 for now as it cannot extract
        ## number (it use 3-letter P-codes)
        # admin1Name_en	admin1Pcode
        # Maseru	LSA
        # Butha-Buthe	LSB
        # Leribe	LSC
        # (...)
        continue
      fi

      # bootstrap_1603_45_16__item_no1 "$numerordinatio_praefixo" "$unm49" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"
      # bootstrap_1603_45_16__item_rdf "$numerordinatio_praefixo" "$unm49" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"

      # printf "\t%40s\n" "${tty_red} DEBUG: [Sleep 5 (@TODO disable me later)] ${tty_normal}"
      # sleep 5
    done
  } <"${opus_temporibus_temporarium}"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Fech github.com/EticaAI/lexicographi-sine-finibus (if necessary)
#
#
# Globals:
#   ROOTDIR
# Arguments:
#   gh_repo_name           (Exemplum: 1603_16_24)
#   gh_repo_relative_path  (Exemplum: 1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv)
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

  echo "${FUNCNAME[0]} TODO... [$objectivum_archivum_basi]"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

###############################################################################

#### To initialize first time
# local_system_dependencies_python
# gh_repo_fetch_lexicographi_sine_finibus
