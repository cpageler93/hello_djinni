# hello_djinni

## Notes

- Example based on [this tutorial](http://mobilecpptutorials.com/cross-platform-cplusplus-dev-setup-on-os-x-yosemite/) with some fixes
- Consider "Setup" steps from liked Tutorial (which are not handled in this example)
- all elements that are specific for this tutorial <span style="color: red">are marked</span> so you can adjust these for your own needs

## Steps

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


### 2. create djinni file

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

### 3. create djinni shell script

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

### your project dir

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

### 4. write c++ implementation

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


**New File: src/hello_djinin_impl.hpp**

```
#pragma once

#include "hello_djinni.hpp"

namespace hellodjinni {

    class HelloDjinniImpl : public HelloDJinni {
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

### 6. 