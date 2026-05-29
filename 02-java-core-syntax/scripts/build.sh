#!/usr/bin/env bash

set -e

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)

mkdir -p "$ROOT_DIR/build"

javac -d "$ROOT_DIR/build" $(find "$ROOT_DIR/src/main/java" -name "*.java")
