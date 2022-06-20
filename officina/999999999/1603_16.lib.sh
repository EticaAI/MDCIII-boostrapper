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

GH_ORG="${GH_ORG:-"MDCIII"}"
GH_ORG_DEST="${GH_ORG_DEST:$GH_ORG}"
ARTIFICIAL_THROTTLING="${ARTIFICIAL_THROTTLING:-"1"}"
UNM49_INITIALI="${UNM49_INITIALI:-"0"}"
UNM49_FINALI="${UNM49_FINALI:-"999"}"

AUTOMATON__1603_16__CPLP_UNICAE="${AUTOMATON__1603_16__CPLP_UNICAE:-"1"}"

# Brazil	076	BRA
# Cabo Verde	132	CPV
# Guinea-Bissau	624	GNB
# Mozambique	508	MOZ
# Portugal	620	PRT
# Sao Tome and Principe	678	STP
# Timor-Leste	626	TLS
# China, Macao Special Administrative Region	446	MAC
# declare -a UN_M49_CPLP=("24" "76" "132" "446" "624" "508" "620" "626" "678")

# Brazil we do later (we have far more admin2 Brazilian data to integrate)
declare -a UN_M49_CPLP=("24" "132" "446" "624" "508" "620" "626" "678")

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

# @TODO move bootstrap_1603_45_16__item_rdf to 1603_45_16.lib.sh at
#       @EticaAI/lexicographi-sine-finibus. For now this is just a quick
#       test (Rocha, 2022-06-19 23:25 UTC)

