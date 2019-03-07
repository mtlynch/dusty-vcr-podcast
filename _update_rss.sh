#!/bin/bash

# Exit on first failing command.
set -e
# Echo commands to console.
set -x
# Exit on unset variable.
set -u

curl -s https://dustyvcr.libsyn.com/rss | \
  sed \
    --expression='s@https://dustyvcr.libsyn.com/rss@https://dustyvcr.com/rss@g' \
    > rss
