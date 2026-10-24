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

#include <common/scheduler/scheduler.h>

#include <catch2/catch_test_macros.hpp>

#include <atomic>
#include <chrono>
#include <memory>
#include <stdexcept>
#include <thread>

using namespace std::chrono_literals;

namespace
{

constexpr auto kWorkerThreads = 2U;

auto pumpFor(Scheduler& scheduler, const std::chrono::steady_clock::duration duration) -> void
{
    scheduler.blockOnMainThread(Scheduler::yieldFor(duration));
}

} // namespace

TEST_CASE("Scheduler::blockOnMainThread returns the task's result", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("a value")
    {
        const auto value = scheduler.blockOnMainThread(
            []() -> Task<int>
            {
                co_return 42;
            }());

        CHECK(value == 42);
    }

    SECTION("a move-only value")
    {
        const auto value = scheduler.blockOnMainThread(
            []() -> Task<std::unique_ptr<int>>
            {
                co_return std::make_unique<int>(7);
            }());

        REQUIRE(value != nullptr);
        CHECK(*value == 7);
    }

    SECTION("void")
    {
        auto ran = false;
        scheduler.blockOnMainThread(
            [&]() -> Task<void>
            {
                ran = true;
                co_return;
            }());

        CHECK(ran);
    }

    SECTION("an exception")
    {
        CHECK_THROWS_AS(scheduler.blockOnMainThread(
                            [](const bool fail) -> Task<int>
                            {
                                if (fail)
                                {
                                    throw std::logic_error("boom");
                                }

                                co_return 0;
                            }(true)),
                        std::logic_error);
    }
}

TEST_CASE("Scheduler::blockOnMainThread rejects other threads", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    auto threw  = false;
    auto thread = std::thread(
        [&]
        {
            try
            {
                scheduler.blockOnMainThread(Scheduler::yield());
            }
            catch (const std::runtime_error&)
            {
                threw = true;
            }
        });
    thread.join();

    CHECK(threw);
}

TEST_CASE("Scheduler::stop rejects other threads", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    auto threw  = false;
    auto thread = std::thread(
        [&]
        {
            try
            {
                scheduler.stop();
            }
            catch (const std::runtime_error&)
            {
                threw = true;
            }
        });
    thread.join();

    CHECK(threw);
    CHECK_FALSE(scheduler.closeRequested());
}

TEST_CASE("Scheduler posts and spawns run their work", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("postToMainThread with a plain function")
    {
        auto ran = false;
        scheduler.postToMainThread(
            [&]
            {
                ran = true;
            });
        pumpFor(scheduler, 5ms);

        CHECK(ran);
    }

    SECTION("postToMainThread with a function returning a task")
    {
        auto ran = false;
        scheduler.postToMainThread(
            [&]() -> Task<void>
            {
                ran = true;
                co_return;
            });
        pumpFor(scheduler, 5ms);

        CHECK(ran);
    }

    SECTION("postToMainThread with a task")
    {
        auto ran = false;
        scheduler.postToMainThread(
            [&]() -> Task<void>
            {
                ran = true;
                co_return;
            }());
        pumpFor(scheduler, 5ms);

        CHECK(ran);
    }

    SECTION("postToWorkerThread runs off the main thread")
    {
        const auto mainThread = std::this_thread::get_id();

        auto workerThread = std::atomic<std::thread::id>();
        scheduler.postToWorkerThread(
            [&]
            {
                workerThread = std::this_thread::get_id();
            });

        for (auto i = 0; i < 100 && workerThread.load() == std::thread::id(); ++i)
        {
            pumpFor(scheduler, 1ms);
        }

        CHECK(workerThread.load() != std::thread::id());
        CHECK(workerThread.load() != mainThread);
    }

    SECTION("spawnOnWorkerThread returns the function's result")
    {
        const auto value = scheduler.blockOnMainThread(scheduler.spawnOnWorkerThread(
            []
            {
                return 9;
            }));

        CHECK(value == 9);
    }

    SECTION("spawnOnWorkerThread returns the task's result")
    {
        const auto value = scheduler.blockOnMainThread(scheduler.spawnOnWorkerThread(
            []() -> Task<int>
            {
                co_return 11;
            }()));

        CHECK(value == 11);
    }
}

TEST_CASE("Scheduler::TaskGroup awaits every task", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    auto count = std::atomic<int>(0);
    scheduler.blockOnMainThread(Scheduler::TaskGroup(
        0,
        [&](auto add)
        {
            for (auto i = 0; i < 4; ++i)
            {
                add(scheduler.spawnOnWorkerThread(
                    [&]
                    {
                        ++count;
                    }));
            }
        }));

    CHECK(count == 4);
}

TEST_CASE("Scheduler::withTimeout", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("returns the result of a task that finishes in time")
    {
        const auto result = scheduler.blockOnMainThread(Scheduler::withTimeout(
            []() -> Task<int>
            {
                co_return 3;
            }(),
            1s));

        REQUIRE(result.has_value());
        CHECK(*result == 3);
    }

    SECTION("returns nothing for a task that overruns")
    {
        const auto result = scheduler.blockOnMainThread(Scheduler::withTimeout(
            []() -> Task<int>
            {
                co_await Scheduler::yieldFor(1s);
                co_return 3;
            }(),
            5ms));

        CHECK_FALSE(result.has_value());
    }
}

TEST_CASE("Scheduler::Token", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("an interval repeats while its token lives")
    {
        auto count = 0;
        auto token = scheduler.intervalOnMainThread(
            1ms,
            [&]
            {
                ++count;
            });
        pumpFor(scheduler, 30ms);

        CHECK(count > 1);
    }

    SECTION("destroying the token stops the interval")
    {
        auto count = 0;
        {
            auto token = scheduler.intervalOnMainThread(
                1ms,
                [&]
                {
                    ++count;
                });
            pumpFor(scheduler, 10ms);
        }

        const auto countAtStop = count;
        pumpFor(scheduler, 20ms);

        CHECK(count == countAtStop);
    }

    SECTION("assigning over a token stops the interval it held")
    {
        auto first  = 0;
        auto second = 0;

        auto token = Maybe<Scheduler::Token>();
        token      = scheduler.intervalOnMainThread(
            1ms,
            [&]
            {
                ++first;
            });
        pumpFor(scheduler, 10ms);

        token = scheduler.intervalOnMainThread(
            1ms,
            [&]
            {
                ++second;
            });

        const auto firstAtReplace = first;
        pumpFor(scheduler, 20ms);

        CHECK(first == firstAtReplace);
        CHECK(second > 1);
    }
}

TEST_CASE("Scheduler::TaskGroup rethrows a task's exception", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    CHECK_THROWS_AS(scheduler.blockOnMainThread(Scheduler::TaskGroup(
                        1,
                        [&](auto add)
                        {
                            add(scheduler.spawnOnWorkerThread(
                                []
                                {
                                    throw std::logic_error("bad zone data");
                                }));
                        })),
                    std::logic_error);
}
