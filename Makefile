./build_ios/libhellodjinni.xcodeproj: libhellodjinni.gyp ./deps/djinni/support-lib/support_lib.gyp hellodjinni.djinni
	sh ./run_djinni.sh
	deps/gyp/gyp --depth=. -f xcode -DOS=ios --generator-output ./build_ios -Ideps/djinni/common.gypi ./libhellodjinni.gyp

ios: ./build_ios/libhellodjinni.xcodeproj
	xcodebuild -workspace ios_project/HelloDjinni.xcworkspace \
	-scheme HelloDjinni \
	-configuration 'Debug' \
	-sdk iphoneos