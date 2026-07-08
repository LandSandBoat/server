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
#include <asio/bind_allocator.hpp>
#include <asio/bind_cancellation_slot.hpp>
#include <asio/cancellation_signal.hpp>
#include <asio/co_spawn.hpp>
#include <asio/detached.hpp>
#include <asio/executor_work_guard.hpp>
#include <asio/experimental/awaitable_operators.hpp>
#include <asio/experimental/parallel_group.hpp>
#include <asio/io_context.hpp>
#include <asio/post.hpp>
#include <asio/recycling_allocator.hpp>
#include <asio/steady_timer.hpp>
#include <asio/this_coro.hpp>
#include <asio/thread_pool.hpp>
#include <asio/use_awaitable.hpp>

#include <common/types/maybe.h>

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
concept IsAwaitable = IsASIOAwaitable<std::remove_cvref_t<T>>::value;

template <typename T>
struct AwaitableResult;

template <typename T, typename E>
struct AwaitableResult<asio::awaitable<T, E>>
{
    using type = T;
};

template <typename T>
using AwaitableResultType = typename AwaitableResult<std::remove_cvref_t<T>>::type;

template <typename T>
concept IsInvocable = std::invocable<std::remove_cvref_t<T>>;

template <typename T>
concept IsInvocableReturnsVoid = IsInvocable<T> && std::is_void_v<std::invoke_result_t<std::remove_cvref_t<T>>>;

template <typename T>
concept IsAwaitableReturnsVoid = IsAwaitable<T> && std::is_void_v<AwaitableResultType<T>>;

template <typename T>
concept IsInvocableReturnsAwaitableVoid = IsInvocable<T> && IsAwaitableReturnsVoid<std::invoke_result_t<std::remove_cvref_t<T>>>;

template <typename T>
concept IsInvocableReturnsVoidOrAwaitableVoid = IsInvocableReturnsAwaitableVoid<T> || IsInvocableReturnsVoid<T>;

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
template <detail::IsAwaitable... Tasks>
    requires(sizeof...(Tasks) > 0)
[[nodiscard]] auto All(Tasks&&... tasks)
{
    using namespace asio::experimental::awaitable_operators;
    return (std::forward<Tasks>(tasks) && ...);
}

//
// One
//   Race multiple tasks and return a variant of the winner.
//
template <detail::IsAwaitable... Tasks>
    requires(sizeof...(Tasks) > 0)
