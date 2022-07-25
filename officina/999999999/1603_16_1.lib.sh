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
# Merge no1.tm.hxl.csv with wikiq.tm.hxl.csv
#
# Globals:
#   ROOTDIR
# Arguments:
#   numerordinatio
#   est_temporarium_fontem (default "1", from 99999/)
#   est_temporarium_objectivumm (dfault "0", from real namespace)
#   est_non_normale
#   hxlattrs (default "", example: '+rdf_p_skos_preflabel_s5000')
# Outputs:
#   Convert files
#######################################
file_merge_numerordinatio_de_wiki_q() {
  numerordinatio="$1"
  est_temporarium_fontem="${2:-"1"}"
  est_temporarium_objectivum="${3:-"0"}"
  est_non_normale="${4:-"0"}"
  hxlattrs="${5:-""}"

  echo "hxlattrs $hxlattrs"

  # sleep 10

  _path=$(numerordinatio_neo_separatum "$numerordinatio" "/")
  _nomen=$(numerordinatio_neo_separatum "$numerordinatio" "_")
  _prefix=$(numerordinatio_neo_separatum "$numerordinatio" ":")

  if [ "$est_temporarium_fontem" -eq "1" ]; then
    _basim_fontem="${ROOTDIR}/999999"
  else
    _basim_fontem="${ROOTDIR}"
  fi
  if [ "$est_temporarium_objectivum" -eq "1" ]; then
    _basim_objectivum="${ROOTDIR}/999999"
  else
    _basim_objectivum="${ROOTDIR}"
  fi

  fontem_archivum="${_basim_fontem}/$_path/$_nomen.no1.tm.hxl.csv"
  fontem_q_archivum="${_basim_fontem}/$_path/$_nomen.wikiq.tm.hxl.csv"
  objectivum_archivum="${_basim_objectivum}/$_path/$_nomen.no11.tm.hxl.csv"
  objectivum_archivum_temporarium="${ROOTDIR}/999999/0/$_nomen.no11.tm.hxl.csv"
  fontem_q_archivum_temporarium="${ROOTDIR}/999999/0/$_nomen.wikiq.tm.hxl.csv"
  fontem_q_archivum_temporarium_2="${ROOTDIR}/999999/0/$_nomen.wikiq.tm.hxl.csv"
  # objectivum_archivum_temporarium_b="${ROOTDIR}/999999/0/$_nomen.q.txt"
  # objectivum_archivum_temporarium_b_u="${ROOTDIR}/999999/0/$_nomen.uniq.q.txt"
  # objectivum_archivum_temporarium_b_u_wiki="${ROOTDIR}/999999/0/$_nomen.wikiq.tm.hxl.csv"

  # TODO: implement check if necessary to revalidate
  echo "${FUNCNAME[0]} sources changed_recently. Reloading... [$fontem_archivum]"

  # NOTE: explanation on the hotfix +ix_deleteme here:
  #       https://github.com/EticaAI/multilingual-lexicography/issues/
  #       29#issuecomment-1111707350
  #       This may be removed when hxlmerge --replace works with so many
  #       columns at once.

  if [ "$est_non_normale" -eq "1" ]; then
    # We apply 'hxlclean --lower' only on writting systems which this make
    # sence. On this case at least '+is_latn,+is_cyrl'
    hxlrename \
      --rename='item+conceptum+codicem:#item+rem+i_qcc+is_zxxx+ix_wikiq' \
      "$fontem_q_archivum" |
      hxlclean --lower='#*+is_latn,#*+is_cyrl' \
        >"$fontem_q_archivum_temporarium"
  else
    # We apply 'hxlclean --lower' only on writting systems which this make
    # sence. On this case at least '+is_latn,+is_cyrl'
    hxlrename \
      --rename='item+conceptum+codicem:#item+rem+i_qcc+is_zxxx+ix_wikiq' \
      "$fontem_q_archivum" \
      >"$fontem_q_archivum_temporarium"
  fi

  # cat "$fontem_q_archivum_temporarium"
  # exit 0

  # @TODO this pure bash part is ugly. Better be by calling some of the py
  #       scripts. But for now using this (Rocha, 2022-07-24 04:09 UTC)
  if [ "$hxlattrs" != "" ]; then
    echo "TODO..."
    sed -i '1d' "${fontem_q_archivum_temporarium}"
    _caput=$(head -n 1 "$fontem_q_archivum_temporarium")
    _caput_novo_arr=()

    cat "$fontem_q_archivum_temporarium" | head -n 2
    # exit 0

    echo "_caput [$_caput]"

    for i in ${_caput//,/ }; do
      # _item="$i"
      # call your procedure/other scripts here below
      # echo "$i"
      if [[ "$i" =~ .*"+conceptum".* || "$i" =~ .*"+i_qcc+is_zxxx".* ]]; then
        # explicity non linguitic; Use as it is
        __caput_novo_arr+=("$i")
        continue
      fi
      if [[ "$i" =~ .*"+rem+i_".* ]]; then
        # Likely linguistic, Lets try check if already contais

        if [[ "$i" =~ .*"$hxlattrs".* ]]; then
          # Likely linguistic, Lets try check if already contais
          __caput_novo_arr+=("$i")
          continue
        else
          _caput_novo_arr+=("${i}${hxlattrs}")
        fi
        continue
      fi
      # Some check failed. Adding as it is
      _caput_novo_arr+=("$i")
    done
    # echo "_caput_novo_arr"
    # echo "${_caput_novo_arr[*]}"

    # foo=('foo bar' 'foo baz' 'bar baz')
    _caput_novo_str=$(printf ",%s" "${_caput_novo_arr[@]}")
    _caput_novo_str=${_caput_novo_str:1}
    echo "_caput_novo_str $_caput_novo_str"

    echo "$_caput_novo_str" >"$fontem_q_archivum_temporarium_2"

    cat "$fontem_q_archivum_temporarium" | head -n 2
    exit 0
    cat "$fontem_q_archivum_temporarium" | tail -n+2 >>"$fontem_q_archivum_temporarium_2"

    echo "check $fontem_q_archivum_temporarium_2"

    sleep 20
  fi

  # hxlmerge --keys='#item+rem+i_qcc+is_zxxx+ix_wikiq' \
  #   --tags='#item+rem' \
  #   --merge="$fontem_q_archivum" \
  #   "$fontem_archivum" \
  #   >"$objectivum_archivum_temporarium"

  # echo "oi2"

  hxlmerge --keys='#item+rem+i_qcc+is_zxxx+ix_wikiq' \
    --tags='#item+rem' \
    --merge="$fontem_q_archivum_temporarium" \
    "$fontem_archivum" \
    >"$objectivum_archivum_temporarium"

  # BUG: if we use hxlmerge --replace, instead of not be repeated on final
  #      dataset, we lost all additional column data. This migth be because
  #      we're far beyond typical number of columns libhxl-python is tested to
  #      work

  # set -x
  # hxlmerge --keys='#item+rem+i_qcc+is_zxxx+ix_wikiq' \
  #   --replace \
  #   --tags='#item+rem' \
  #   --merge="$fontem_q_archivum_temporarium" \
  #   "$fontem_archivum" \
  #   >"$objectivum_archivum_temporarium"
  # set +x

  # | hxlcut --exclude='#item+rem+i_qcc+is_zxxx+ix_wikiq+ix_deleteme'

  sed -i '1d' "${objectivum_archivum_temporarium}"

  file_hotfix_duplicated_merge_key "${objectivum_archivum_temporarium}" '#item+rem+i_qcc+is_zxxx+ix_wikiq'

  # cp "$objectivum_archivum_temporarium" "$objectivum_archivum_temporarium.tmp"
  # rm "$fontem_q_archivum_temporarium"

  # @TODO: disable this as file_update_if_necessary implemnt it
  frictionless validate "${objectivum_archivum_temporarium}"

  file_update_if_necessary "skip-validation" \
    "$objectivum_archivum_temporarium" \
    "$objectivum_archivum"

  return 0
}

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
#   DESTDIR
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
    >"$_csvmetadata_cod_ab_all__localrepo"

  "${ROOTDIR}/999999999/0/1603_1.py" --methodus='data-apothecae' \
    --data-apothecae-ex="${_numerodinatio_cod_ab_all}" \
    --data-apothecae-formato='r2rml' \
    --data-apothecae-ad-stdout \
    >"$_r2rml_cod_ab_all__localrepo"

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
  # gh_repo_sync_push "${gh_repo_name}"

  # ./999999999/0/999999999_7200235.py --methodus='cod_ab_ad_no1_csv'

  # ./999999999/0/999999999_7200235.py --methodus='cod_ab_index' --punctum-separato-ad-tab --cum-columnis='#country+code+v_unm49,#country+code+v_iso3,#country+code+v_iso2,#meta+source+cod_ab_level,#date+created,#date+updated'

  echo "::endgroup::"

  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY ${tty_normal}"
}

