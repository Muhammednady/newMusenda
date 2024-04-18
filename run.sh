date

flutter clean
rm -rf pubspec.lock
rm -rf ios/Podfile.lock
rm -rf ios/Pods
rm -rf ios/.symlinks
rm -rf ios/build
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec
pod cache clean --all
flutter pub get
flutter pub upgrade

cd ios/ || exit
pod install
pod update
pod repo update
pod deintegrate
pod install
cd ../

cd android/ || exit
./gradlew clean
./gradlew build
cd ../

flutter packages pub run build_runner build
date

