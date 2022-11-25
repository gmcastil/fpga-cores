#!/bin/bash

function err () {
  "${PRINTF}" "[%s] Error: %s\n" "$("${DATE}" +%H:%M:%S\ %m-%d-%Y)" "${1}" >&2
  exit 1
}

function msg () {
  "${PRINTF}" "[%s] %s\n" "$("${DATE}" +%H:%M:%S\ %m-%d-%Y)" "${1}" >&1
  return 0
}

function _find_tool_path () {
  local toolname
  local toolpath
  toolname="${1}"
  toolpath="$(command -v "${toolname}")"
  if [[ -x "${toolpath}" ]]; then
    toolpath="${toolpath}"
  elif [[ -x "/bin/${toolname}" ]]; then
    toolpath="/bin/${toolname}"
  elif [[ -x "/usr/bin/${toolname}" ]]; then
    toolpath="/usr/bin/${toolname}"
  elif [[ -x "/sbin/${toolname}" ]]; then
    toolpath="/sbin/${toolname}"
  elif [[ -x "/usr/sbin/${toolname}" ]]; then
    toolpath="/usr/sbin/${toolname}"
  else
    toolpath=""
  fi
  if [[ ! "${toolpath}" ]]; then
    builtin printf "Could not find an executable for ${toolname}\n" >&2
    return 1
  else
    builtin printf "${toolpath}\n" >&1
    return 0
  fi
}

# Try to confirm tool locations and executability before proceeding - the
# fractured nature of the embedded Linux / Mac OS / desktop Linux / BSD world
# yields all sorts of scenarios where this doesn't work
function confirm_tools () {

  # If none of these exit out, we should be safe to export them to the calling
  # environment afterwards
  set -o errexit
  DATE="$(_find_tool_path date)"
  LN="$(_find_tool_path ln)"
  SED="$(_find_tool_path sed)"
  PRINTF="$(_find_tool_path printf)"
  MKDIR="$(_find_tool_path mkdir)"
  RM="$(_find_tool_path rm)"
  UNAME="$(_find_tool_path uname)"
  set +o errexit

  # Wait to export these once we've verified everything is here so we don't
  # pollute the calling environment
  export DATE
  export LN
  export SED
  export PRINTF
  export MKDIR
  export UNAME
  export RM

  return 0
}

confirm_tools