#######################################
# Convert the XLSXs to intermediate formats on 999999/1603/45/16 using
# 999999999_7200235.py to 1603/45/16/{cod_ab_level}/
#
# @TODO: potentially use more than one source (such as IGBE data for BRA)
#        instead of direclty from OCHA
#
# Globals:
#   ROOTDIR
#   DESTDIR
#
# Arguments:
#   numerordinatio_praefixo
#   unm49
#   iso3661p1a3
#   pcode_praefixo
#   cod_ab_level_max
#   est_temporarium_fontem
#   est_temporarium_objectivum
#   rdf_ontologia_ordinibus     (Tip: "5" if prefix 1603_45_16, "4" if 1603_16)
#
# Outputs:
#   Convert files
#######################################
bootstrap_1603_45_16__item_rdf() {
  numerordinatio_praefixo="$1"
  unm49="${2}"
  iso3661p1a3="${3}"
  pcode_praefixo="${4}"
  cod_ab_level_max="${5}"
  est_temporarium_fontem="${6:-"1"}"
  est_temporarium_objectivum="${7:-"0"}"
  rdf_ontologia_ordinibus="${8:-"5"}"

  if [ "$est_temporarium_fontem" -eq "1" ]; then
    _basim_fontem="${ROOTDIR}/999999"
  else
    _basim_fontem="${ROOTDIR}"
  fi
  if [ "$est_temporarium_objectivum" -eq "1" ]; then
    _basim_objectivum="${DESTDIR}/999999"
  else
    _basim_objectivum="${DESTDIR}"
  fi

  # 1603_45_16 -> 1603/45/16
  __group_path=$(numerordinatio_neo_separatum "$numerordinatio_praefixo" "/")

  _iso3661p1a3_lower=$(echo "$iso3661p1a3" | tr '[:upper:]' '[:lower:]')

  fontem_archivum="${_basim_fontem}/1603/45/16/xlsx/${_iso3661p1a3_lower}.xlsx"
  # objectivum_archivum_basi="${_basim_objectivum}/1603/45/16/${unm49}"
  objectivum_archivum_basi="${_basim_objectivum}/${__group_path}/${unm49}"
  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/${unm49}~lvl.tsv"
  opus_temporibus_temporarium="${DESTDIR}/999999/0/${unm49}~1.ttl"
  opus_temporibus_temporarium_2="${DESTDIR}/999999/0/${unm49}~2.ttl"

  printf "\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [$numerordinatio_praefixo] [$unm49] [$iso3661p1a3] [$pcode_praefixo]${tty_normal}"

  # for file_path in "${ROOTDIR}"/999999/1603/45/16/xlsx/*.xlsx; do
  # ISO3166p1a3_original=$(basename --suffix=.xlsx "$file_path")
  # ISO3166p1a3=$(echo "$ISO3166p1a3_original" | tr '[:lower:]' '[:upper:]')
  # UNm49=$(numerordinatio_codicem_locali__1603_45_49 "$ISO3166p1a3")

  # if [ ! -d "$objectivum_archivum_basi" ]; then
  #   mkdir "$objectivum_archivum_basi"
  # fi

  # file_xlsx="${ISO3166p1a3_original}.xlsx"

  echo "cod_ab_levels $cod_ab_level_max"

  for ((i = 0; i <= cod_ab_level_max; i++)); do
    cod_level="$i"
    if [ "$_iso3661p1a3_lower" == "bra" ] && [ "$cod_level" == "2" ]; then
      echo ""
      echo "Skiping COD-AB-BR lvl 2"
      echo ""
      continue
    fi

    objectivum_archivum_basi_lvl="${objectivum_archivum_basi}/${cod_level}"
    # objectivum_archivum_no1="${objectivum_archivum_basi_lvl}/${numerordinatio_praefixo}_${unm49}_${cod_level}.no1.tm.hxl.csv"
    objectivum_archivum_no1="${objectivum_archivum_basi_lvl}/${numerordinatio_praefixo}_${unm49}_${cod_level}.no1.tm.hxl.csv"

    objectivum_archivum_no1_owl_ttl="${objectivum_archivum_basi_lvl}/${numerordinatio_praefixo}_${unm49}_${cod_level}.no1.owl.ttl"
    objectivum_archivum_no1_skos_ttl="${objectivum_archivum_basi_lvl}/${numerordinatio_praefixo}_${unm49}_${cod_level}.no1.skos.ttl"

    # set -x
    # rm "$objectivum_archivum_no1" || true
    # set +x
    # continue
    echo "  cod-ab-$_iso3661p1a3_lower-$cod_level [$objectivum_archivum_no1] ..."
    # if [ ! -d "$objectivum_archivum_basi_lvl" ]; then
    #   mkdir "$objectivum_archivum_basi_lvl"
    # fi

    # echo "TODO"

    rdf_trivio=$((5000 + cod_level))

    ##  Computational-like RDF serialization, "OWL version" --------------------

    # @TODO fix generation of invalid format if
    #       --rdf-sine-spatia-nominalibus=skos,devnull is enabled

    # "${ROOTDIR}/999999999/0/999999999_54872.py" \
    #   --objectivum-formato=_temp_no1 \
    #   --numerordinatio-cum-antecessoribus \
    #   --rdf-sine-spatia-nominalibus=skos,devnull \
    #   --rdf-ontologia-ordinibus="${rdf_ontologia_ordinibus}" \
    #   --rdf-trivio="${rdf_trivio}" \
    #   <"${objectivum_archivum_no1}" >"${opus_temporibus_temporarium}"

    "${ROOTDIR}/999999999/0/999999999_54872.py" \
      --objectivum-formato=_temp_no1 \
      --numerordinatio-cum-antecessoribus \
      --rdf-sine-spatia-nominalibus=devnull \
      --rdf-ontologia-ordinibus="${rdf_ontologia_ordinibus}" \
      --rdf-trivio="${rdf_trivio}" \
      <"${objectivum_archivum_no1}" >"${opus_temporibus_temporarium}"

    rapper --quiet --input=turtle --output=turtle \
      "${opus_temporibus_temporarium}" \
      >"${objectivum_archivum_no1_owl_ttl}"

    riot --validate "${objectivum_archivum_no1_owl_ttl}"

    ##  Linguistic-like RDF serialization, "SKOS version" ----------------------
    # @TODO fix invalid generation if disabling OWL with
    #        --rdf-sine-spatia-nominalibus=owl

    # "${ROOTDIR}/999999999/0/999999999_54872.py" \
    #   --objectivum-formato=_temp_no1 \
    #   --numerordinatio-cum-antecessoribus \
    #   --rdf-sine-spatia-nominalibus=owl,obo,p,geo,devnull \
    #   --rdf-ontologia-ordinibus="${rdf_ontologia_ordinibus}" \
    #   --rdf-trivio="${rdf_trivio}" \
    #   <"${objectivum_archivum_no1}" >"${opus_temporibus_temporarium_2}"

    "${ROOTDIR}/999999999/0/999999999_54872.py" \
      --objectivum-formato=_temp_no1 \
      --numerordinatio-cum-antecessoribus \
      --rdf-sine-spatia-nominalibus=obo,p,geo,devnull \
      --rdf-ontologia-ordinibus="${rdf_ontologia_ordinibus}" \
      --rdf-trivio="${rdf_trivio}" \
      <"${objectivum_archivum_no1}" >"${opus_temporibus_temporarium_2}"

    rapper --quiet --input=turtle --output=turtle \
      "${opus_temporibus_temporarium_2}" \
      >"${objectivum_archivum_no1_skos_ttl}"

    riot --validate "${objectivum_archivum_no1_skos_ttl}"
    set +x

    echo "OWL TTL: [${objectivum_archivum_no1_owl_ttl}]"
    echo "SKOS TTL: [${objectivum_archivum_no1_skos_ttl}]"

    rm "$opus_temporibus_temporarium"
    rm "$opus_temporibus_temporarium_2"

  done

  # return 0
  # done
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
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
#   numerodinatio please use _ as delimitator (eg. 1603_16_24)
# Outputs:
#
#######################################
gh_repo_create_numerordinatio() {
  numerodinatio="$1"

  # opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.apothecae.todo.txt"
  trivium_basi="${ROOTDIR}/999999/3133368/${numerodinatio}"
  _gh_homepage='https://github.com/EticaAI/lexicographi-sine-finibus'
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
    gh_name_remote=$(curl --silent https://api.github.com/repos/${GH_ORG}/${numerodinatio} | jq .name)

    # echo "gh_name_remote [curl --silent https://api.github.com/repos/${GH_ORG}/${numerodinatio} | jq .name]"
    # echo "gh_name_remote [$gh_name_remote]"

    if [ "$gh_name_remote" != "null" ]; then
      # echo "TODO pull to local dir"
      set -x
      mkdir "$trivium_basi"
      git clone "git@github.com:${GH_ORG}/${numerodinatio}.git" "$trivium_basi"
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
  _gh_homepage='https://github.com/EticaAI/lexicographi-sine-finibus'
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

  gh_repo_combine "" ""
  echo "TODO merge 999999_1603_16"

  echo "TO PURGE:"
  echo "    rm -r ${trivium_basi}"

  echo "Note: if this is first time, you need to initialize also the data"
  echo "   gh_repo_init_lexicographi_sine_finibus_1603_16_NNN"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Initialize
#
# Globals:
#   ROOTDIR
#   AUTOMATON__1603_16__CPLP_UNICAE
#   UNM49_INITIALI
#   UNM49_FINALI
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_init_lexicographi_sine_finibus_1603_16_NNN() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [CPLP_UNICAE [$AUTOMATON__1603_16__CPLP_UNICAE]] [initiale [$UNM49_INITIALI]] [finale [$UNM49_FINALI]] ${tty_normal}"

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

  # if [ "$AUTOMATON__1603_16__CPLP_UNICAE" = "1" ]; then
  #   echo "TODO 1 AUTOMATON__1603_16__CPLP_UNICAE"
  # else
  #   echo "TODO 0 AUTOMATON__1603_16__CPLP_UNICAE"
  # fi

  # for i in "${UN_M49_CPLP[@]}"; do
  #   echo "$i"
  #   # or do whatever with individual element of the array
  #   # gh_repo_create_numerordinatio "1603_16_$i"
  # done

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
      # echo ""
      # echo "        ${linea[*]}"
      # echo "unm49 $unm49"
      # echo "v_iso3 $v_iso3"
      # echo "v_iso2 $v_iso2"

      idnow="$unm49"
      initialis="$UNM49_INITIALI"
      finalis="$UNM49_FINALI"
      # echo " $idnow $initialis $finalis"
      if ((idnow < initialis)); then
        continue
      fi
      if ((idnow > finalis)); then
        continue
      fi
      echo "        ${linea[*]}"

      if [ "$AUTOMATON__1603_16__CPLP_UNICAE" = "1" ]; then
        # echo "TODO 1 AUTOMATON__1603_16__CPLP_UNICAE"
        # shellcheck disable=SC2076
        if [[ " ${UN_M49_CPLP[*]} " =~ " ${unm49} " ]]; then
          # echo " (quicktesting) Skiping non AGO  <${linea[*]}>"
          echo "CPLP [${unm49}]..."
        else
          echo "Skiping [${unm49}] CPLP_UNICAE [$AUTOMATON__1603_16__CPLP_UNICAE]"
          continue
        fi
      # else
      #   echo "TODO 0 AUTOMATON__1603_16__CPLP_UNICAE"
      fi

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

      # echo "        ${linea[*]}"

      # gh_repo_name="1603_16_${unm49}"
      gh_repo_create_numerordinatio "1603_16_${unm49}"

      if [ "$AUTOMATON__1603_16__CPLP_UNICAE" != "1" ]; then
        printf "\t%40s\n" "${tty_blue} INFO: artificial forced sleep [$ARTIFICIAL_THROTTLING]s ${tty_normal}"
        sleep "$ARTIFICIAL_THROTTLING"
      fi

      # printf "\t%40s\n" "${tty_red} DEBUG: [Sleep 10 (@TODO disable me later)] ${tty_normal}"
      # sleep 10
    done
  } <"${opus_temporibus_temporarium}"

  # gh_repo_name="1603_16_24"
  # gh_repo_local="${ROOTDIR}/999999/3133368/${gh_repo_name}"
  # archivum_relative_path="1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv"

  # lsf1603_to_gh_repo_local_file "1603_16_24" "1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv" "${ROOTDIR}"
  # lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_relative_path" "${ROOTDIR}"
  # archivum_copiae_simplici "${ROOTDIR}/1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv" "${ROOTDIR}/999999/3133368/1603_16_24/1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv"
  # archivum_copiae_simplici "${ROOTDIR}/1603/16/24/0/1603_16_24_0.no1.tm.hxl.csv" "${gh_repo_local}/${archivum_relative_path}"
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Update all repositories (if necessary)
#
# Globals:
#   ROOTDIR
#   AUTOMATON__1603_16__CPLP_UNICAE
#   UNM49_INITIALI
#   UNM49_FINALI
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_update_lexicographi_sine_finibus_1603_16_NNN() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [CPLP_UNICAE [$AUTOMATON__1603_16__CPLP_UNICAE]] [initiale [$UNM49_INITIALI]] [finale [$UNM49_FINALI]] ${tty_normal}"
  # echo "${FUNCNAME[0]} TODO..."

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

  # if [ "$AUTOMATON__1603_16__CPLP_UNICAE" = "1" ]; then
  #   echo "TODO 1 AUTOMATON__1603_16__CPLP_UNICAE"
  # else
  #   echo "TODO 0 AUTOMATON__1603_16__CPLP_UNICAE"
  # fi

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
      # echo ""
      # echo "        ${linea[*]}"
      # echo "unm49 $unm49"
      # echo "v_iso3 $v_iso3"
      # echo "v_iso2 $v_iso2"

      idnow="$unm49"
      initialis="$UNM49_INITIALI"
      finalis="$UNM49_FINALI"
      # echo " $idnow $initialis $finalis"
      if ((idnow < initialis)); then
        continue
      fi
      if ((idnow > finalis)); then
        continue
      fi

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

      # # if [ "$unm49" != "24" ]; then
      # # if [[ " ${UN_M49_CPLP[*]} " =~ " ${unm49} " ]]; then
      # # shellcheck disable=SC2076
      # if [[ " ${UN_M49_CPLP[*]} " =~ " ${unm49} " ]]; then
      #   # echo " (quicktesting) Skiping non AGO  <${linea[*]}>"
      #   echo "CPLP [${unm49}]..."
      # else
      #   echo "Skiping [${unm49}]"
      #   continue
      # fi

      if [ "$AUTOMATON__1603_16__CPLP_UNICAE" = "1" ]; then
        # echo "TODO 1 AUTOMATON__1603_16__CPLP_UNICAE"
        # shellcheck disable=SC2076
        if [[ " ${UN_M49_CPLP[*]} " =~ " ${unm49} " ]]; then
          # echo " (quicktesting) Skiping non AGO  <${linea[*]}>"
          echo "CPLP [${unm49}]..."
        else
          echo "Skiping [${unm49}] CPLP_UNICAE [$AUTOMATON__1603_16__CPLP_UNICAE]"
          continue
        fi
      # else
      #   echo "TODO 0 AUTOMATON__1603_16__CPLP_UNICAE"
      fi

      # echo "sleeping 10 @todo remove me"
      # sleep 10
      # echo ""
      echo "        ${linea[*]}"

      gh_repo_name="1603_16_${unm49}"
      # gh_repo_local="${ROOTDIR}/999999/3133368/${gh_repo_name}"
      # fontem_archivum_basi="${ROOTDIR}/${__group_path}/${unm49}"
      # __group_path=$(numerordinatio_neo_separatum "$numerordinatio_praefixo" "/")
      # bootstrap_1603_45_16__item_no1 "$numerordinatio_praefixo" "$unm49" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"
      # bootstrap_1603_45_16__item_rdf "$numerordinatio_praefixo" "$unm49" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"

      echo "cod_ab_levels $cod_ab_level_max"

      bootstrap_1603_45_16__item_no1 "1603_16" "${unm49}" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"
      bootstrap_1603_45_16__item_rdf "1603_16" "${unm49}" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0" "4"
      arr__numerodinatio_cod_ab=()

      for ((i = 0; i <= cod_ab_level_max; i++)); do
        cod_level="$i"
        gh_repo_name_et_level="${gh_repo_name}_${cod_level}"
        __group_path=$(numerordinatio_neo_separatum "$gh_repo_name_et_level" "/")

        archivum_no1__relative="${__group_path}/${gh_repo_name_et_level}.no1.tm.hxl.csv"
        archivum_rdf_owl__relative="${__group_path}/${gh_repo_name_et_level}.no1.owl.ttl"
        archivum_rdf_skos__relative="${__group_path}/${gh_repo_name_et_level}.no1.skos.ttl"

        arr__numerodinatio_cod_ab+=("${gh_repo_name_et_level}")

        # if [ "$_iso3661p1a3_lower" == "bra" ] && [ "$cod_level" == "2" ]; then
        #   echo ""
        #   echo "Skiping COD-AB-BR lvl 2"
        #   echo ""
        #   continue
        # fi
        # echo "loop $cod_level [${__group_path}/${gh_repo_name_et_level}.no1.tm.hxl.csv]"
        # echo "loop $cod_level [${gh_repo_local}/${__group_path}/${gh_repo_name_et_level}.no1.tm.hxl.csv]"

        lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_no1__relative" "${ROOTDIR}"
        lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_rdf_owl__relative" "${ROOTDIR}"
        lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_rdf_skos__relative" "${ROOTDIR}"

        _codex_meta="{\"#item+rem+i_qcc+is_zxxx+ix_n1603\": \"${gh_repo_name_et_level}\", \"#item+rem+i_mul+is_zyyy\": \"${gh_repo_name_et_level}\"}"

        # _datapackage_cod_ab_lvl="${ROOTDIR}/${__group_path}/datapackage.json"
        _datapackage_cod_ab_lvl="${__group_path}/datapackage.json"

        CODEX_AD_HOC_NUMERORDINATIO="$_codex_meta" \
          "${ROOTDIR}/999999999/0/1603_1.py" --methodus='status-quo' \
          --status-quo-in-datapackage \
          --codex-de="${gh_repo_name_et_level}" \
          >"${ROOTDIR}/${_datapackage_cod_ab_lvl}"

        frictionless validate "${ROOTDIR}/${_datapackage_cod_ab_lvl}"
        lsf1603_to_gh_repo_local_file "$gh_repo_name" "$_datapackage_cod_ab_lvl" "${ROOTDIR}"

      done

      # __group_path_basi=$(numerordinatio_neo_separatum "${gh_repo_name}" "/")
      # gh_repo_local="${ROOTDIR}/999999/3133368/${gh_repo_name}"
      _datapackage_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/datapackage.json"
      _catalogxml_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/catalog-v001.xml"
      _catalogxml_cod_ab_all__localrepo_old="999999/3133368/${gh_repo_name}/catalog-v004.xml"

      _numerodinatio_cod_ab_all=$(printf ",%s" "${arr__numerodinatio_cod_ab[@]}")
      _numerodinatio_cod_ab_all=${_numerodinatio_cod_ab_all:1}
      # echo "_numerodinatio_cod_ab_all [$_numerodinatio_cod_ab_all]"
      # exit 1
      # _numerodinatio_cod_ab_all="1603_16_24_0,1603_16_24_1,1603_16_24_2,1603_16_24_3"

      set -x
      DATA_APOTHECAE_MINIMIS="1" \
        "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
        --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
        --data-apothecae-ad="$_datapackage_cod_ab_all__localrepo"

      "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
        --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
        --data-apothecae-ad="${_catalogxml_cod_ab_all__localrepo}"
      set +x

      if [ -f "$_catalogxml_cod_ab_all__localrepo_old" ]; then
        echo "Deleting old file [$_catalogxml_cod_ab_all__localrepo_old]"
        rm "$_catalogxml_cod_ab_all__localrepo_old"
      fi

      # python3 /workspace/git/EticaAI/lexicographi-sine-finibus/officina/999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex="$_datapackage_cod_ab_all__localrepo" --data-apothecae-ad="${_catalogxml_cod_ab_all__localrepo}"

      cd "999999/3133368/${gh_repo_name}"
      pwd
      frictionless validate "datapackage.json" || echo "FIX ME [${gh_repo_name}]. Know bug. not sure why frictionless is complaining here but works in production. Maybe permissions?"
      cd "${ROOTDIR}" || true
      # No need to move (already is at the local repo)
      # lsf1603_to_gh_repo_local_file "$gh_repo_name" "$_datapackage_cod_ab_all" "${ROOTDIR}"

      # /999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_45_1,1603_45_31' --data-apothecae-ad='999999/0/apotheca2e.datapackage.json'

      gh_repo_sync_push "${gh_repo_name}"

      ## Disabled artificial forced sleep; previous steps already take time.
      # if [ "$AUTOMATON__1603_16__CPLP_UNICAE" != "1" ]; then
      #   printf "\t%40s\n" "${tty_blue} INFO: artificial forced sleep [$ARTIFICIAL_THROTTLING]s ${tty_normal}"
      #   sleep "$ARTIFICIAL_THROTTLING"
      # fi

      # printf "\t%40s\n" "${tty_red} DEBUG: [Sleep 10 (@TODO disable me later)] ${tty_normal}"
      # sleep 10
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

###############################################################################

#### To initialize first time
# local_system_dependencies_python
# gh_repo_fetch_lexicographi_sine_finibus
