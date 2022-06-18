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
