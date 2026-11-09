#!/usr/bin/env bash
set -euo pipefail

chmod +x gradlew

echo "== 预热：下载 ONNX 等原生依赖 =="
./gradlew --no-daemon downloadOnnx \
  -x prepareAzooKeyLibraries -x prepareJapaneseDictionaries || true

echo "== 预热：完整编译一次（缓存 Gradle 与 CMake）=="
./gradlew --no-daemon assembleRelease \
  -x prepareAzooKeyLibraries -x prepareJapaneseDictionaries || \
  echo "预热编译失败（多半是还没配签名，属正常，首次正式构建会重新跑）"

echo "== 预热结束 =="
