#!/bin/bash
set -e

rm -f /t-cnica/tmp/pids/server.pid

exec "$@"