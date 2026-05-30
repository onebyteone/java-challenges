#!/usr/bin/env bash

set -e

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TEST_CLASS=${1:-}

if [[ -z "$TEST_CLASS" ]]; then
  echo "Usage: $0 <TestClassName>"
  exit 1
fi

if [[ "$TEST_CLASS" == *.java ]]; then
  TEST_CLASS=${TEST_CLASS%.java}
fi

if [[ "$TEST_CLASS" != *.* ]]; then
  TEST_CLASS="com.example.${TEST_CLASS}"
fi

TEST_SOURCE="$ROOT_DIR/src/test/java/$(echo "$TEST_CLASS" | tr '.' '/')".java

if [[ ! -f "$TEST_SOURCE" ]]; then
  echo "Test source not found: $TEST_SOURCE"
  exit 1
fi

PROGRAM_CLASS=$(grep -E '^import com\.example\.programs\.[A-Za-z0-9_]+;' "$TEST_SOURCE" | head -n 1 | sed -E 's/^import (com\.example\.programs\.[A-Za-z0-9_]+);/\1/')

if [[ -z "$PROGRAM_CLASS" ]]; then
  echo "Could not infer program class from: $TEST_SOURCE"
  exit 1
fi

PROGRAM_SOURCE="$ROOT_DIR/src/main/java/$(echo "$PROGRAM_CLASS" | tr '.' '/')".java

if [[ ! -f "$PROGRAM_SOURCE" ]]; then
  echo "Program source not found: $PROGRAM_SOURCE"
  exit 1
fi

rm -rf "$ROOT_DIR/build/*"
mkdir -p "$ROOT_DIR/build"

javac -d "$ROOT_DIR/build" -sourcepath "$ROOT_DIR/src/main/java:$ROOT_DIR/src/test/java" "$PROGRAM_SOURCE" "$TEST_SOURCE"
java -cp "$ROOT_DIR/build" "$TEST_CLASS"