[[nodiscard]] auto One(Tasks&&... tasks)
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
    //
    // Token
    //   Cancellation token for recurring or delayed tasks.
    //
    class Token
    {
    public:
        explicit Token(std::shared_ptr<asio::cancellation_signal> signal) noexcept
        : signal_(std::move(signal))
        {
        }

        ~Token()
        {
            stop();
        }

        void stop() noexcept
        {
            if (signal_)
            {
                signal_->emit(asio::cancellation_type::all);
                signal_.reset();
            }
        }

        // Disable copy
        Token(const Token&)            = delete;
        Token& operator=(const Token&) = delete;

        // Allow moving
        Token(Token&&) noexcept            = default;
        Token& operator=(Token&&) noexcept = default;

    private:
        std::shared_ptr<asio::cancellation_signal> signal_;
    };

    //
    // TaskGroup
    //   Builds an awaitable collection of tasks.
    //
    template <typename F>
    [[nodiscard]] static auto TaskGroup(const std::size_t reserveSize, F&& func) -> Task<void>
    {
        const auto executor = co_await asio::this_coro::executor;

        using DeferredOp = decltype(asio::co_spawn(executor, std::declval<Task<void>>(), asio::bind_allocator(asio::recycling_allocator<void>(), asio::deferred)));
        std::vector<DeferredOp> ops;
        if (reserveSize > 0)
        {
            ops.reserve(reserveSize);
        }

        auto add = [&](Task<void> task)
        {
            ops.push_back(asio::co_spawn(executor, std::move(task), asio::bind_allocator(asio::recycling_allocator<void>(), asio::deferred)));
        };

        std::forward<F>(func)(add);

        if (ops.empty())
        {
            co_return;
        }

        auto group = asio::experimental::make_parallel_group(std::move(ops));
        co_await group.async_wait(asio::experimental::wait_for_all(), asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    explicit Scheduler(const std::size_t numThreads = std::max<std::size_t>(1U, std::thread::hardware_concurrency() > 0 ? std::thread::hardware_concurrency() - 1U : 1U))
    : mainContext_()
    , mainGuard_(asio::make_work_guard(mainContext_))
    , workerPool_(numThreads)
    {
#ifdef TRACY_ENABLE
        tracy::SetThreadName("Main Thread");
#endif
    }

    ~Scheduler()
    {
        stop();
    }

    Scheduler(const Scheduler&)            = delete;
    Scheduler& operator=(const Scheduler&) = delete;
    Scheduler(Scheduler&&)                 = delete;
    Scheduler& operator=(Scheduler&&)      = delete;

    // run
    //   Runs the main thread's event loop. Blocks until stopped.
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

    // stop
    //   Requests the scheduler to stop all execution and joins threads.
    void stop()
    {
        closeRequested_.store(true, std::memory_order_relaxed);

        // NOTE: The order of operations is important here

        mainContext_.stop();
        mainGuard_.reset();

        workerPool_.stop();
        workerPool_.join();
    }

    // closeRequested
    //   Returns whether a shutdown has been requested.
    [[nodiscard]] auto closeRequested() const noexcept -> bool
    {
        return closeRequested_.load(std::memory_order_relaxed);
    }

    // spawnOnMainThread
    //   Queue work lazily on the main thread. It won't start executing until you co_await the
    //   returned task. Does not block the caller.
    template <detail::IsAwaitable T>
    [[nodiscard]] auto spawnOnMainThread(T&& task) -> Task<detail::AwaitableResultType<T>>
    {
        return asio::co_spawn(mainContext_.get_executor(), std::forward<T>(task), asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    // spawnOnMainThread
    //   Queue work lazily on the main thread. It won't start executing until you co_await the
    //   returned task. Does not block the caller.
    template <detail::IsInvocable F>
    [[nodiscard]] auto spawnOnMainThread(F&& func) -> Task<std::invoke_result_t<std::remove_cvref_t<F>>>
    {
        return asio::co_spawn(
            mainContext_.get_executor(),
            [fn = std::forward<F>(func)]() mutable -> Task<std::invoke_result_t<std::remove_cvref_t<F>>>
            {
                co_return fn();
            },
            asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    // spawnOnWorkerThread
    //   Queue work lazily on the worker thread pool. It won't start executing until you co_await
    //   the returned task. Does not block the caller.
    template <detail::IsAwaitable T>
    [[nodiscard]] auto spawnOnWorkerThread(T&& task) -> Task<detail::AwaitableResultType<T>>
    {
        return asio::co_spawn(workerPool_.executor(), std::forward<T>(task), asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    // spawnOnWorkerThread
    //   Queue work lazily on the worker thread pool. It won't start executing until you co_await
    //   the returned task. Does not block the caller.
    template <detail::IsInvocable F>
    [[nodiscard]] auto spawnOnWorkerThread(F&& func) -> Task<std::invoke_result_t<std::remove_cvref_t<F>>>
    {
        return asio::co_spawn(
            workerPool_.executor(),
            [fn = std::forward<F>(func)]() mutable -> Task<std::invoke_result_t<std::remove_cvref_t<F>>>
            {
                co_return fn();
            },
            asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    // postToMainThread
    //   Queue work eagerly on the main thread. Executed via event loop tick. Does not block the caller.
    template <detail::IsAwaitableReturnsVoid T>
    void postToMainThread(T&& task)
    {
        asio::co_spawn(mainContext_.get_executor(), std::forward<T>(task), asio::bind_allocator(asio::recycling_allocator<void>(), asio::detached));
    }

    // postToMainThread
    //   Queue work eagerly on the main thread. Executed via event loop tick. Does not block the caller.
    template <detail::IsInvocableReturnsAwaitableVoid T>
    void postToMainThread(T&& func)
    {
        asio::co_spawn(mainContext_.get_executor(), std::forward<T>(func), asio::bind_allocator(asio::recycling_allocator<void>(), asio::detached));
    }

    // postToMainThread
    //   Queue work eagerly on the main thread. Executed via event loop tick. Does not block the caller.
    template <detail::IsInvocableReturnsVoid T>
    void postToMainThread(T&& func)
    {
        asio::post(mainContext_.get_executor(), asio::bind_allocator(asio::recycling_allocator<void>(), std::forward<T>(func)));
    }

    // postToWorkerThread
    //   Queue work eagerly on the worker thread pool. Executed via event loop tick. Does not block the caller.
    template <detail::IsAwaitableReturnsVoid T>
    void postToWorkerThread(T&& task)
    {
        asio::co_spawn(workerPool_.executor(), std::forward<T>(task), asio::bind_allocator(asio::recycling_allocator<void>(), asio::detached));
    }

    // postToWorkerThread
    //   Queue work eagerly on the worker thread pool. Executed via event loop tick. Does not block the caller.
    template <detail::IsInvocableReturnsAwaitableVoid T>
    void postToWorkerThread(T&& func)
    {
        asio::co_spawn(workerPool_.executor(), std::forward<T>(func), asio::bind_allocator(asio::recycling_allocator<void>(), asio::detached));
    }

    // postToWorkerThread
    //   Queue work eagerly on the worker thread pool. Executed via event loop tick. Does not block the caller.
    template <detail::IsInvocableReturnsVoid T>
    void postToWorkerThread(T&& func)
    {
        asio::post(workerPool_.executor(), asio::bind_allocator(asio::recycling_allocator<void>(), std::forward<T>(func)));
    }

    // intervalOnMainThread
    //   Queues a task on the main thread that repeats at the specified interval.
    //   Returns a Token that can be used to cancel the task.
    //   The task will stop if the token goes out of scope, or if the scheduler is stopped.
    //   Since a coroutine cannot be restarted once it has been completed, we must either pass in
    //   an invocable, or an invocable which _produces_ a coroutine for co_await-ing.
    template <detail::IsInvocableReturnsVoidOrAwaitableVoid T>
    [[nodiscard]] auto intervalOnMainThread(const std::chrono::steady_clock::duration duration, T&& func) -> Token
    {
        auto signal = std::make_shared<asio::cancellation_signal>();

        asio::co_spawn(
            mainContext_.get_executor(),
            [this, duration, signal, fn = std::forward<T>(func)]() mutable -> Task<void>
            {
                try
                {
                    while (!this->closeRequested())
                    {
                        if constexpr (detail::IsInvocableReturnsVoid<T>)
                        {
                            fn();
                        }
                        else
                        {
                            co_await fn();
                        }
                        co_await yieldFor(duration);
                    }
                }
                catch (const asio::system_error& e)
                {
                    // operation_aborted is expected when the Token is destroyed
                    if (e.code() != asio::error::operation_aborted)
                    {
                        throw;
                    }
                }
            },
            asio::bind_allocator(asio::recycling_allocator<void>(), asio::bind_cancellation_slot(signal->slot(), asio::detached)));

        return Token(std::move(signal));
    }

    // intervalOnWorkerThread
    //   Queues a task on the worker thread pool that repeats at the specified interval.
    //   Returns a Token that can be used to cancel the task.
    //   The task will stop if the token goes out of scope, or if the scheduler is stopped.
    //   Since a coroutine cannot be restarted once it has been completed, we must either pass in
    //   an invocable, or an invocable which _produces_ a coroutine for co_await-ing.
    template <detail::IsInvocableReturnsVoidOrAwaitableVoid T>
    [[nodiscard]] auto intervalOnWorkerThread(const std::chrono::steady_clock::duration duration, T&& func) -> Token
    {
        auto signal = std::make_shared<asio::cancellation_signal>();

        asio::co_spawn(
            workerPool_.executor(),
            [this, duration, signal, fn = std::forward<T>(func)]() mutable -> Task<void>
            {
                try
                {
                    while (!this->closeRequested())
                    {
                        if constexpr (detail::IsInvocableReturnsVoid<T>)
                        {
                            fn();
                        }
                        else
                        {
                            co_await fn();
                        }
                        co_await yieldFor(duration);
                    }
                }
                catch (const asio::system_error& e)
                {
                    // operation_aborted is expected when the Token is destroyed
                    if (e.code() != asio::error::operation_aborted)
                    {
                        throw;
                    }
                }
            },
            asio::bind_allocator(asio::recycling_allocator<void>(), asio::bind_cancellation_slot(signal->slot(), asio::detached)));

        return Token(std::move(signal));
    }

    // delayOnMainThread
    //   Queues a task on the main thread that executes once after the specified duration.
    //   Returns a Token that can be used to cancel the task before it executes.
    //   The task will be cancelled if the token goes out of scope, or if the scheduler is stopped.
    //   Since a coroutine cannot be restarted once it has been completed, we must either pass in
    //   an invocable, or an invocable which _produces_ a coroutine for co_await-ing.
    template <detail::IsInvocableReturnsVoidOrAwaitableVoid T>
    [[nodiscard]] auto delayOnMainThread(const std::chrono::steady_clock::duration duration, T&& func) -> Token
    {
        auto signal = std::make_shared<asio::cancellation_signal>();

        asio::co_spawn(
            mainContext_.get_executor(),
            [this, duration, signal, fn = std::forward<T>(func)]() mutable -> Task<void>
            {
                try
                {
                    co_await yieldFor(duration);
                    if (!this->closeRequested())
                    {
                        if constexpr (detail::IsInvocableReturnsVoid<T>)
                        {
                            fn();
                        }
                        else
                        {
                            co_await fn();
                        }
                    }
                }
                catch (const asio::system_error& e)
                {
                    // operation_aborted is expected when the Token is destroyed
                    if (e.code() != asio::error::operation_aborted)
                    {
                        throw;
                    }
                }
            },
            asio::bind_allocator(asio::recycling_allocator<void>(), asio::bind_cancellation_slot(signal->slot(), asio::detached)));

        return Token(std::move(signal));
    }

    // yield
    //   co_await on this to hand control back to the scheduler immediately.
    [[nodiscard]] static auto yield() -> Task<void>
    {
        const auto executor = co_await asio::this_coro::executor;
        co_await asio::post(executor, asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    // yieldFor
    //   co_await on this to hand control back to the scheduler, without re-scheduling until the
    //   duration has elapsed.
    [[nodiscard]] static auto yieldFor(const std::chrono::steady_clock::duration duration) -> Task<void>
    {
        const auto executor = co_await asio::this_coro::executor;
        auto       timer    = asio::steady_timer(executor);
        timer.expires_after(duration);
        co_await timer.async_wait(asio::bind_allocator(asio::recycling_allocator<void>(), asio::use_awaitable));
    }

    // withTimeout
    //   Executes a task with a given timeout. Returns Maybe<T>, which is empty if the timeout
    //   was reached before the task completed.
    template <typename T>
    [[nodiscard]] static auto withTimeout(Task<T> task, const std::chrono::steady_clock::duration timeout) -> Task<Maybe<T>>
    {
        using namespace asio::experimental::awaitable_operators;
        auto result = co_await (std::move(task) || yieldFor(timeout));
        if (result.index() == 0)
        {
            co_return std::move(std::get<0>(result));
        }
        co_return std::nullopt;
    }

    // blockOnMainThread
    //   Puts `task` on the main context wrapped with a gated check, and manually pumps the main
    //   context until that gate is passed - signalling that the task is complete.
    //   !!! This blocks the main thread !!!
    //   Other queued work may run in this pumping loop, but your task is guaranteed to be actioned.
    //   This is only to be used as a bridge for tests/legacy so we don't have to implement Lua
    //   coroutines. This isn't to be used as a crutch in regular non-test code!
    template <detail::IsAwaitable T>
    auto blockOnMainThread(T&& task) -> detail::AwaitableResultType<T>
    {
        if (std::this_thread::get_id() != mainThreadId_)
        {
            throw std::runtime_error("blockOnMain called from non-main thread");
        }

        // local work guard ensures the context keeps pumping even if
        // the current task is the only thing left and it is suspended.
        auto work = asio::make_work_guard(mainContext_);

        using ResultType      = detail::AwaitableResultType<T>;
        constexpr bool IsVoid = std::is_void_v<ResultType>;
        using StoredType      = std::conditional_t<IsVoid, std::monostate, ResultType>;

        auto exceptPtr = std::exception_ptr();
        auto done      = false;

        std::unique_ptr<StoredType> result;

        auto completion = [&](std::exception_ptr e, auto... res)
        {
            exceptPtr = e;
            if constexpr (!IsVoid)
            {
                if (!e && sizeof...(res) > 0)
                {
                    result = std::make_unique<StoredType>(std::move(std::get<0>(std::forward_as_tuple(res...))));
                }
            }
            done = true;
        };

        asio::co_spawn(
            mainContext_.get_executor(),
            std::forward<T>(task),
            asio::bind_allocator(asio::recycling_allocator<void>(), completion));

        // Reset stopped state in case a previous run/nested run stopped the context
        if (mainContext_.stopped())
        {
            mainContext_.restart();
        }

        // Pumping loop
        while (!done)
        {
            // run_one() blocks until one handler is executed.
            // If it returns 0, no work is currently available.
            if (mainContext_.run_one() == 0 && !done)
            {
                // This prevents a deadlock if the coroutine is waiting on something
                // that will never happen.
                throw std::runtime_error("Main context stalled in blockOnMain: No work remaining.");
            }
        }

        if (exceptPtr)
        {
            std::rethrow_exception(exceptPtr);
        }

        if constexpr (!IsVoid)
        {
            if (!result)
            {
                throw std::runtime_error("Task completed without result or exception");
            }
            return std::move(*result);
        }
    }

    // mainContext
    //   Return the main io_context.
    [[nodiscard]] auto mainContext() noexcept -> asio::io_context&
    {
        return mainContext_;
    }

private:
    std::thread::id mainThreadId_{ std::this_thread::get_id() };

    std::atomic<bool> closeRequested_{ false };

    asio::io_context                                           mainContext_;
    asio::executor_work_guard<asio::io_context::executor_type> mainGuard_;

    asio::thread_pool workerPool_;
};
