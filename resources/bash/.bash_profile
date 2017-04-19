#!/bin/bash
#
# This file is sourced by bash when an interactive login shell is started, but not
# when an interactive non-login shell is started (e.g., opening a new terminal
# window).

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. "${DIR}/.allbashrc"

# Here, put stuff that you _only_ want to be run at login.

# Lastly, load the local variant
LOCAL_PROFILE="${DIR}/.local.bash_profile"
if [ -f "${LOCAL_PROFILE}" ]
then
    . "${LOCAL_PROFILE}"
fi


