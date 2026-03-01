/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include <asio/any_io_executor.hpp>
#include <asio/as_tuple.hpp>
#include <asio/awaitable.hpp>
#include <asio/co_spawn.hpp>
#include <asio/detached.hpp>
#include <asio/executor_work_guard.hpp>
#include <asio/experimental/awaitable_operators.hpp>
#include <asio/io_context.hpp>
#include <asio/post.hpp>
#include <asio/steady_timer.hpp>
#include <asio/this_coro.hpp>
#include <asio/use_awaitable.hpp>

#include <atomic>
#include <chrono>
#include <concepts>
#include <cstdio>
#include <format>
#include <iostream>
#include <iterator>
#include <memory>
#include <mutex>
#include <stdexcept>
#include <string_view>
#include <thread>
#include <tuple>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

#ifdef TRACY_ENABLE
#include <tracy/Tracy.hpp>
#endif

namespace detail
{

template <typename T>
struct IsASIOAwaitable : std::false_type
{
};

template <typename T, typename E>
struct IsASIOAwaitable<asio::awaitable<T, E>> : std::true_type
{
};

template <typename T>
concept IsAwaitable = IsASIOAwaitable<std::decay_t<T>>::value;

template <typename T>
struct AwaitableResult;

template <typename T, typename E>
struct AwaitableResult<asio::awaitable<T, E>>
{
    using type = T;
};

template <typename T>
concept IsInvocable = std::invocable<std::decay_t<T>>;

template <typename T>
concept IsInvocableReturnsVoid = IsInvocable<T> && std::is_void_v<std::invoke_result_t<std::decay_t<T>>>;

template <typename T>
concept IsAwaitableReturnsVoid = IsAwaitable<T> && std::is_void_v<typename AwaitableResult<std::decay_t<T>>::type>;

} // namespace detail

template <typename T>
using Task = asio::awaitable<T, asio::any_io_executor>;

//
// Combinators
//

//
// All
//   Await multiple tasks in parallel and return their results as a tuple.
//
template <typename... Tasks>
    requires(sizeof...(Tasks) > 0)
auto All(Tasks&&... tasks)
{
    using namespace asio::experimental::awaitable_operators;
    return (std::forward<Tasks>(tasks) && ...);
}

//
// One
//   Race multiple tasks and return a variant of the winner.
//
template <typename... Tasks>
    requires(sizeof...(Tasks) > 0)
auto One(Tasks&&... tasks)
{
    using namespace asio::experimental::awaitable_operators;
    return (std::forward<Tasks>(tasks) || ...);
}

//
// Scheduler
//
class Scheduler final
{
public:
    Scheduler(std::size_t numThreads = std::max(1U, std::thread::hardware_concurrency() - 1U))
    : mainContext_()
    , workerContext_()
    , mainGuard_(asio::make_work_guard(mainContext_))
    , workerGuard_(asio::make_work_guard(workerContext_))
    {
#ifdef TRACY_ENABLE
        tracy::SetThreadName("Main Thread");
#endif

        workerThreads_.reserve(numThreads);
        for (size_t idx = 0; idx < numThreads; ++idx)
        {
            workerThreads_.emplace_back(&Scheduler::workerLoop, this, idx);
        }
    }

    ~Scheduler()
    {
        stop();
    }

    Scheduler(const Scheduler&)            = delete;
    Scheduler& operator=(const Scheduler&) = delete;
    Scheduler(Scheduler&&)                 = delete;
    Scheduler& operator=(Scheduler&&)      = delete;

    void run()
    {
        try
        {
            mainContext_.run(); // block thread
        }
        catch (...)
        {
            stop();
            throw; // Throw exception back up to user
        }

        // If we break out of context::run(), begin shutting down
        stop();
    }

    void workerLoop(std::size_t index)
    {
#ifdef TRACY_ENABLE
        const auto threadName = std::format("Worker Thread {}", index + 1);
        tracy::SetThreadName(threadName.c_str());
#else
        std::ignore = index;
#endif
        // Try and do work, but if an exception is encountered capture it and post it back
        // to the main thread.
        try
        {
            workerContext_.run();
        }
        catch (...)
        {
            asio::post(
                mainContext_,
                [ex = std::current_exception()]
                {
                    std::rethrow_exception(ex);
                });
        }
    }

    void stop()
    {
        bool expected = false;
        if (!closeRequested_.compare_exchange_strong(expected, true))
        {
            return;
        }

        mainGuard_.reset();
        workerGuard_.reset();

        for (auto& t : workerThreads_)
        {
            if (t.joinable())
            {
                t.join();
            }
        }
        workerThreads_.clear();
    }

    [[nodiscard]] auto closeRequested() const -> bool
    {
        return closeRequested_;
    }

    // onMainThread
    //   Queue work lazily on the main thread. It won't start executing until you co_await the
    //   returned task.
    template <detail::IsAwaitable T>
    [[nodiscard]] auto onMainThread(T&& task) -> Task<typename detail::AwaitableResult<std::decay_t<T>>::type>
    {
        return asio::co_spawn(mainContext_.get_executor(), std::forward<T>(task), asio::use_awaitable);
    }

