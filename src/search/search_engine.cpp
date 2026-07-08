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

#include "search_engine.h"
#include "common/lua.h"
#include "data_loader.h"

SearchEngine::SearchEngine(Scheduler& scheduler)
: scheduler_(scheduler)
, searchListener_(scheduler_, settings::get<uint32>("network.SEARCH_PORT"), ipWhitelist_)
{
    const auto accessWhitelist = lua["xi"]["settings"]["search"]["ACCESS_WHITELIST"].get_or_create<sol::table>();
    for (const auto& [_, value] : accessWhitelist)
    {
        auto str = value.as<std::string>();
        ipWhitelist_.write(
            [str](auto& ipWhitelist)
            {
                ipWhitelist.insert(str);
            });
    }

    if (settings::get<bool>("search.EXPIRE_AUCTIONS"))
    {
        const auto interval   = std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL"));
        periodicCleanupToken_ = scheduler_.intervalOnMainThread(
            interval,
            [this]()
            {
                expireAH(settings::get<uint16>("search.EXPIRE_DAYS"));
            });
    }
}

SearchEngine::~SearchEngine()
{
}

void SearchEngine::onInitialize()
{
    if (settings::get<bool>("search.EXPIRE_AUCTIONS"))
    {
        ShowInfoFmt("AH task to return items older than {} days is running", settings::get<uint16>("search.EXPIRE_DAYS"));

        scheduler_.postToWorkerThread(
            [this, days = settings::get<uint16>("search.EXPIRE_DAYS")]
            {
                expireAH(days);
            });
    }
}

void SearchEngine::onAHCleanup(std::vector<std::string>& inputs) const
{
    expireAH(settings::get<uint16>("search.EXPIRE_DAYS"));
}

void SearchEngine::onExpireAll(std::vector<std::string>& inputs) const
{
    expireAH(std::nullopt);
}

void SearchEngine::expireAH(const Maybe<uint16> days) const
{
    CDataLoader data;
    data.ExpireAHItems(days.value_or(0));
}
