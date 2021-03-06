#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16.lib.sh
#
#         USAGE:  #import on other scripts
#                 . "$ROOTDIR"/999999999/1603_16.lib.sh
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
# __lsf_999999999_lib="${__lsf_clone_local}/officina/999999999/999999999.lib.sh"
__lsf_1603_45_16_lib="${__lsf_clone_local}/officina/999999999/1603_45_16.lib.sh"
_ROOTDIR="${__lsf_clone_local}/officina"

GH_ORG="${GH_ORG:-"MDCIII"}"
GH_ORG_DEST="${GH_ORG_DEST:-$GH_ORG}"
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

# shellcheck source=3133368.lib.sh
. "${ROOTDIR}/999999999/3133368.lib.sh"

## We also need to load 1603_45_16.lib.sh
# shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/1603_45_16.lib.sh
ROOTDIR="$_ROOTDIR" . "$__lsf_1603_45_16_lib"

# if [ -f "$__lsf_999999999_lib" ]; then
#   # echo "OKAY: previous LSF already cached"
#   # shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/999999999.lib.sh
#   ROOTDIR="$_ROOTDIR" . "$__lsf_999999999_lib"
#   # shellcheck source=../999999/3133368/lexicographi-sine-finibus/officina/999999999/1603_45_16.lib.sh
#   ROOTDIR="$_ROOTDIR" . "$__lsf_1603_45_16_lib"
# else
#   echo "ERROR: LSF not cached."
#   exit 1
# fi

#######################################
# (Re)fech GitHub.com/EticaAI/lexicographi-sine-finibus (if necessary)
#
# @see - https://GitHub.blog
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

  _lsf_repo="https://GitHub.com/EticaAI/lexicographi-sine-finibus.git"
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
# Initialize "country" level 1603_16
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
      if ((idnow <= initialis)); then
        continue
      fi
      if ((idnow >= finalis)); then
        continue
      fi

      gh_action_subgroup="1603_16_${unm49}"
      echo "::group::${gh_action_subgroup}"

      echo "        ${linea[*]}"

      if [ "$AUTOMATON__1603_16__CPLP_UNICAE" = "1" ]; then
        # echo "TODO 1 AUTOMATON__1603_16__CPLP_UNICAE"
        # shellcheck disable=SC2076
        if [[ " ${UN_M49_CPLP[*]} " =~ " ${unm49} " ]]; then
          # echo " (quicktesting) Skiping non AGO  <${linea[*]}>"
          echo "CPLP [${unm49}]..."
        else
          echo "Skiping [${unm49}] CPLP_UNICAE [$AUTOMATON__1603_16__CPLP_UNICAE]"
          echo "::endgroup::"
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
      echo "::endgroup::"
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
      if ((idnow <= initialis)); then
        continue
      fi
      if ((idnow >= finalis)); then
        continue
      fi

      gh_action_subgroup="1603_16_${unm49}"
      echo "::group::${gh_action_subgroup}"

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
        echo "::endgroup::"
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
          echo "::endgroup::"
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
      emoji_country_flag=$(emoji_country_flag_from_iso3661p1a2 "$v_iso2")
      # gh_repo_local="${ROOTDIR}/999999/3133368/${gh_repo_name}"
      # fontem_archivum_basi="${ROOTDIR}/${__group_path}/${unm49}"
      # __group_path=$(numerordinatio_neo_separatum "$numerordinatio_praefixo" "/")
      # bootstrap_1603_45_16__item_no1 "$numerordinatio_praefixo" "$unm49" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"
      # bootstrap_1603_45_16__item_rdf "$numerordinatio_praefixo" "$unm49" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"

      echo "cod_ab_levels [$cod_ab_level_max] emoji_country_flag [$emoji_country_flag]"

      bootstrap_1603_45_16__item_no1 "1603_16" "${unm49}" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0"
      bootstrap_1603_45_16__item_bcp47 "1603_16" "${unm49}" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0" "4"
      bootstrap_1603_45_16__item_rdf "1603_16" "${unm49}" "$v_iso3" "$v_iso2" "$cod_ab_level_max" "1" "0" "4"
      arr__numerodinatio_cod_ab=()

      for ((i = 0; i <= cod_ab_level_max; i++)); do
        cod_level="$i"
        gh_repo_name_et_level="${gh_repo_name}_${cod_level}"
        __group_path=$(numerordinatio_neo_separatum "$gh_repo_name_et_level" "/")

        archivum_no1__relative="${__group_path}/${gh_repo_name_et_level}.no1.tm.hxl.csv"
        archivum_bcp47__relative="${__group_path}/${gh_repo_name_et_level}.no1.bcp47.csv"
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
        lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_bcp47__relative" "${ROOTDIR}"
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
      _csvmetadata_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/csv-metadata.json"
      _r2rml_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/mdciii.r2rml.ttl"
      _catalogxml_cod_ab_all__localrepo_old="999999/3133368/${gh_repo_name}/catalog-v004.xml"
      _gitattributes__localrepo="999999/3133368/${gh_repo_name}/.gitattributes"
      _gitattributes__templated="999999999/42302/.gitattributes"

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

      DATA_APOTHECAE_MINIMIS="1" \
        "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
        --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
        --data-apothecae-ad="${_catalogxml_cod_ab_all__localrepo}"

      DATA_APOTHECAE_MINIMIS="1" \
        "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
        --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
        --data-apothecae-formato='csvw' \
        --data-apothecae-ad-stdout \
        >"$_csvmetadata_cod_ab_all__localrepo"

      # Not enabling yet r2rml for all (2022-06-26)
      # "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
      #   --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
      #   --data-apothecae-formato='r2rml' \
      #   --data-apothecae-ad-stdout \
      #   > "$_r2rml_cod_ab_all__localrepo"

      set +x

      if [ -f "$_catalogxml_cod_ab_all__localrepo_old" ]; then
        echo "Deleting old file [$_catalogxml_cod_ab_all__localrepo_old]"
        rm "$_catalogxml_cod_ab_all__localrepo_old"
      fi

      # @TODO when templated .gitattributes changes, this logic will need to
      #       be manually changed at least once
      if [ ! -f "$_gitattributes__localrepo" ]; then
        echo "Adding .gitattributes first time [$_gitattributes__localrepo]"
        cp "$_gitattributes__templated" "$_gitattributes__localrepo"
      fi

      gh_repo_edit_readme "$gh_repo_name" "${emoji_country_flag}"

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
      echo "::endgroup::"
    done
  } <"${opus_temporibus_temporarium}"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Update GitHub topics of 1603_16_NNN repositories, the "country" level ones
