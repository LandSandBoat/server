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

#include "async.h"

#include "logging.h"
#include "tracy.h"

#include <asio.hpp>

Async::Async()
: threadPool_(std::make_unique<asio::thread_pool>(threadPoolSize_))
, mainThreadId_(std::this_thread::get_id())
{
}

Async::~Async()
{
}

void Async::submit(const xi::Fn<void()>& func)
{
    TracyZoneScoped;

    if (std::this_thread::get_id() != mainThreadId_)
    {
        ShowCritical("Async::submit must be called from the main thread");
        return;
    }

    std::unique_lock<std::mutex> lock(mutex_);

    ++taskCount_;

    asio::post(*threadPool_,
               [this, func]()
               {
                   TracyZoneScoped;
                   TracySetThreadName("Async Worker Thread");

                   try
                   {
                       func();
                   }
                   catch (const std::exception& e)
                   {
                       ShowCritical("Async task threw an exception: %s", e.what());
                       std::terminate();
                   }

                   if (--taskCount_ == 0)
                   {
                       std::lock_guard<std::mutex> lock(mutex_);
                       cv_.notify_all();
                   }
               });
}

void Async::wait()
{
    TracyZoneScoped;

    if (currentTaskCount() == 0)
    {
        return;
    }

    ShowDebug("Waiting for async %i tasks to complete on %i workers", currentTaskCount(), threadPoolSize_);

    std::unique_lock<std::mutex> lock(mutex_);
    cv_.wait(lock,
             [this]()
             {
                 return taskCount_.load() == 0;
             });

    ShowDebug("All async tasks completed");
}

auto Async::currentTaskCount() const -> std::size_t
{
    return taskCount_.load();
}

void Async::setThreadpoolSize(std::size_t size)
{
    TracyZoneScoped;

    wait();

    ShowDebug("Setting async thread pool size to %i", size);

    threadPoolSize_ = size;

    std::unique_lock<std::mutex> lock(mutex_);
    threadPool_ = std::make_unique<asio::thread_pool>(threadPoolSize_);
}
