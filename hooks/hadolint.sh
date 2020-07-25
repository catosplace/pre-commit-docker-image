#!/bin/bash

set -e

for file in "$@"; do
  dojo "hadolint --ignore DL3018 ${file}"
done