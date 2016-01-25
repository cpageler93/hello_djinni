#pragma once

#include "hello_djinni.hpp"

namespace hellodjinni {

    class HelloDjinniImpl : public HelloDjinni {
    public:
        // Constructor
        HelloDjinniImpl();

        // Our method that returns a string
        std::string get_hello_djinni();
        int32_t get_one();
        int32_t addition(int32_t v1, int32_t v2);
    };
}
