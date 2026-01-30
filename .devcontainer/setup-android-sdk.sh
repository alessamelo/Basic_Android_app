#!/usr/bin/env bash
set -e

# Evitar fallo de apt por repo de Yarn con firma expirada (no se usa para Android)
sudo rm -f /etc/apt/sources.list.d/yarn.list || true

sudo apt-get update
sudo apt-get install -y wget unzip

ANDROID_SDK_ROOT=/opt/android-sdk
mkdir -p $ANDROID_SDK_ROOT/cmdline-tools
sudo chown -R $(whoami):$(whoami) $ANDROID_SDK_ROOT

cd /tmp
wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdtools.zip
unzip -q cmdtools.zip

mkdir -p $ANDROID_SDK_ROOT/cmdline-tools/latest
mv cmdline-tools/* $ANDROID_SDK_ROOT/cmdline-tools/latest/

export ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT
export PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH

# Persistir variables sin duplicar líneas
grep -q "ANDROID_SDK_ROOT=/opt/android-sdk" ~/.bashrc || echo "export ANDROID_SDK_ROOT=/opt/android-sdk" >> ~/.bashrc
grep -q "cmdline-tools/latest/bin" ~/.bashrc || echo "export PATH=\$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:\$ANDROID_SDK_ROOT/platform-tools:\$PATH" >> ~/.bashrc

yes | sdkmanager --licenses

# Ajusta según tu compileSdk (ejemplo: 34)
sdkmanager   "platform-tools"   "platforms;android-34"   "build-tools;34.0.0"
