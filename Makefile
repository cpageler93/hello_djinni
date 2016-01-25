./build_ios/libhellodjinni.xcodeproj: libhellodjinni.gyp ./deps/djinni/support-lib/support_lib.gyp hellodjinni.djinni
	sh ./run_djinni.sh
	deps/gyp/gyp --depth=. -f xcode -DOS=ios --generator-output ./build_ios -Ideps/djinni/common.gypi ./libhellodjinni.gyp

ios: ./build_ios/libhellodjinni.xcodeproj
	xcodebuild -workspace ios_project/HelloDjinni.xcworkspace \
	-scheme HelloDjinni \
	-configuration 'Debug' \
	-sdk iphoneos

# we specify a root target for android to prevent all of the targets from spidering out
GypAndroid.mk: libhellodjinni.gyp ./deps/djinni/support-lib/support_lib.gyp hellodjinni.djinni
	sh ./run_djinni.sh
	ANDROID_BUILD_TOP=$(shell dirname `which ndk-build`) deps/gyp/gyp --depth=. -f android -DOS=android -Ideps/djinni/common.gypi ./libhellodjinni.gyp --root-target=libhellodjinni_jni

# this target implicitly depends on GypAndroid.mk since gradle will try to make it
android: GypAndroid.mk
	cd android_project/HelloDjinni/ && ./gradlew app:assembleDebug
	@echo "Apks produced at:"
	@python deps/djinni/example/glob.py ./ '*.apk'
