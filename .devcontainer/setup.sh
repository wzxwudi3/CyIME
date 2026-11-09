#!/usr/bin/env bash
set -euo pipefail

SDK="${ANDROID_SDK_ROOT:-$PWD/.android-sdk}"
mkdir -p "$SDK/cmdline-tools"

if [ ! -x "$SDK/cmdline-tools/latest/bin/sdkmanager" ]; then
  echo "== 下载 cmdline-tools =="
  curl -sSL -o /tmp/cmdline-tools.zip \
    https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
  rm -rf /tmp/cmdline-tools && mkdir -p /tmp/cmdline-tools
  unzip -q /tmp/cmdline-tools.zip -d /tmp/cmdline-tools
  mv /tmp/cmdline-tools/cmdline-tools "$SDK/cmdline-tools/latest"
fi

export PATH="$SDK/cmdline-tools/latest/bin:$SDK/platform-tools:$PATH"

echo "== 接受许可并安装 SDK / NDK =="
yes | sdkmanager --licenses > /dev/null || true
sdkmanager --install \
  "platform-tools" \
  "platforms;android-36" \
  "build-tools;36.0.0" \
  "ndk;29.0.14206865" \
  "cmake;3.22.1"

echo "== 系统依赖 =="
sudo apt-get update -qq
sudo apt-get install -y -qq ninja-build > /dev/null

printf 'sdk.dir=%s\n' "$SDK" > local.properties
chmod +x gradlew
echo "== 环境就绪：$SDK =="
