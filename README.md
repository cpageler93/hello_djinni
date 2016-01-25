# hello_djinni

## Notes

- Example based on [this tutorial](http://mobilecpptutorials.com/cross-platform-cplusplus-dev-setup-on-os-x-yosemite/) with some fixes
- Consider "Setup" steps from liked Tutorial (which are not handled in this example)
- all elements that are specific for this tutorial <span style="color: red">are marked</span> so you can adjust these for your own needs

## Steps
1. (init git) and add dependencies
2. Create djinni file
3. Create djinni shell script
4. Write c++ implementation
5. Build and Test the C++ Code
6. Generate iOS Libraries (GYP)
7. Create iOS Project
8. Create Makefile
9. Add the Libraries to the build
10. Call the C++ Library from Obj-C \o/
11. Create Android Project
12. Update Makefile
13. Build the App

### 1. (init git) and add dependencies

init git and add djinni and gyp

```
git init
git submodule add https://github.com/dropbox/djinni.git deps/djinni
git submodule add https://chromium.googlesource.com/external/gyp.git deps/gyp
```

checkout specific gyp commit

```
cd deps/gyp
git checkout -q 0bb67471bca068996e15b56738fa4824dfa19de0
```


### 2. Create djinni file

in your project directory

**Specific for this Tutorial:**


- <span style="color: red">Filename: hellodjinni.djinni</span>
- <span style="color: red">Interface Name: hello_djinni</span>
- <span style="color: red">Method Name: get_hello_djinni()</span>



**New File: hellodjinni.djinni**

```
hello_djinni = interface +c {
    static create(): hello_djinni;
    get_hello_djinni(): string;
}
```

### 3. Create djinni shell script

this script will be used to create all generated code

**Specific for this Tutorial:**

- <span style="color: red">java_out</span>
- <span style="color: red">java_package</span>
- <span style="color: red">namespace</span>
- <span style="color: red">objc_prefix</span>
- <span style="color: red">djinni_file (Filename from step 3)</span>


**New File: run_djinni.sh**

```
#! /usr/bin/env bash

base_dir=$(cd $(dirname 0) && pwd)
cpp_out="$base_dir/generated-src/cpp"
jni_out="$base_dir/generated-src/jni"
objc_out="$base_dir/generated-src/objc"
java_out="$base_dir/generated-src/java/com/mycompany/hellodjinni"
java_package="com.mycompany.hellodjinni"
namespace="hellodjinni"
objc_prefix="HD"
djinni_file="hellodjinni.djinni"

deps/djinni/src/run \
   --java-out $java_out \
   --java-package $java_package \
   --ident-java-field mFooBar \
   \
   --cpp-out $cpp_out \
   --cpp-namespace $namespace \
   \
   --jni-out $jni_out \
   --ident-jni-class NativeFooBar \
   --ident-jni-file NativeFooBar \
   \
   --objc-out $objc_out \
   --objc-type-prefix $objc_prefix \
   \
   --objcpp-out $objc_out \
   \
   --idl $djinni_file
```


**Make run_djinni.sh executable**

```
chmod 755 run_djinni.sh
```

**Run Djninni \o/**

> The first time you run the script it may take a few minutes for Djinni to download dependencies and run it’s Scala build.

```
./run_djinni.sh
```

*output first run:*

```
Building Djinni...
Getting org.scala-sbt sbt 0.13.5 ...
downloading https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt/0.13.5/jars/sbt.jar ...
  [SUCCESSFUL ] org.scala-sbt#sbt;0.13.5!sbt.jar (2042ms)
downloading https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.10.4/scala-library-2.10.4.jar ...

[...]

[success] Total time: 0 s, completed 24.01.2016 12:58:53
Parsing...
Resolving...
Generating...
```

*output after first run:*

```
Already up to date: Djinni
Parsing...
Resolving...
Generating...
```

### Your project dir

should now look similar to this:

```
> ll
-rw-r--r--  1 christoph  staff   1,1K 24 Jan 12:22 LICENSE
-rw-r--r--@ 1 christoph  staff   3,2K 24 Jan 13:00 README.md
drwxr-xr-x  4 christoph  staff   136B 24 Jan 12:31 deps
drwxr-xr-x  6 christoph  staff   204B 24 Jan 12:58 generated-src
-rw-r--r--  1 christoph  staff    98B 24 Jan 12:43 hellodjinni.djinni
-rwxr-xr-x  1 christoph  staff   757B 24 Jan 12:47 run_djinni.sh
```

### 4. Write c++ implementation

create src folder

```
mkdir src
```

**Specific for this Tutorial:**

- <span style="color: red">Filenames: hello_djinin_impl.hpp, hello_djinin_impl.cpp</span>
- <span style="color: red">include</span>
- <span style="color: red">namespace</span>
- <span style="color: red">class names</span>
- <span style="color: red">method names</span>


**New File: src/hello_djinni_impl.hpp**

```
#pragma once

#include "hello_djinni.hpp"

namespace hellodjinni {

    class HelloDjinniImpl : public HelloDjinni {
    public:
        // Constructor
        HelloDjinniImpl();

        // Our method that returns a string
        std::string get_hello_djinni();
    };
}
```

**New File src/hello_djinni_impl.cpp**

```
#include "hello_djinni_impl.hpp"
#include <chrono>
#include <ctime>
#include <string>

namespace hellodjinni {

    std::shared_ptr<HelloDjinni> HelloDjinni::create() {
        return std::make_shared<HelloDjinniImpl>();
    }

    HelloDjinniImpl::HelloDjinniImpl() {

    }

    std::string HelloDjinniImpl::get_hello_djinni() {

        // get the current date/time using std::chrono
        std::chrono::time_point<std::chrono::system_clock> now;
        now = std::chrono::system_clock::now();
        time_t time = std::chrono::system_clock::to_time_t(now);

        // generate our string
        std::string myString = "Hello Djinni! ";
        myString += std::ctime(&time);

        return myString;

    }

}
```

### 5. Build and Test the C++ Code

we're so brave, skip this step 💪🏼

### 6. Generate iOS Libraries (GYP)

Create GYP File

**Specific for this Tutorial:**

- <span style="color: red">Filename: libhellodjinni.gyp</span>
- <span style="color: red">Target names</span>

**New File libhellodjinni.gyp**

```
{
    "targets": [
        {
            "target_name": "libhellodjinni_jni",
            "type": "shared_library",
            "dependencies": [
              "./deps/djinni/support-lib/support_lib.gyp:djinni_jni",
            ],
            "ldflags": [ "-llog", "-Wl,--build-id,--gc-sections,--exclude-libs,ALL" ],
            "sources": [
              "./deps/djinni/support-lib/jni/djinni_main.cpp",
              "<!@(python deps/djinni/example/glob.py generated-src/jni   '*.cpp')",
              "<!@(python deps/djinni/example/glob.py generated-src/cpp   '*.cpp')",
              "<!@(python deps/djinni/example/glob.py src '*.cpp')",
            ],
            "include_dirs": [
              "generated-src/jni",
              "generated-src/cpp",
              "src",
            ],
        },
        {
            "target_name": "libhellodjinni_objc",
            "type": 'static_library',
            "dependencies": [
              "./deps/djinni/support-lib/support_lib.gyp:djinni_objc",
            ],
            'direct_dependent_settings': {

            },
            "sources": [
              "<!@(python deps/djinni/example/glob.py generated-src/objc  '*.cpp' '*.mm' '*.m')",
              "<!@(python deps/djinni/example/glob.py generated-src/cpp   '*.cpp')",
              "<!@(python deps/djinni/example/glob.py src '*.cpp')",
            ],
            "include_dirs": [
              "generated-src/objc",
              "generated-src/cpp",
              "src",
            ],
        },
    ],
}
```

### 7. Create iOS Project

Create Folder for iOS Project

```
mkdir ios_project
```

**Create Xcode Workspace**

**Create iOS Project in this Folder**<br>
**and add the Project to the Workspace**

Your iOS project directory should look similar to this:

```
> ll
drwxr-xr-x  6 christoph  staff   204B 24 Jan 13:31 HelloDjinni
drwxr-xr-x  4 christoph  staff   136B 24 Jan 13:48 HelloDjinni.xcworkspace

> pwd
/Users/christoph/dev/private/hello_djinni/ios_project
```

### 8. Create Makefile

**Specific for this Tutorial:**

- <span style="color: red">... every "hellodjinni" in the makefile</span>
- <span style="color: red">Project</span>
- <span style="color: red">Workpace</span>
- <span style="color: red">Scheme</span>

**New File: Makefile**

```
./build_ios/libhellodjinni.xcodeproj: libhellodjinni.gyp ./deps/djinni/support-lib/support_lib.gyp hellodjinni.djinni
  sh ./run_djinni.sh
  deps/gyp/gyp --depth=. -f xcode -DOS=ios --generator-output ./build_ios -Ideps/djinni/common.gypi ./libhellodjinni.gyp

ios: ./build_ios/libhellodjinni.xcodeproj
  xcodebuild -workspace ios_project/HelloDjinni.xcworkspace \
  -scheme HelloDjinni \
  -configuration 'Debug' \
  -sdk iphoneos
```

** JUST DO IT**

```
make ios
```

when everything worked fine, a new folder should be generated "build_ios"

### Your project dir

should now look similar to this:

```
> ll
-rw-r--r--  1 christoph  staff   1,1K 24 Jan 12:22 LICENSE
-rw-r--r--  1 christoph  staff   425B 24 Jan 13:53 Makefile
-rw-r--r--@ 1 christoph  staff   8,9K 24 Jan 13:54 README.md
drwxr-xr-x  5 christoph  staff   170B 24 Jan 13:45 build_ios
drwxr-xr-x  4 christoph  staff   136B 24 Jan 12:31 deps
drwxr-xr-x  6 christoph  staff   204B 24 Jan 12:58 generated-src
-rw-r--r--  1 christoph  staff    98B 24 Jan 12:43 hellodjinni.djinni
drwxr-xr-x  4 christoph  staff   136B 24 Jan 13:48 ios_project
-rw-r--r--  1 christoph  staff   1,5K 24 Jan 13:18 libhellodjinni.gyp
-rwxr-xr-x  1 christoph  staff   757B 24 Jan 12:47 run_djinni.sh
drwxr-xr-x  4 christoph  staff   136B 24 Jan 13:08 src
```

### 9. Add the Libraries to the build

**Specific for this Tutorial:**

- <span style="color: red">lib names</span>

**Steps:**

- Add the two new generated Xcode Projects in the build_ios directory to the workspace
- In the HelloDjinni Project add "libhellodjinni_objc.a" and "libdjinni_objc.a" to "Link Binaries With Libraries"
- Add Header Search Paths

**Header Search Paths**

```
$(SRCROOT)/../../deps/djinni/support-lib/objc
$(SRCROOT)/../../generated-src/objc
```

now you should be able to build the project

### 10. Call the C++ Library from Obj-C \o/

**Specific for this Tutorial:**

- <span style="color: red">Generated ObjC Bridging Classes</span>


Rename HelloDjinni/Supporting Files/main.m to main.mm to be compatible with our Objective-C++ bridge code

**In any of your Obj-C Files:**

```
#import "HDHelloDjinni.h"

[...]

HDHelloDjinni *helloDjinniInterface = [HDHelloDjinni create];
NSString *helloDjinni = [helloDjinniInterface getHelloDjinni];
NSLog(@"%@", helloDjinni);

```

### 11. Create Android Project

 **First follow step 1 - 6**

### 11.a : Create Folder for Android Project

```
mkdir android_project
```

#### 11.b : Create new android project

The new project must be created in folder **android_project**

***Open Wizard and set the following parameter:***

```
Application Name : HelloDjinni
Company: mycompany.com
Project location: ../android_project/HelloDjinni
```

***--> Click next through next configurations and finish the wizard***


Use your preferred text editor to create and add the following files to the project:

***android_project/HelloDjinni/app/jni/Android.mk:***

```
# always force this build to re-run its dependencies
FORCE_GYP := $(shell make -C ../../../GypAndroid.mk)
include ../../../GypAndroid.mk
```

***android_project/HelloDjinni/app/jni/Application.mk:***

```
# Android makefile for hellodjinni shared lib, jni wrapper around libhellodjinni C API

APP_ABI := all
APP_OPTIM := release
APP_PLATFORM := android-8
# GCC 4.9 Toolchain
NDK_TOOLCHAIN_VERSION = 4.9
# GNU libc++ is the only Android STL which supports C++11 features
APP_STL := gnustl_static
APP_BUILD_SCRIPT := jni/Android.mk
APP_MODULES := libhellodjinni_jni
```

#### 11.c : Update _build.gradle_ inside the app folder

Add missing entries to your projects app build.gradle.
```
apply plugin: 'com.android.application'

android {
    compileSdkVersion 23
    buildToolsVersion "23.0.2"

    defaultConfig {
        applicationId "com.mycompany.hellodjinni"
        minSdkVersion 16
        targetSdkVersion 23
        versionCode 1
        versionName "1.0"
    }
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
        }
    }
    sourceSets {
        main {
            java.srcDirs = ['src', '../../../generated-src/java']
            jni.srcDirs = []
            jniLibs.srcDirs = ['libs']
        }
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_7
        targetCompatibility JavaVersion.VERSION_1_7
    }
}

dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    compile 'junit:junit:4.12'
    compile 'com.android.support:appcompat-v7:23.1.1'
    compile 'com.android.support:design:23.1.1'
}

task ndkBuild(type: Exec) {
    String MainDirectory = System.getProperty("user.dir") + '/app/'
    File ndkDir = project.getPlugins().getPlugin('android').sdkHandler.getNdkFolder()
    if (ndkDir == null) {
        def gradle_project_root = project.rootProject.rootDir
        throw new GradleException("NDK is not configured. Make sure there is a local.properties " +
                "file with an ndk.dir entry in the directory ${gradle_project_root}.")
    }
    def ndkBuildExecutable = new File(ndkDir, 'ndk-build')
    if (!ndkBuildExecutable.exists()) {
        throw new GradleException("Could not find ndk-build. The configured NDK directory ${ndkDir} may not be correct.")
    }
    environment("NDK_PROJECT_PATH", MainDirectory)
    environment("GYP_CONFIGURATION", "Release")
    commandLine ndkBuildExecutable
}

tasks.withType(JavaCompile) {
    compileTask -> compileTask.dependsOn ndkBuild
}
```

### 12. Update Makefile

```
# we specify a root target for android to prevent all of the targets from spidering out
GypAndroid.mk: libhellodjinni.gyp ./deps/djinni/support-lib/support_lib.gyp hellodjinni.djinni
  sh ./run_djinni.sh
  ANDROID_BUILD_TOP=$(shell dirname `which ndk-build`) deps/gyp/gyp --depth=. -f android -DOS=android -Ideps/djinni/common.gypi ./libhellodjinni.gyp -$

# this target implicitly depends on GypAndroid.mk since gradle will try to make it
android: GypAndroid.mk
  cd android_project/HelloDjinni/ && ./gradlew app:assembleDebug
  @echo "Apks produced at:"
  @python deps/djinni/example/glob.py ./ '*.apk'
```

** JUST DO IT**

```
make android
```

### 13. Build the App

Add the following lines to your *MainActivity.java*
```
...
public class MainActivity extends AppCompatActivity {

  private HelloDjinni helloDjinniInterface;

  static {
    System.loadLibrary("hellodjinni_jni");
  }

  @Override
  protected void onCreate(Bundle savedInstanceState){
    ...
    helloDjinniInterface = HelloDjinni.create();

    helloDjinniInterface = HelloDjinni.create();

    TextView tv = (TextView) findViewById(R.id.tvHelloDjinni);

    String stringResponse = helloDjinniInterface.getHelloDjinni();
    tv.append("StringResponse: "+stringResponse);

    int getIntResponse = helloDjinniInterface.getOne();
    tv.append("intResponse: "+getIntResponse);
    ...
  }
}
```

Add _android:id="@+id/tvHelloDjinni"_ to *content_main.java*
```
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    xmlns:tools="http://schemas.android.com/tools"
    .....>

        android:id="@+id/tvHelloDjinni"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello World!" />

</RelativeLayout>


### FINISHED

Now your app should run and show the iniital String response 'Hello Djinni' and the init response '1'

## When the interface changes

- update the .djini-File
- implement in C++
- run make
