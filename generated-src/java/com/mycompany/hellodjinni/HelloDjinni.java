// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from hellodjinni.djinni

package com.mycompany.hellodjinni;

import java.util.concurrent.atomic.AtomicBoolean;

public abstract class HelloDjinni {
    public abstract String getHelloDjinni();

    public abstract int getOne();

    public abstract int addition(int v1, int v2);

    public static native HelloDjinni create();

    private static final class CppProxy extends HelloDjinni
    {
        private final long nativeRef;
        private final AtomicBoolean destroyed = new AtomicBoolean(false);

        private CppProxy(long nativeRef)
        {
            if (nativeRef == 0) throw new RuntimeException("nativeRef is zero");
            this.nativeRef = nativeRef;
        }

        private native void nativeDestroy(long nativeRef);
        public void destroy()
        {
            boolean destroyed = this.destroyed.getAndSet(true);
            if (!destroyed) nativeDestroy(this.nativeRef);
        }
        protected void finalize() throws java.lang.Throwable
        {
            destroy();
            super.finalize();
        }

        @Override
        public String getHelloDjinni()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getHelloDjinni(this.nativeRef);
        }
        private native String native_getHelloDjinni(long _nativeRef);

        @Override
        public int getOne()
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_getOne(this.nativeRef);
        }
        private native int native_getOne(long _nativeRef);

        @Override
        public int addition(int v1, int v2)
        {
            assert !this.destroyed.get() : "trying to use a destroyed object";
            return native_addition(this.nativeRef, v1, v2);
        }
        private native int native_addition(long _nativeRef, int v1, int v2);
    }
}
