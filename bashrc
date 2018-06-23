#!/usr/bin/env bash

#
# detect repository path
#
BASHRC_REPO_PATH=$(readlink ${BASH_SOURCE})
BASHRC_REPO_PATH=${BASHRC_REPO_PATH:-${BASH_SOURCE}}
BASHRC_REPO_PATH=$(dirname ${BASHRC_REPO_PATH})

pushd ${BASHRC_REPO_PATH} > /dev/null
BASHRC_REPO_PATH=${PWD}
popd > /dev/null

BASHRC_LOCAL_PATH=${HOME}/.config/bashrc

#
# detect environment
#
if [ "$(uname)" == "Darwin" ]
then BASHRC_IS_OSX=true
else BASHRC_IS_OSX=false
fi

if [ -n "${SSH_TTYL:-}" ]
then BASHRC_IS_SSH=true
else BASHRC_IS_SSH=false
fi

#
# utility methods
#
bashrc.source ()
{ # $1=relative_path
  if [ -f "${BASHRC_REPO_PATH}/${1}" ]; then
    source "${BASHRC_REPO_PATH}/${1}"
  fi

  if [ -f "${BASHRC_LOCAL_PATH}/${1}" ]; then
    source "${BASHRC_LOCAL_PATH}/${1}"
  fi
}

#
# load
#
bashrc.source etc/init
bashrc.source etc/config
bashrc.source etc/prompt
