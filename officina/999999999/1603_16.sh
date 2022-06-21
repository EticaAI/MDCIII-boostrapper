#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16.sh
#
#         USAGE:  ./999999999/1603_16.sh
#                 time ./999999999/1603_16.sh
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
set -e

ROOTDIR="$(pwd)"
# DESTDIR is used to inform shell libs from main repository we're in another dir
DESTDIR="$ROOTDIR"
NUMERORDINATIO_BASIM="$ROOTDIR"

# shellcheck source=1603_16.lib.sh
. "$ROOTDIR"/999999999/1603_16.lib.sh

# ---------------------------------------------------------------------------- #
## Example of log as local user
#     cd /workspace/git/EticaAI/MDCIII-boostrapper/officina
#     sudo su mdciii
#     source ~/.profile
# Test
#   hxltmcli --help
#   ./999999999/1603_16.sh
#
## Example with GitHub actions
#   @TODO
# ---------------------------------------------------------------------------- #

# 1603_16_24 Angola
# gh_repo_create_numerordinatio "1603_16_24"
# 1603_16_508 Mozambique
# gh_repo_create_numerordinatio "1603_16_508"

# gh_repo_fetch_lexicographi_sine_finibus

# echo "Login shell?"
# shopt login_shell

# bootstrap_1603_45_16__item_rdf "1603_16" "24" "AGO" "AO" "3" "1" "0" "4"
# lsf1603_to_gh_repo_local_file "1603_16_24" "1603/16/24/1/1603_16_24_1.no1.owl.ttl" "${ROOTDIR}"
# exit 0

#### The Happy Path ____________________________________________________________
### 1. Initialize bare minimum
# Already done with 0_3.sh (also called by 0_2.sh)

# AUTOMATON__1603_16__CPLP_UNICAE="1"
AUTOMATON__1603_16__CPLP_UNICAE="0"
UNM49_INITIALI="0"
UNM49_FINALI="300"
# 68 COL
# UNM49_INITIALI="67"
# UNM49_FINALI="70"

### 2. Download main repository   ----------------------------------------------
## 2.1 The repository itself
# Download (if necessary) https://github.com/EticaAI/lexicographi-sine-finibus
# to local dir
gh_repo_fetch_lexicographi_sine_finibus

## 2.2 Fetch new external data, if relevant
gh_repo_init_lexicographi_sine_finibus_1603_16_NNN
gh_repo_update_lexicographi_sine_finibus_1603_16_NNN