#
# Globals:
#   ROOTDIR
#   GH_ORG_DEST
#   AUTOMATON__1603_16__CPLP_UNICAE
#   UNM49_INITIALI
#   UNM49_FINALI
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_edit_1603_16_NNN__topics_and_description() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED [CPLP_UNICAE [$AUTOMATON__1603_16__CPLP_UNICAE]] [initiale [$UNM49_INITIALI]] [finale [$UNM49_FINALI]] ${tty_normal}"
  # echo "${FUNCNAME[0]} TODO..."

  opus_temporibus_temporarium="${ROOTDIR}/999999/0/1603_45_16.todo.tsv"

  # set -x
  NUMERORDINATIO_BASIM="$NUMERORDINATIO_BASIM" "${ROOTDIR}/999999999/0/999999999_7200235.py" \
    --methodus='cod_ab_index' \
    --punctum-separato-ad-tab \
    --cum-columnis='#country+code+v_unm49,#country+code+v_iso3,#country+code+v_iso2,#meta+source+cod_ab_level,#date+created,#date+updated,#country+name+ref,#country+name+alt' \
    >"${opus_temporibus_temporarium}"
  # set +x

  echo ""
  echo "  LIST HERE <${opus_temporibus_temporarium}>"
  echo ""

  {
    # remove read -r to not skip first line
    read -r
    while IFS=$'\t' read -r -a linea; do
      unm49="${linea[0]}"
      v_iso3="${linea[1]}"
      v_iso2="${linea[2]}"
      cod_ab_level_max="${linea[3]}"
      # shellcheck disable=SC2034
      name_ref="${linea[6]}"
      name_alt="${linea[6]}"
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
      if ((idnow <= initialis)); then
        continue
      fi
      if ((idnow >= finalis)); then
        continue
      fi

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

      # echo "        ${linea[*]}"

      # repo_topic=$(echo "$name_ref" | tr -cd '[:print:]' | tr '[:upper:]' '[:lower:]' | tr '[:space:]' '-')
      repo_topic_english=$(echo "$name_alt" | tr -cd '[:print:]' | tr '[:upper:]' '[:lower:]' | tr '[:space:]' '-')

      unm49_completus=$(printf "%03d" "$unm49")
      v_iso3_lower=$(echo "$v_iso3" | tr '[:upper:]' '[:lower:]')

      # @TODO actually fetch Wikidata P9100 and use the previous topic.
      #       see https://www.wikidata.org/wiki/Property:P9100
      #       (Rocha, 2022-06-22 02:48 UTC)

      ## Poor's man hacky way to infer typical GitHub-topic for places, START --
      # where we can't copy  official names for places.
      # Aka names either very formal like "venezuela-(bolivarian-republic-of)"
      # or which the formal name have.

      # >>> "unm49-068,bol,bolivia-(plurinational-state-of)"
      if [ "$v_iso3_lower" == "bol" ]; then
        repo_topic_english="bolivia"
      fi
      # >>> "unm49-060,bmu,bermuda-(uk)"
      # >>> https://www.wikidata.org/wiki/Q23635
      if [ "$v_iso3_lower" == "bmu" ]; then
        repo_topic_english="bermuda"
      fi
      # >>> ""unm49-384,civ,cte-d'ivoire""
      # >>> https://www.wikidata.org/wiki/Q1008
      if [ "$v_iso3_lower" == "civ" ]; then
        repo_topic_english="ivory-coast"
      fi
      # >>> "unm49-364,irn,iran-(islamic-republic-of)"
      if [ "$v_iso3_lower" == "irn" ]; then
        repo_topic_english="iran"
      fi
      # >>> "unm49-862,ven,venezuela-(bolivarian-republic-of)"
      if [ "$v_iso3_lower" == "ven" ]; then
        repo_topic_english="venezuela"
      fi
      # >>> "unm49-630,pri,puerto-rico-(usa)"
      if [ "$v_iso3_lower" == "pri" ]; then
        repo_topic_english="puerto-rico"
      fi
      # >>> "unm49-408,prk,democratic-people's-republic-of-korea"
      # > https://www.wikidata.org/wiki/Q423
      if [ "$v_iso3_lower" == "prk" ]; then
        repo_topic_english="north-korea"
      fi
      # >>> "unm49-760,syr,syrian-arab-republic"
      if [ "$v_iso3_lower" == "syr" ]; then
        repo_topic_english="syria"
      fi
      # >>> "unm49-418,lao,lao-people's-democratic-republic"
      # > https://www.wikidata.org/wiki/Q819
      if [ "$v_iso3_lower" == "lao" ]; then
        repo_topic_english="laos"
      fi
      # >>> "unm49-136,cym,cayman-islands-(uk)"
      if [ "$v_iso3_lower" == "cym" ]; then
        repo_topic_english="cayman-islands"
      fi
      # >>> "unm49-583,fsm,micronesia-(federated-states-of)"
      # > https://www.wikidata.org/wiki/Q702 (No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "fsm" ]; then
        repo_topic_english="micronesia"
      fi
      # >>> "unm49-796,tca,turks-and-caicos-islands-(uk)"
      # > https://www.wikidata.org/wiki/Q18221 (No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "tca" ]; then
        repo_topic_english="turks-and-caicos-islands"
      fi
      # >>> "unm49-534,sxm,sint-maarten-(neth.)"
      # > https://www.wikidata.org/wiki/Q26273 (No GitHub topic as 2022-06-23)
      # > https://www.wikidata.org/wiki/Q25596
      #   (French and Dutch Caribbean island in the Lesser Antilles),
      #   (No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "sxm" ]; then
        repo_topic_english=""
      fi
      # >>> "unm49-850,vir,united-states-virgin-islands-(usa)"
      # https://www.wikidata.org/wiki/Q11703 (No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "vir" ]; then
        repo_topic_english="united-states-virgin-islands"
      fi
      # >>> "unm49-092,vgb,british-virgin-islands-(uk)"
      # https://www.wikidata.org/wiki/Q25305 (No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "vgb" ]; then
        repo_topic_english="british-virgin-islands"
      fi
      # >>> "unm49-643,rus,russian-federation"
      # > https://www.wikidata.org/wiki/Q159
      if [ "$v_iso3_lower" == "rus" ]; then
        repo_topic_english="russia"
      fi
      # >>> "unm49-500,msr,montserrat-(uk)"
      # > https://www.wikidata.org/wiki/Q13353 (yes, have previous GitHub topic)
      if [ "$v_iso3_lower" == "msr" ]; then
        repo_topic_english="montserrat"
      fi

      # >>> "unm49-474,mtq,martinique-(fr.)"
      # > https://www.wikidata.org/wiki/Q17054 (No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "mtq" ]; then
        repo_topic_english="martinique"
      fi
      # >>> "unm49-312,glp,guadeloupe-(fr.)"
      # > https://www.wikidata.org/wiki/Q17012 (yes, have previous GitHub topic)
      if [ "$v_iso3_lower" == "glp" ]; then
        repo_topic_english="guadeloupe"
      fi
      # >>> "unm49-254,guf,french-guiana-(fr.)"
      # > https://www.wikidata.org/wiki/Q3769 No GitHub topic as 2022-06-23)
      if [ "$v_iso3_lower" == "guf" ]; then
        # No idea which name use here even as temporary
        repo_topic_english=""
      fi
      # >>> "unm49-834,tza,united-republic-of-tanzania"
      # > https://www.wikidata.org/wiki/Q924 (yes, have previous GitHub topic)
      if [ "$v_iso3_lower" == "tza" ]; then
        repo_topic_english="tanzania"
      fi
      # >>> "unm49-704,vnm,viet-nam"
      # > https://www.wikidata.org/wiki/Q881 (yes, have previous GitHub topic)
      if [ "$v_iso3_lower" == "vnm" ]; then
        repo_topic_english="vietnam"
      fi
      # >>> "unm49-562,ner,niger"
      # > https://www.wikidata.org/wiki/Q1032 (yes, have previous GitHub topic
      #   and is really niger
      if [ "$v_iso3_lower" == "ner" ]; then
        repo_topic_english="niger"
      fi
      ## Poor's man hacky way to infer typical GitHub-topic for places, END ----

      if [ "$repo_topic_english" = "" ]; then
        repo_topics="unm49-$unm49_completus,$v_iso3_lower"
      else
        repo_topics="unm49-$unm49_completus,$v_iso3_lower,$repo_topic_english"
      fi

      # No topiics at all
      # - saint-vincent-and-the-grenadines
      #   - https://www.wikidata.org/wiki/Q757

      # Differences
      # - syrian-arab-republic( https://www.wikidata.org/wiki/Q858 )
      #  - syria

      gh_repo_name="1603_16_${unm49}"
      gh_repo_emojis=$(emoji_country_flag_from_iso3661p1a2 "$v_iso2")

      # echo "TODO gh repo edit \"$GH_ORG_DEST/$gh_repo_name\" --add-topic \"$repo_topic\""
      # echo "TODO gh repo edit \"$GH_ORG_DEST/$gh_repo_name\" --add-topic \"$repo_topics\""

      # echo "TODO gh_repo_name [$gh_repo_name] [$gh_repo_emojis]"

      gh_repo_edit_description "$gh_repo_name" "$gh_repo_emojis"

      # echo gh repo edit "$GH_ORG_DEST/$gh_repo_name" --add-topic "$repo_topics"
      gh repo edit "$GH_ORG_DEST/$gh_repo_name" --add-topic "$repo_topics"

      # gh repo edit "MDCIII/1603_16_76" --add-topic "unm49-076,bra,brazil"

      echo "https://github.com/${GH_ORG_DEST}/${gh_repo_name}"

      _ARTIFICIAL_THROTTLING=3
      printf "\t%40s\n" "${tty_blue} INFO: artificial forced sleep [$_ARTIFICIAL_THROTTLING]s ${tty_normal}"
      sleep "$_ARTIFICIAL_THROTTLING"
    done
  } <"${opus_temporibus_temporarium}"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

###############################################################################

#### To initialize first time
# local_system_dependencies_python
# gh_repo_fetch_lexicographi_sine_finibus
