// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from hellodjinni.djinni

#import "HDHelloDjinni+Private.h"
#import "HDHelloDjinni.h"
#import "DJICppWrapperCache+Private.h"
#import "DJIError.h"
#import "DJIMarshal+Private.h"
#import "HDHelloDjinni+Private.h"
#include <exception>
#include <utility>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@interface HDHelloDjinni ()

- (id)initWithCpp:(const std::shared_ptr<::hellodjinni::HelloDjinni>&)cppRef;

@end

@implementation HDHelloDjinni {
    ::djinni::CppProxyCache::Handle<std::shared_ptr<::hellodjinni::HelloDjinni>> _cppRefHandle;
}

- (id)initWithCpp:(const std::shared_ptr<::hellodjinni::HelloDjinni>&)cppRef
{
    if (self = [super init]) {
        _cppRefHandle.assign(cppRef);
    }
    return self;
}

+ (nullable HDHelloDjinni *)create {
    try {
        auto r = ::hellodjinni::HelloDjinni::create();
        return ::djinni_generated::HelloDjinni::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (nonnull NSString *)getHelloDjinni {
    try {
        auto r = _cppRefHandle.get()->get_hello_djinni();
        return ::djinni::String::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (int32_t)getOne {
    try {
        auto r = _cppRefHandle.get()->get_one();
        return ::djinni::I32::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

- (int32_t)addition:(int32_t)v1
                 v2:(int32_t)v2 {
    try {
        auto r = _cppRefHandle.get()->addition(::djinni::I32::toCpp(v1),
                                               ::djinni::I32::toCpp(v2));
        return ::djinni::I32::fromCpp(r);
    } DJINNI_TRANSLATE_EXCEPTIONS()
}

namespace djinni_generated {

auto HelloDjinni::toCpp(ObjcType objc) -> CppType
{
    if (!objc) {
        return nullptr;
    }
    return objc->_cppRefHandle.get();
}

auto HelloDjinni::fromCppOpt(const CppOptType& cpp) -> ObjcType
{
    if (!cpp) {
        return nil;
    }
    return ::djinni::get_cpp_proxy<HDHelloDjinni>(cpp);
}

}  // namespace djinni_generated

@end
