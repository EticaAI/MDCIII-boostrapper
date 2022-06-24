#!/bin/sh
#===============================================================================
#
#          FILE:  0_2.sh
#
#         USAGE:  ./999999999/0_2.sh
#
#   DESCRIPTION:  The happy path to initialy everything (sort of...)
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

## Example of log as local user
#     cd /workspace/git/EticaAI/MDCIII-boostrapper/officina
#     sudo su mdciii
#     source ~/.profile
# Test
#   hxltmcli --help
#   ./999999999/1603_16.sh
#
# Local web server (Python)
#    cd /workspace/git/EticaAI/MDCIII-boostrapper/
#    python3 -m http.server 1603 --bind 127.0.0.1 --directory ./officina/
#    # Open http://127.0.0.1:1603/
#
# Local web server (PHP)
#    cd /workspace/git/EticaAI/MDCIII-boostrapper/
#    php -S 127.0.0.1:1603 -t ./officina/
#    # Open http://127.0.0.1:1603/
# Protege
#    /opt/Protege-5.5.0/run.sh

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/0_3.sh"
bash "${ROOTDIR}/999999999/0_3.sh"

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/999999_1603_1.sh"
bash "${ROOTDIR}/999999999/999999_1603_1.sh"

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/999999_1603_16.sh"
bash "${ROOTDIR}/999999999/999999_1603_16.sh"

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/1603_16_1.sh"
bash "${ROOTDIR}/999999999/1603_16_1.sh"

#### Temp ______________________________________________________________________
# ./999999999/0/1603_1.py --methodus='status-quo' --status-quo-in-json --codex-de 1603_16_24_0
# CODEX_AD_HOC_NUMERORDINATIO='{"#item+rem+i_qcc+is_zxxx+ix_n1603": "1603_16_24_0", "#item+rem+i_mul+is_zyyy": "1603_16_24_0 Angola 0"}'  ./999999999/0/1603_1.py --methodus='status-quo' --status-quo-in-datapackage --ex-librario='locale' --codex-de 1603_16_24_0

# CODEX_AD_HOC_NUMERORDINATIO='{"#item+rem+i_qcc+is_zxxx+ix_n1603": "1603_16_24_0", "#item+rem+i_mul+is_zyyy": "1603_16_24_0 Angola 0"}'  ./999999999/0/1603_1.py --methodus='status-quo' --status-quo-in-datapackage  --codex-de 1603_16_24_0

# --codex-in-tabulam-json

## @TODO the one with general statuses
# ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_45_1,1603_45_31' --data-apothecae-ad='apothecae.datapackage.json'

# ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_45_1,1603_45_31' --data-apothecae-ad='999999/0/apothecae.datapackage.json'

# ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_16_24_0,1603_16_24_1,1603_16_24_2,1603_16_24_3' --data-apothecae-ad='999999/0/apothecae.datapackage.json'

# python3 /workspace/git/EticaAI/lexicographi-sine-finibus/officina/999999999/0/1603_1.py --help
# python3 /workspace/git/EticaAI/lexicographi-sine-finibus/officina/999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_16_24_0,1603_16_24_1,1603_16_24_2,1603_16_24_3' --data-apothecae-ad='999999/0/catalog-v001.xml'

# hxltmcli 999999/999999/hxltm-exemplum-linguam.tm.hxl.csv --objectivum-formulam='999999999/42302/exemplum-linguam.🗣️.json' --tmeta='999999/999999/hxltm-exemplum-linguam.tmeta.yml'

#### 1568346 (Testcase 2022-06-19) _____________________________________________
# 999999999/1568346
# > - https://www.wikidata.org/wiki/Q1568346
# >   - > test case (Q1568346)
#
#
# echo "  sudo chown 1000:1603 -R 999999/"
# echo "  sudo chmod 1775 -R 999999/"
# echo "  sudo chown 1603:1603 -R 999999/3133368/"

# 1568346_20220619

# gh repo create "MDCIII/1568346_20220619" --disable-issues --disable-wiki --license UNLICENSE --public
# gh repo clone MDCIII/1568346_20220619

# @TODO make a cached version of 1603/1 path. The @EticaAI/lsf-cache, even
#       only the last commit, have unecessary higher times

#### .github/profile/README.md
# https://github.com/MDCIII

gh_repo_create_MDCIII_dot_github() {
  # Used only first time.
  mkdir /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999/3133368/.github
  cd /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999/3133368/.github
  git init
  cp -r /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999999/42302/MDCIII/.github/* /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999/3133368/.github/
  git add .
  git commit -m 'fīat lūx'
  git checkout master
  git branch -m main
  gh repo create "MDCIII/.github" --public --disable-issues --disable-wiki --source=. --homepage="https://github.com/EticaAI/lexicographi-sine-finibus"
  git push --set-upstream origin main
  gh repo edit "MDCIII/.github" --enable-projects=false
}

gh_repo_update_MDCIII_dot_github() {
  # echo "TODO..."
  # cd "$ROOTDIR" || true
  # # rsync --dry-run --verbose --human-readable --checksum --recursive 999999999/42302/MDCIII/.github/ 999999/3133368/.github
  # rsync --verbose --human-readable --checksum --recursive 999999999/42302/MDCIII/.github/ 999999/3133368/.github
  # git -C 999999999/42302/MDCIII/.github/ status

  # # sudo chown 1603:1603 -R /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999999/42302/MDCIII/.github
  # cd /tmp || true
  # git -C /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999999/42302/MDCIII/.github status

  # (...)
  cd /tmp || true
  git clone git@github.com:MDCIII/.github.git
  cd /tmp/.github
  rsync --dry-run --verbose --human-readable --checksum --recursive /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999999/42302/MDCIII/.github/ /tmp/.github
  rsync --verbose --human-readable --checksum --recursive /workspace/git/EticaAI/MDCIII-boostrapper/officina/999999999/42302/MDCIII/.github/ /tmp/.github
}
