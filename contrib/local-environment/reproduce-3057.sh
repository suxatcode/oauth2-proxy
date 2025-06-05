#!/usr/bin/env bash
# Helper script to start the Keycloak environment with Redis to reproduce issue #3057
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v docker > /dev/null; then
  echo "docker is required" >&2
  exit 1
fi

COMPOSE_FILE="docker-compose-keycloak-redis.yaml"

# bring up or down the environment based on first argument
cmd=${1:-up}

docker compose -f "$COMPOSE_FILE" $cmd

if [ "$cmd" = "up" ]; then
  echo "\nEnvironment started."
  echo "1. Visit http://oauth2-proxy.localtest.me:4180 and log in with admin@example.com / password." 
  echo "2. Open Keycloak admin at http://keycloak.localtest.me:9080/ and remove the active session." 
  echo "3. Wait about 30 seconds (cookie_refresh). Send another request to http://oauth2-proxy.localtest.me:4180/." 
  echo "If the session remains active despite the refresh failure, the bug is reproduced." 
fi
