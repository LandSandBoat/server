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
#include <common/scheduler/task_utils.h>

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

// Windows timers tick every ~15ms and the machine may be busy, so wait for an outcome instead of a fixed time.
template <typename Condition>
auto pumpUntil(Scheduler& scheduler, Condition condition) -> bool
{
    for (auto i = 0; i < 1000 && !condition(); ++i)
    {
        pumpFor(scheduler, 2ms);
    }

    return condition();
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

TEST_CASE("Scheduler::blockOnMainThread finishes its task when another handler throws", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    scheduler.postToMainThread(
        []
        {
            throw std::logic_error("unrelated handler");
        });

    auto finished = false;
    CHECK_THROWS_AS(scheduler.blockOnMainThread(
                        [&]() -> Task<void>
                        {
                            co_await Scheduler::yield();
                            co_await Scheduler::yield();
                            finished = true;
                        }()),
                    std::logic_error);

    CHECK(finished);
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
            [](bool& flag) -> Task<void>
            {
                flag = true;
                co_return;
            }(ran));
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

TEST_CASE("runOnWorkerThreads", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("completes with no jobs")
    {
        scheduler.blockOnMainThread(runOnWorkerThreads(
            scheduler,
            0,
            [](auto&)
            {
            }));
    }

    SECTION("runs every job off the main thread")
    {
        const auto mainThread = std::this_thread::get_id();

        auto count  = std::atomic<int>(0);
        auto onMain = std::atomic<bool>(false);
        scheduler.blockOnMainThread(runOnWorkerThreads(
            scheduler,
            100,
            [&](auto& add)
            {
                for (auto i = 0; i < 100; ++i)
                {
                    add(
                        [&]
                        {
                            ++count;
                            if (std::this_thread::get_id() == mainThread)
                            {
                                onMain = true;
                            }
                        });
                }
            }));

        CHECK(count == 100);
        CHECK_FALSE(onMain);
    }

    SECTION("rethrows an exception once every job has run")
    {
        auto count = std::atomic<int>(0);
        CHECK_THROWS_AS(scheduler.blockOnMainThread(runOnWorkerThreads(
                            scheduler,
                            10,
                            [&](auto& add)
                            {
                                for (auto i = 0; i < 10; ++i)
                                {
                                    add(
                                        [&, i]
                                        {
                                            ++count;
                                            if (i % 3 == 0)
                                            {
                                                throw std::logic_error("bad zone data");
                                            }
                                        });
                                }
                            })),
                        std::logic_error);

        CHECK(count == 10);
    }
}

TEST_CASE("Scheduler::withTimeout", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("returns the result of a task that finishes in time")
    {
        const auto result = scheduler.blockOnMainThread(withTimeout(
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
        const auto result = scheduler.blockOnMainThread(withTimeout(
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

        CHECK(pumpUntil(scheduler, [&]
                        {
                            return count > 1;
                        }));
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

    SECTION("destroying the token while its work is suspended is quiet")
    {
        auto started = false;
        {
            auto token = scheduler.intervalOnMainThread(
                1ms,
                [&]() -> Task<void>
                {
                    started = true;
                    co_await Scheduler::yieldFor(1h);
                });
            REQUIRE(pumpUntil(scheduler, [&]
                              {
                                  return started;
                              }));
        }

        pumpFor(scheduler, 10ms);
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

        CHECK(pumpUntil(scheduler, [&]
                        {
                            return second > 1;
                        }));
        CHECK(first == firstAtReplace);
    }
}

TEST_CASE("Scheduler::intervalOnMainThread jitters the first run", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    auto count = 0;
    auto token = scheduler.intervalOnMainThread(
        1h,
        [&]
        {
            ++count;
        });
    pumpFor(scheduler, 20ms);

    // With a one hour period, a first run inside 20ms means it wasn't offset.
    CHECK(count == 0);
}

TEST_CASE("Scheduler::Token edge cases", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    auto count = 0;
    auto token = scheduler.intervalOnMainThread(
        1ms,
        [&]
        {
            ++count;
        });

    SECTION("a moved-from token doesn't stop the task, and stopping twice is safe")
    {
        auto moved = std::move(token);
        token.stop(); // NOLINT(bugprone-use-after-move)
        CHECK(pumpUntil(scheduler, [&]
                        {
                            return count > 0;
                        }));

        moved.stop();
        moved.stop();

        const auto countAtStop = count;
        pumpFor(scheduler, 10ms);
        CHECK(count == countAtStop);
    }

    SECTION("self move-assignment keeps the task")
    {
        auto& alias = token;
        token       = std::move(alias);

        CHECK(pumpUntil(scheduler, [&]
                        {
                            return count > 1;
                        }));
    }
}

TEST_CASE("Scheduler::intervalOnMainThread edge cases", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("the callback can stop its own token")
    {
        auto count = 0;
        auto token = Maybe<Scheduler::Token>();
        token      = scheduler.intervalOnMainThread(
            1ms,
            [&]
            {
                ++count;
                token.reset();
            });
        REQUIRE(pumpUntil(scheduler, [&]
                          {
                              return count > 0;
                          }));
        pumpFor(scheduler, 50ms);

        CHECK(count == 1);
    }

    SECTION("the callback can replace its own token")
    {
        auto first  = 0;
        auto second = 0;
        auto token  = Maybe<Scheduler::Token>();
        token       = scheduler.intervalOnMainThread(
            1ms,
            [&]
            {
                ++first;
                token = scheduler.intervalOnMainThread(
                    1ms,
                    [&]
                    {
                        ++second;
                    });
            });

        CHECK(pumpUntil(scheduler, [&]
                        {
                            return second > 1;
                        }));
        CHECK(first == 1);
    }

    SECTION("a zero interval still lets other work run")
    {
        auto count = 0;
        auto token = scheduler.intervalOnMainThread(
            0ms,
            [&]
            {
                ++count;
            });

        auto ran = false;
        scheduler.postToMainThread(
            [&]
            {
                ran = true;
            });

        CHECK(pumpUntil(scheduler, [&]
                        {
                            return count > 0 && ran;
                        }));
    }
}

TEST_CASE("Scheduler cross-thread work", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("a worker can post back to the main thread")
    {
        const auto mainThread = std::this_thread::get_id();

        auto ranOn = std::thread::id();
        scheduler.postToWorkerThread(
            [&]
            {
                scheduler.postToMainThread(
                    [&]
                    {
                        ranOn = std::this_thread::get_id();
                    });
            });

        for (auto i = 0; i < 100 && ranOn == std::thread::id(); ++i)
        {
            pumpFor(scheduler, 1ms);
        }

        CHECK(ranOn == mainThread);
    }

    SECTION("spawnOnWorkerThread passes an exception to its awaiter")
    {
        CHECK_THROWS_AS(scheduler.blockOnMainThread(scheduler.spawnOnWorkerThread(
                            []
                            {
                                throw std::logic_error("worker failed");
                            })),
                        std::logic_error);
    }
}

TEST_CASE("Scheduler::withTimeout edge cases", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    SECTION("passes the task's exception through")
    {
        CHECK_THROWS_AS(scheduler.blockOnMainThread(withTimeout(
                            [](const bool fail) -> Task<int>
                            {
                                if (fail)
                                {
                                    throw std::logic_error("read failed");
                                }

                                co_return 0;
                            }(true),
                            1s)),
                        std::logic_error);
    }

    SECTION("a zero timeout gives up on a task that suspends")
    {
        const auto result = scheduler.blockOnMainThread(withTimeout(
            []() -> Task<int>
            {
                co_await Scheduler::yieldFor(1s);
                co_return 3;
            }(),
            0ms));

        CHECK_FALSE(result.has_value());
    }
}

TEST_CASE("Scheduler::stop can be called twice", "[scheduler]")
{
    auto scheduler = Scheduler(kWorkerThreads);

    scheduler.stop();
    scheduler.stop();

    CHECK(scheduler.closeRequested());
}