    // onMainThread
    //   Queue work lazily on the main thread. It won't start executing until you co_await the
    //   returned task.
    template <detail::IsInvocable F>
    [[nodiscard]] auto onMainThread(F&& func) -> Task<std::invoke_result_t<std::decay_t<F>>>
    {
        return asio::co_spawn(
            mainContext_.get_executor(),
            [fn = std::forward<F>(func)]() mutable -> Task<std::invoke_result_t<std::decay_t<F>>>
            {
                if constexpr (std::is_void_v<std::invoke_result_t<std::decay_t<F>>>)
                {
                    fn();
                    co_return;
                }
                else
                {
                    co_return fn();
                }
            },
            asio::use_awaitable);
    }

    // onWorkerThread
    //   Queue work lazily on the worker thread pool. It won't start executing until you co_await
    //   the returned task.
    template <detail::IsAwaitable T>
    [[nodiscard]] auto onWorkerThread(T&& task) -> Task<typename detail::AwaitableResult<std::decay_t<T>>::type>
    {
        return asio::co_spawn(workerContext_.get_executor(), std::forward<T>(task), asio::use_awaitable);
    }

    // onWorkerThread
    //   Queue work lazily on the worker thread pool. It won't start executing until you co_await
    //   the returned task.
    template <detail::IsInvocable F>
    [[nodiscard]] auto onWorkerThread(F&& func) -> Task<std::invoke_result_t<std::decay_t<F>>>
    {
        return asio::co_spawn(
            workerContext_.get_executor(),
            [fn = std::forward<F>(func)]() mutable -> Task<std::invoke_result_t<std::decay_t<F>>>
            {
                if constexpr (std::is_void_v<std::invoke_result_t<std::decay_t<F>>>)
                {
                    fn();
                    co_return;
                }
                else
                {
                    co_return fn();
                }
            },
            asio::use_awaitable);
    }

    // postToMainThread
    //   Queue work eagerly on the main thread. It will start executing immediately.
    template <detail::IsAwaitableReturnsVoid T>
    void postToMainThread(T&& task)
    {
        asio::co_spawn(mainContext_.get_executor(), std::forward<T>(task), asio::detached);
    }

    // postToMainThread
    //   Queue work eagerly on the main thread. It will start executing immediately.
    template <detail::IsInvocableReturnsVoid F>
    void postToMainThread(F&& func)
    {
        asio::co_spawn(
            mainContext_.get_executor(),
            [fn = std::forward<F>(func)]() mutable -> Task<void>
            {
                fn();
                co_return;
            },
            asio::detached);
    }

    // postToWorkerThread
    //   Queue work eagerly on the worker thread pool. It will start executing immediately.
    template <detail::IsAwaitableReturnsVoid T>
    void postToWorkerThread(T&& task)
    {
        asio::co_spawn(workerContext_.get_executor(), std::forward<T>(task), asio::detached);
    }

    // postToWorkerThread
    //   Queue work eagerly on the worker thread pool. It will start executing immediately.
    template <detail::IsInvocableReturnsVoid F>
    void postToWorkerThread(F&& func)
    {
        asio::co_spawn(
            workerContext_.get_executor(),
            [fn = std::forward<F>(func)]() mutable -> Task<void>
            {
                fn();
                co_return;
            },
            asio::detached);
    }

    // yield
    //   co_await on this to hand control back to the scheduler.
    [[nodiscard]] auto yield() -> Task<void>
    {
        auto executor = co_await asio::this_coro::executor;
        co_await asio::post(executor, asio::use_awaitable);
    }

    // yieldFor
    //   co_await on this to hand control back to the scheduler, without re-scheduling until the
    //   duration has elapsed.
    [[nodiscard]] auto yieldFor(std::chrono::steady_clock::duration duration) -> Task<void>
    {
        auto executor = co_await asio::this_coro::executor;
        auto timer    = asio::steady_timer(executor);
        timer.expires_after(duration);
        co_await timer.async_wait(asio::use_awaitable);
    }

    // withTimeout
    //   Executes a task with a given timeout. Returns std::optional<T>, which is empty if the timeout
    //   was reached before the task completed.
    template <typename T>
    [[nodiscard]] auto withTimeout(Task<T> task, std::chrono::steady_clock::duration timeout) -> Task<std::optional<T>>
    {
        using namespace asio::experimental::awaitable_operators;
        auto result = co_await (std::move(task) || yieldFor(timeout));
        if (result.index() == 0)
        {
            co_return std::move(std::get<0>(result));
        }
        co_return std::nullopt;
    }

    // ioContext
    //   Return the main io_context.
    //   TODO: We should be trying to get rid of this accessor as soon as possible!
    [[nodiscard]] auto ioContext() -> asio::io_context&
    {
        return mainContext_;
    }

private:
    std::atomic<bool>        closeRequested_{ false };
    asio::io_context         mainContext_;
    asio::io_context         workerContext_;
    std::vector<std::thread> workerThreads_;

    asio::executor_work_guard<asio::io_context::executor_type> mainGuard_;
    asio::executor_work_guard<asio::io_context::executor_type> workerGuard_;
};
