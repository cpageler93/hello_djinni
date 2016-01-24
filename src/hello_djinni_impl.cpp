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