#######################################
# Update 1603_16_1_0 (ab level 0)
# Similar to bootstrap_1603_16_1_0__radix(), however reuse
# 1603_16_1_0.no1.tm.hxl.csv to re-generate the rest.
#
# Globals:
#   DESTDIR
# Arguments:
#
# Outputs:
#    999999/3133368/lexicographi-sine-finibus
#######################################
gh_repo_update_1603_16_1__boostrap_0() {
  gh_repo_name="1603_16_1"
  numerodinatio_group="${gh_repo_name}_0"

  _radix_apothecae="${DESTDIR}"
  _radix_localrepo="${DESTDIR}/999999/3133368/${gh_repo_name}"

  archivum_no1__relative="1603/16/1/0/1603_16_1_0.no1.tm.hxl.csv"
  archivum_no1_bcp47min__relative="1603/16/1/0/1603_16_1_0.no1.bcp47.csv"
  archivum_no1_owl__relative="1603/16/1/0/1603_16_1_0.no1.owl.ttl"
  #archivum_no1_skos__relative="not applicable"

  archivum_no11__relative="1603/16/1/0/1603_16_1_0.no11.tm.hxl.csv"
  archivum_no11_bcp47min__relative="1603/16/1/0/1603_16_1_0.no11.bcp47.csv"
  #archivum_no11_owl__relative="not applicable"
  archivum_no11_skos__relative="1603/16/1/0/1603_16_1_0.no11.skos.ttl"

  archivum_wikiq__relative="1603/16/1/0/1603_16_1_0.wikiq.tm.hxl.csv"

  csv_temporarium_1="${DESTDIR}/999999/0/${gh_repo_name}_0~TEMP~1.csv"
  csv_temporarium_2="${DESTDIR}/999999/0/${gh_repo_name}_0~TEMP~2.csv"

  ttl_temporarium_1="${DESTDIR}/999999/0/${gh_repo_name}_0~TEMP~1.ttl"
  ttl_temporarium_2="${DESTDIR}/999999/0/${gh_repo_name}_0~TEMP~2.ttl"

  printf "\n\t%40s\n" "${tty_blue}${FUNCNAME[0]} STARTED ${tty_normal}"
  start_time_fn_b=$(date +%s)

  ls -lha 1603/16/1/0/
  ls -lha "$_radix_localrepo"

  ## NO1 tm.hxl.csv ------------------------------------------------------------
  # 1603_16_1_0 is an special case which the table already is part of commited
  # data from lsf. We here are just make a redundant file validation

  set -x
  frictionless validate "${_radix_apothecae}/${archivum_no1__relative}"
  # cp "${_radix_apothecae}/${archivum_no1__relative}" "$csv_temporarium_1"
  set +x
  # file_update_if_necessary "skip-validation" \
  #   "${csv_temporarium_1}" \
  #   "${_radix_localrepo}/${archivum_no1__relative}"

  ## NO1 bcp47 -----------------------------------------------------------------
  # set -x
  # "${ROOTDIR}/999999999/0/999999999_54872.py" \
  #   --methodus=_temp_no1_to_no1_shortnames \
  #   --real-infile-path="${_radix_apothecae}/${archivum_no1__relative}" \
  #   >"${csv_temporarium_1}"

  # # Temporary fix: remove some generated tags with error: +ix_error
  # # Somewhat temporary: remove non-merget alts: +ix_alt1|+ix_alt12|+ix_alt13
  # # Non-temporary: remove implicit tags: +ix_hxlattrs
  # hxlcut \
  #   --exclude='#*+ix_error,#*+ix_hxlattrs,#*+ix_alt1,#*+ix_alt2,#*+ix_alt3' \
  #   "${csv_temporarium_1}" >"${csv_temporarium_2}"

  # # Delete first line ,,,,,
  # sed -i '1d' "${csv_temporarium_2}"

  # "${ROOTDIR}/999999999/0/999999999_54872.py" \
  #   --methodus=_temp_data_hxl_to_bcp47 \
  #   --real-infile-path="${csv_temporarium_2}" >"${csv_temporarium_1}"

  # frictionless validate "${csv_temporarium_1}"

  # set +x
  # file_update_if_necessary "skip-validation" \
  #   "${csv_temporarium_1}" \
  #   "${_radix_apothecae}/${archivum_no1_bcp47min__relative}"

  file_convert_bpc47min_de_numerordinatio "${numerodinatio_group}" "no1" "0" "0"

  ## wikiq.tm.hxl.csv ----------------------------------------------------------
  # RESULT: 1603/16/1/0/1603_16_1_0.no1.tm.hxl.csv
  # NOTE:   this is the slowest step, as will fetch Wikidata translations

  # @TODO: uncomment next lines when this function is redy
  # ROOTDIR="$DESTDIR" \
  #   file_translate_csv_de_numerordinatio_q__v2 "$numerodinatio_group" "0" "0"

  ## NO11 tm.hxl.csv -----------------------------------------------------------
  # RESULT: 1603/16/1/0/1603_16_1_0.no11.tm.hxl.csv
  # We merge no1 + wikiq files into no11

  frictionless validate "1603/16/1/0/1603_16_1_0.no11.tm.hxl.csv"
  file_merge_numerordinatio_de_wiki_q "$numerodinatio_group" "0" "0" "0" "+rdf_p_skos_preflabel_s5000"

  echo "debug test exit early"
  exit 0

  ## NO1 bcp47min --------------------------------------------------------------
  set -x
  "${ROOTDIR}/999999999/0/999999999_54872.py" \
    --methodus=_temp_data_hxl_to_bcp47 \
    --real-infile-path="${archivum_no1__relative}" >"${csv_temporarium_1}"

  frictionless validate "${csv_temporarium_1}"
  set +x

  file_update_if_necessary "skip-validation" \
    "${csv_temporarium_1}" \
    "${_radix_apothecae}/${archivum_no1_bcp47min__relative}"

  # return 0

  ## NO11 bcp47min -------------------------------------------------------------
  # set -x
  # "${ROOTDIR}/999999999/0/999999999_54872.py" \
  #   --methodus=_temp_data_hxl_to_bcp47 \
  #   --real-infile-path="${archivum_no11__relative}" >"${csv_temporarium_1}"

  # frictionless validate "${csv_temporarium_1}"

  # set +x
  # file_update_if_necessary "skip-validation" \
  #   "${csv_temporarium_1}" \
  #   "${_radix_apothecae}/${archivum_no11_bcp47min__relative}"

  file_convert_bpc47min_de_numerordinatio "${numerodinatio_group}" "no11" "0" "0"

  ## NO1 RDF/OWL ---------------------------------------------------------------
  # Computational-like RDF serialization, "OWL version"
  # @TODO fix generation of invalid format if
  #       --rdf-sine-spatia-nominalibus=skos,devnull is enabled
  rdf_ontologia_ordinibus='4'
  rdf_trivio='5000'
  set -x
  "${ROOTDIR}/999999999/0/999999999_54872.py" \
    --methodus=_temp_no1 \
    --numerordinatio-cum-antecessoribus \
    --rdf-sine-spatia-nominalibus=devnull \
    --rdf-ontologia-ordinibus="${rdf_ontologia_ordinibus}" \
    --rdf-trivio="${rdf_trivio}" \
    <"${_radix_apothecae}/${archivum_no1__relative}" >"${ttl_temporarium_1}"

  rdfpipe --input-format=turtle --output-format=longturtle \
    "${ttl_temporarium_1}" \
    >"${ttl_temporarium_2}"

  riot --validate "${ttl_temporarium_2}"
  set +x

  file_update_if_necessary "skip-validation" \
    "${ttl_temporarium_2}" \
    "${_radix_apothecae}/${archivum_no1_owl__relative}"

  ## NO11 RDF/SKOS -------------------------------------------------------------
  # Linguistic-like RDF serialization, "SKOS version"
  # @TODO fix invalid generation if disabling OWL with
  #        --rdf-sine-spatia-nominalibus=owl

  # head -n 2 "${_radix_apothecae}/${archivum_no11__relative}"
  # sleep 5
  rdf_ontologia_ordinibus='4'
  rdf_trivio='5000'
  set -x
  "${ROOTDIR}/999999999/0/999999999_54872.py" \
    --methodus=_temp_no1 \
    --numerordinatio-cum-antecessoribus \
    --rdf-sine-spatia-nominalibus=obo,geo,wdata,devnull \
    --rdf-ontologia-ordinibus="${rdf_ontologia_ordinibus}" \
    --rdf-trivio="${rdf_trivio}" \
    <"${_radix_apothecae}/${archivum_no11__relative}" >"${ttl_temporarium_1}"

  rdfpipe --input-format=turtle --output-format=longturtle \
    "${ttl_temporarium_1}" \
    >"${ttl_temporarium_2}"

  riot --validate "${ttl_temporarium_2}"
  set +x

  file_update_if_necessary "skip-validation" \
    "${ttl_temporarium_2}" \
    "${_radix_apothecae}/${archivum_no11_skos__relative}"

  # sleep 15

  ## DEPLOY files to local repository ------------------------------------------
  # Note: at this point we assume all files are well validated and checked

  archivum_copiae_simplici \
    "${_radix_apothecae}/${archivum_no1__relative}" \
    "${_radix_localrepo}/${archivum_no1__relative}"

  ## Fini ----------------------------------------------------------------------
  set -x
  ls -lha 1603/16/1/0/
  ls -lha "$_radix_localrepo"
  set +x

  end_time=$(date +%s)
  elapsed=$((end_time - start_time_fn_b))
  printf "\t%40s\n" "${tty_green}${FUNCNAME[0]} FINISHED OKAY in ${elapsed}s ${tty_normal}"
}
