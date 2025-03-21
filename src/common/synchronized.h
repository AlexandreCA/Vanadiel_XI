#pragma once

#include <mutex>
#include <shared_mutex>

#include "cbasetypes.h"
#include "tracy.h"

// https://www.reddit.com/r/cpp/comments/p132c7/comment/h8b8nml/?share_id=-NRyj9iRw5TqSi4Mm381j
template <
    class T,
    class M                            = std::mutex,
    template <typename...> typename WL = std::unique_lock,
    template <typename...> typename RL = std::unique_lock>
struct Synchronized
{
    Synchronized()  = default;
    ~Synchronized() = default;

    explicit Synchronized(T in)
    : target(std::move(in))
    {
    }

    DISALLOW_COPY_AND_MOVE(Synchronized);

    auto read(auto f) const
    {
        auto l = lock();
        LockMark(mutex);
        return f(target);
    }

    auto write(auto f)
    {
        auto l = lock();
        LockMark(mutex);
        return f(target);
    }

private:
    mutable TracyLockable(M, mutex);

    T target;

    auto lock() const
    {
        return RL<LockableBase(M)>(mutex);
    }

    auto lock()
    {
        return WL<LockableBase(M)>(mutex);
    }
};

template <class T>
using SynchronizedShared = Synchronized<T, std::shared_mutex, std::shared_lock>;
