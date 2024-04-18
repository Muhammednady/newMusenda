#!/usr/bin/env bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test --coverage
flutter format --set-exit-if-changed .
flutter analyze
flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/app/outputs/symbols --no-tree-shake-icons
flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/app/outputs/symbols --no-tree-shake-icons --target-platform android-arm64
flutter pub add flutter_lints --dev
flutter pub deps -- --style=compact


shorebird release android

# Optimize
# https://flutter.dev/docs/deployment/android#enabling-proguard
# https://flutter.dev/docs/deployment/android#enabling-r8
# https://flutter.dev/docs/deployment/android#enabling-obfuscation-and-minification
# https://flutter.dev/docs/deployment/android#enabling-split-debug-info
# https://flutter.dev/docs/deployment/android#enabling-tree-shake-icons