#!/bin/bash -eu
# Include pretty printing for logs
# This library provides error, log, and success functions
. $(cd $(dirname "$0"); pwd)/lib-logging.sh

trap "error 'Failed to start webDiplomacy Development Server'" 0

log "Starting services"
service apache2 start
service mysql start

log "Confirming source is mounted"

if [ ! -f /var/www/example.com/public_html/index.php ]; then
  error "index.php is missing - perhaps you didn't mount the webDiplomacy files?"
  exit
fi

if [ ! -f /var/www/example.com/public_html/config.php ]; then
  error "config.php is missing - make sure you copy it from the root of this repository"
  exit
fi

trap - 0

success_banner "webDiplomacy is ready for development"

tail -f /dev/null
