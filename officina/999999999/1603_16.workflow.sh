#!/bin/bash
#===============================================================================
#
#          FILE:  1603_16.sh
#
#         USAGE:  ./999999999/1603_16.sh
#                 time ./999999999/1603_16.sh
#
#   DESCRIPTION:  This file is the version of 1603_16.sh designed to run
#                 via GitHub actions.
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
#       CREATED:  2022-06-18 20:08 UTC started. based on 1603_16.sh
#      REVISION:  ---
#===============================================================================
set -e

#### Know issues + workarounds, START ##########################################
# > COMMENT: these "issues" are not really problematic, but likely be in place
#            to mitigate acidental self-DDoS as we manipulate too many
#            repositories at same time.
# > curl --silent -I https://api.github.com/users/eticaaibot | grep x-ratelimit
# > https://docs.github.com/en
#   /rest/overview/resources-in-the-rest-api#checking-your-rate-limit-status
#
#
# 1. Even simple "git clone" (no github-cli) fails around 64 serial operations
#   in 50s.
#   - Issue not triggered if restricting 1603_16 to CPLP administrative regions
#     - (e.g. less than 10 safe to run full speed)
#   - All admin regions (> 140) around country 64 it will fail
#     - 64 git clone in 50s = error
#     - 64 git clone in 1min50s = error (delay 1s not sufficient ONLY if
#       on GitHub runner, but okay of remote host. Strange)
#
#   - Workaround used:
#     - ONLY if 1603_16 runs all regions, adding intentional artificial delay:
#       - 1 second delay at "git clone" operation (if not inside GitHub runner)
#       - No delay at "git push" operations
#         - git push only happens git status have changes. As we already have
#           cached version with git clone we know this upfront
#         - even if have changes for every repository, the previus steps to
#           generate the files requires time beyond 1s (even on fast machines)
#
#### Know issues + workarounds, END ############################################

ROOTDIR="$(pwd)"
# DESTDIR is used to inform shell libs from main repository we're in another dir
DESTDIR="$ROOTDIR"
NUMERORDINATIO_BASIM="$ROOTDIR"

# shellcheck source=1603_16.lib.sh
. "$ROOTDIR"/999999999/1603_16.lib.sh

#### The Happy Path ____________________________________________________________
### 0. Inform machine commiter user for the GitHub runner
# This is not necessary locally, but every time runs on a CI enviroment, it
# will ask again.
git config --global user.email "etica.of.a.ai@gmail.com"
git config --global user.name "EticaAI Bot"

### 1. Initialize bare minimum
# Already done with 0_3.sh (also called by 0_2.sh)

### 2. Download main repository   ----------------------------------------------
## 2.1 The repository itself
# Download (if necessary) https://github.com/EticaAI/lexicographi-sine-finibus
# to local dir
gh_repo_fetch_lexicographi_sine_finibus

## 2.2 Fetch new external data, if relevant
gh_repo_init_lexicographi_sine_finibus_1603_16_NNN
gh_repo_update_lexicographi_sine_finibus_1603_16_NNN
