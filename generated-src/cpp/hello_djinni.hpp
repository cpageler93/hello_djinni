// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from hellodjinni.djinni

#pragma once

#include <memory>
#include <string>

namespace hellodjinni {

class HelloDjinni {
public:
    virtual ~HelloDjinni() {}

    static std::shared_ptr<HelloDjinni> create();

    virtual std::string get_hello_djinni() = 0;
};

}  // namespace hellodjinni