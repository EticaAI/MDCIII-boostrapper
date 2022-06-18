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

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/0_3.sh"
bash "${ROOTDIR}/999999999/0_3.sh"

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/999999_1603_16.sh"
bash "${ROOTDIR}/999999999/999999_1603_16.sh"

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/1603_16.sh"
bash "${ROOTDIR}/999999999/1603_16.sh"

#### Temp ______________________________________________________________________
# ./999999999/0/1603_1.py --methodus='status-quo' --status-quo-in-json --codex-de 1603_16_24_0
# CODEX_AD_HOC_NUMERORDINATIO='{"#item+rem+i_qcc+is_zxxx+ix_n1603": "1603_16_24_0", "#item+rem+i_mul+is_zyyy": "1603_16_24_0 Angola 0"}'  ./999999999/0/1603_1.py --methodus='status-quo' --status-quo-in-datapackage --ex-librario='locale' --codex-de 1603_16_24_0

# CODEX_AD_HOC_NUMERORDINATIO='{"#item+rem+i_qcc+is_zxxx+ix_n1603": "1603_16_24_0", "#item+rem+i_mul+is_zyyy": "1603_16_24_0 Angola 0"}'  ./999999999/0/1603_1.py --methodus='status-quo' --status-quo-in-datapackage  --codex-de 1603_16_24_0

# --codex-in-tabulam-json

## @TODO the one with general statuses
# ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_45_1,1603_45_31' --data-apothecae-ad='apothecae.datapackage.json'

# ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_45_1,1603_45_31' --data-apothecae-ad='999999/0/apothecae.datapackage.json'

# ./999999999/0/1603_1.py --methodus='data-apothecae' --data-apothecae-ex='1603_16_24_0,1603_16_24_1,1603_16_24_2,1603_16_24_3' --data-apothecae-ad='999999/0/apothecae.datapackage.json'
