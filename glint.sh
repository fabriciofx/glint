#!/bin/sh
#
# glint
#
# The MIT License (MIT)
#
# Copyright (c) 2019 Fabricio Barros Cabral
#
# Permission is hereby granted, free of #charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

set -e

DIR="$(git rev-parse --show-toplevel)"
HOOKS_DIR="$DIR/.git/hooks"
CONFIG_FILE="$DIR/.glint"

load_settings() {
  if test -f "$CONFIG_FILE"
  then
    source "$CONFIG_FILE"
  else
    echo "glint configuration file not found!"
    echo "Please, check it out exists a $CONFIG_FILE configuration file."
    exit 1
  fi
}

install() {
  echo -n "Installing $0 as commit-msg hook...  "
  cp glint.sh $HOOKS_DIR/commit-msg
  chmod +x $HOOKS_DIR/commit-msg
  echo "done."
}

config() {
  cat "$CONFIG_FILE"
}

lint() {
  if test -f "$1"
  then
    grep -v '^#' "$1" |
    while read msg
    do
      failed=$(echo "$msg" | grep -vEc "$COMMIT_MSG_REGEX")
      if test "$failed" -gt 0
      then
        echo
        echo -n "glint: commit message '$msg' violates the "
        echo "pattern '$COMMIT_MSG_REGEX'"
        exit 1
      fi
    done
  else
    while read log
    do
      id=$(echo "$log" | cut -d" " -f1)
      msg=$(echo "$log" | cut -d" " -f2-)
      failed=$(echo "$msg" | grep -vEc "$COMMIT_MSG_REGEX")
      if test "$failed" -gt 0
      then
        echo
        echo -n "glint: commit message '$msg' violates the "
        echo "pattern '$COMMIT_MSG_REGEX'"
        exit 1
      fi
    done
  fi
}

usage() {
  echo
  echo "Usage: glint.sh <subcommand>"
  echo
  echo "Available subcommands are:"
  echo "   install      Install glint in commit-msg hook"
  echo "   config       Show the content of configuration file"
  echo "   help         Show this help"
  echo
}

case "$1" in
  install)
    install
    ;;
  config)
    config
    ;;
  help | --help | -h)
    usage
    ;;
  *)
    load_settings
    lint "$1"
  ;;
esac
