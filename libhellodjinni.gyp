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