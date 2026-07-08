/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include <common/application.h>
#include <common/scheduler.h>
#include <common/utils.h>

#include <unordered_set>

#ifndef _WIN32
#include <sys/resource.h>
#endif

// search specific stuff
#include "search_listener.h"

class SearchEngine final : public Engine
{
public:
    SearchEngine(Scheduler& scheduler);
    ~SearchEngine() override;

    void onInitialize() override;

    void onAHCleanup(std::vector<std::string>& inputs) const;
    void onExpireAll(std::vector<std::string>& inputs) const;

    void expireAH(Maybe<uint16> days) const;

private:
    Maybe<Scheduler::Token> periodicCleanupToken_;

    Scheduler&     scheduler_;
    SearchListener searchListener_;

    // NOTE: We're only using the read-lock for this
    SynchronizedShared<std::unordered_set<std::string>> ipWhitelist_;
};
