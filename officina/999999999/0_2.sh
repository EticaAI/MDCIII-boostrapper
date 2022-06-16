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

printf '\n\t\e[1;32m%-6s\e[m\n' "999999999/0_3.sh"
bash "${ROOTDIR}/999999999/0_3.sh"
