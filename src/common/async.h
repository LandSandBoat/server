/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "singleton.h"

#include <atomic>
#include <condition_variable>
#include <functional>
#include <mutex>
#include <thread>

namespace asio
{
    class thread_pool;
}

class Async : public Singleton<Async>
{
public:
    ~Async();

    void submit(const std::function<void()>& func);
    void wait();
    auto currentTaskCount() const -> std::size_t;

    void setThreadpoolSize(std::size_t size);

protected:
    Async();

private:
    std::mutex                         mutex_;
    std::condition_variable            cv_;
    std::size_t                        threadPoolSize_{ 1U };
    std::atomic<std::size_t>           taskCount_{ 0U };
    std::unique_ptr<asio::thread_pool> threadPool_;
    std::thread::id                    mainThreadId_;
};
