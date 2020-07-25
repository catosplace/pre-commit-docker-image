#!/bin/bash

set -e

for file in "$@"; do
  dojo -i false "hadolint --ignore DL3018 ${file}"
done