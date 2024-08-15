#!/bin/bash
set -e -u

CMD_PATH=$(realpath "$(dirname "$0")")
BASE_DIR=${CMD_PATH%/*}
MOCK_GENERATOR="$(find ${BASE_DIR}/build/ -name "mock_generator.py" | head -n 1)"

if [ ! -f "$MOCK_GENERATOR" ]; then
    echo "mock_generator is not installed"
    exit 1
fi

$MOCK_GENERATOR "$@"
