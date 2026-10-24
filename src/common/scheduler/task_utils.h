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

#include <common/scheduler/scheduler.h>
#include <common/types/maybe.h>

#include <asio/deferred.hpp>
#include <asio/experimental/awaitable_operators.hpp>
#include <asio/experimental/parallel_group.hpp>

#include <chrono>
#include <cstddef>
#include <exception>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

//
// runOnWorkerThreads
//   Runs every function `fill` adds on the worker thread pool, and completes once they have all finished.
//   Rethrows the first exception any of them threw.
//
template <typename F>
[[nodiscard]] auto runOnWorkerThreads(Scheduler& scheduler, const std::size_t reserveSize, F&& fill) -> Task<void>
{
    const auto executor = scheduler.workerExecutor();

    using DeferredOp = decltype(asio::co_spawn(executor, std::declval<Task<void>>(), detail::recycled(asio::deferred)));
    auto ops         = std::vector<DeferredOp>();
    ops.reserve(reserveSize);

    auto add = [&]<detail::IsInvocableReturnsVoid Job>(Job&& job)
    {
        auto task = [](std::remove_cvref_t<Job> work) -> Task<void>
        {
            work();
            co_return;
        }(std::forward<Job>(job));

        ops.push_back(asio::co_spawn(executor, std::move(task), detail::recycled(asio::deferred)));
    };

    std::forward<F>(fill)(add);

    if (ops.empty())
    {
        co_return;
    }

    auto group = asio::experimental::make_parallel_group(std::move(ops));

    const auto [completionOrder, exceptions] = co_await group.async_wait(asio::experimental::wait_for_all(), detail::recycled(asio::use_awaitable));
    for (const auto& exception : exceptions)
    {
        if (exception)
        {
            std::rethrow_exception(exception);
        }
    }
}

//
// withTimeout
//   Executes a task with a given timeout. Returns Maybe<T>, which is empty if the timeout
//   was reached before the task completed.
//
template <typename T>
[[nodiscard]] auto withTimeout(Task<T> task, const std::chrono::steady_clock::duration timeout) -> Task<Maybe<T>>
{
    using namespace asio::experimental::awaitable_operators;
    auto result = co_await (std::move(task) || Scheduler::yieldFor(timeout));
    if (result.index() == 0)
    {
        co_return std::move(std::get<0>(result));
    }
    co_return std::nullopt;
}
