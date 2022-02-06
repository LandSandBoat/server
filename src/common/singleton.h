#pragma once

#include <iostream>
#include <memory>

template <class T>
class Singleton
{
public:
    Singleton& operator=(const Singleton&) = delete;
    Singleton& operator=(Singleton&&)      = delete;

    [[nodiscard]] static T& GetInstance()
    {
        if(!instance)
        {
            instance = new T_Instance();
        }
        return *instance;
    }

protected:
    Singleton() {}

private:
    struct T_Instance : public T
    {
        T_Instance() : T() {}
    };

    static inline T* instance = nullptr;
};
