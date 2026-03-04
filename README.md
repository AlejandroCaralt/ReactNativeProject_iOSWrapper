// Installs react native vanilla

npx @react-native-community/cli@latest init RNSDK --version 0.81.5

// generates the main.jsbundle for the sdkwrapper

npx react-native bundle \
  --entry-file index.js \
  --platform ios \
  --dev false \
  --bundle-output ../RNSDKWrapper/RNSDKWrapper/main.jsbundle \
  --assets-dest ../RNSDKWrapper/

// archive wrapper for iPhone

xcodebuild archive -workspace RNSDKWrapper.xcworkspace -scheme RNSDKWrapper -configuration Release -destination 'generic/platform=iOS' -archivePath './build/ios.xcarchive' SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

//archive wrapper for simulator

xcodebuild archive -workspace RNSDKWrapper.xcworkspace -scheme RNSDKWrapper -configuration Release -destination 'generic/platform=iOS Simulator' -archivePath './build/sim.xcarchive' SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

// deletes old and creates a new xcframework

rm -rf ./RNSDKPackage/RNSDKWrapper.xcframework
xcodebuild -create-xcframework -framework './build/ios.xcarchive/Products/Library/Frameworks/RNSDKWrapper.framework' -framework './build/sim.xcarchive/Products/Library/Frameworks/RNSDKWrapper.framework' -output  './RNSDKPackage/RNSDKWrapper.xcframework'
