#!/bin/bash -eu
set -o pipefail
SCRIPT_DIR=$(cd $(dirname "$0"); pwd)
. "$SCRIPT_DIR"/scripts/lib-logging.sh
trap "handle_error" 0

function handle_error () {
   error "$STAGE failed"
   warnings
}

STAGE="Initialising"

if [ -z "$(ls "$SCRIPT_DIR"/webDiplomacy)" ] ; then
  warn "Missing source directory for webDiplomacy; running git submodule commands"
  git submodule init
  git submodule update
fi
 
INSTALLED_CONFIG="$SCRIPT_DIR"/webDiplomacy/config.php
CONFIG="$SCRIPT_DIR"/config.php
if [ -f "$INSTALLED_CONFIG" ] ; then
  if [ "`cat "$CONFIG" | diff - $INSTALLED_CONFIG | cat`" != "" ] ; then
    warn "Config file '$INSTALLED_CONFIG' has changed from the development version"
    warn_info "If this is not expected, you may need to run the following command:"
    warn_info "  cp $CONFIG $INSTALLED_CONFIG"
  fi
else
 log "Installing config.php"
 cp $CONFIG $INSTALLED_CONFIG
fi


STAGE="Build"
log "Building image"
docker build -t webDiplomacyDev $SCRIPT_DIR

log "Starting server"
trap warnings 0
docker run -p 80:80 -t -i -v "$SCRIPT_DIR"/webDiplomacy:/var/www/example.com/public_html webDiplomacyDev
