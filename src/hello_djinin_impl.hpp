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