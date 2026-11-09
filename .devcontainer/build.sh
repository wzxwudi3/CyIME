#!/usr/bin/env bash
set -euo pipefail

./gradlew assembleRelease \
  -x prepareAzooKeyLibraries -x prepareJapaneseDictionaries "$@"

mkdir -p out
cp app/build/outputs/apk/release/*.apk out/CyIME-latest.apk
ls -lh out/CyIME-latest.apk
