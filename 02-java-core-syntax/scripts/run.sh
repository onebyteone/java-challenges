#!/usr/bin/env bash

set -e

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)

java -cp "$ROOT_DIR/build" com.example.Main
