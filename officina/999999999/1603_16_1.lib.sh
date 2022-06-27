#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16_1.lib.sh
#
#         USAGE:  #import on other scripts
#                 . "$ROOTDIR"/999999999/1603_16_1.lib.sh
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

# echo "DEBUG: starting 1603_16_1.lib.sh"

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
gh_repo_edit_1603_16_1__topics_and_description() {

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  # echo "${FUNCNAME[0]} TODO..."

  gh_repo_name="1603_16_1"
  repo_topics="unm49-001,world"
  gh_repo_emojis="🌐"

  # echo gh repo edit "$GH_ORG_DEST/$gh_repo_name" --add-topic "$repo_topics"
  gh repo edit "$GH_ORG_DEST/$gh_repo_name" --add-topic "$repo_topics"

  gh_repo_edit_description "$gh_repo_name" "$gh_repo_emojis"

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

#######################################
# Update 1603_16_1
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
gh_repo_update_1603_16_1() {
  gh_repo_name="1603_16_1"
  gh_repo_emojis="🌐"

  echo "::group::${gh_repo_name}"

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  # echo "TODO"

  archivum_no1__relative="1603/16/1/0/1603_16_1_0.no1.tm.hxl.csv"
  archivum_rdf_owl__relative="1603/16/1/0/1603_16_1_0.no1.owl.ttl"

  set -x
  "${ROOTDIR}/999999999/0/999999999_7200235.py" \
    --methodus='cod_ab_ad_no1_csv' \
    --numerordinatio-praefixo="1603_16" \
    >"${DESTDIR}/$archivum_no1__relative"

  frictionless validate "${DESTDIR}/$archivum_no1__relative"

  "${ROOTDIR}/999999999/0/999999999_7200235.py" \
    --methodus='cod_ab_index_levels_ttl' \
    --numerordinatio-praefixo="1603_16" \
    >"${DESTDIR}/$archivum_rdf_owl__relative"
  set +x

  # echo "@TODO also export the .no1.tm.hxl.csv"

  lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_no1__relative" "${DESTDIR}"
  lsf1603_to_gh_repo_local_file "$gh_repo_name" "$archivum_rdf_owl__relative" "${DESTDIR}"

  _gitattributes__localrepo="999999/3133368/${gh_repo_name}/.gitattributes"
  _gitattributes__templated="999999999/42302/.gitattributes"

  _datapackage_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/datapackage.json"
  _catalogxml_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/catalog-v001.xml"
  _csvmetadata_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/csv-metadata.json"
  _r2rml_cod_ab_all__localrepo="999999/3133368/${gh_repo_name}/mdciii.r2rml.ttl"
  _numerodinatio_cod_ab_all="${gh_repo_name}_0"

  set -x
  DATA_APOTHECAE_MINIMIS="1" \
    "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
    --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
    --data-apothecae-ad="$_datapackage_cod_ab_all__localrepo"

  "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
    --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
    --data-apothecae-ad="${_catalogxml_cod_ab_all__localrepo}"

  "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
    --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
    --data-apothecae-formato='csvw' \
    --data-apothecae-ad-stdout \
    > "$_csvmetadata_cod_ab_all__localrepo"

  "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
    --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
    --data-apothecae-formato='r2rml' \
    --data-apothecae-ad-stdout \
    > "$_r2rml_cod_ab_all__localrepo"

  # ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ad-stdout --data-apothecae-formato='r2rml' --data-apothecae-ex-suffixis='no1.tm.hxl.csv,no11.tm.hxl.csv' --data-apothecae-ex-praefixis='1603_1_1'
  set +x

  # shellcheck disable=SC2164
  cd "${DESTDIR}/999999/3133368/${gh_repo_name}"

  pwd
  frictionless validate "datapackage.json" || echo "FIX ME [${gh_repo_name}]. Know bug. not sure why frictionless is complaining here BUT works in production. Leaving notice here anyway"

  # shellcheck disable=SC2164
  cd "${ROOTDIR}"

  # @TODO when templated .gitattributes changes, this logic will need to
  #       be manually changed at least once
  if [ ! -f "$_gitattributes__localrepo" ]; then
    echo "Adding .gitattributes first time [$_gitattributes__localrepo]"
    cp "$_gitattributes__templated" "$_gitattributes__localrepo"
  fi

  gh_repo_edit_readme "$gh_repo_name" "${gh_repo_emojis}"
  gh_repo_sync_push "${gh_repo_name}"

  # ./999999999/0/999999999_7200235.py --methodus='cod_ab_ad_no1_csv'

  # ./999999999/0/999999999_7200235.py --methodus='cod_ab_index' --punctum-separato-ad-tab --cum-columnis='#country+code+v_unm49,#country+code+v_iso3,#country+code+v_iso2,#meta+source+cod_ab_level,#date+created,#date+updated'

  echo "::endgroup::"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}
