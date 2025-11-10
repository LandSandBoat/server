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

SearchEngine::SearchEngine(asio::io_context& io_context)
: m_searchHandler(io_context, settings::get<uint32>("network.SEARCH_PORT"), m_ipWhitelist)
, m_periodicCleanupTimer(io_context, std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL")))
{
    const auto accessWhitelist = lua["xi"]["settings"]["search"]["ACCESS_WHITELIST"].get_or_create<sol::table>();
    for (const auto& [_, value] : accessWhitelist)
    {
        auto str = value.as<std::string>();
        m_ipWhitelist.write(
            [str](auto& ipWhitelist)
            {
                ipWhitelist.insert(str);
            });
    }

    if (settings::get<bool>("search.EXPIRE_AUCTIONS"))
    {
        m_periodicCleanupTimer.async_wait(std::bind(&SearchEngine::periodicCleanup, this, std::placeholders::_1));
    }
}

SearchEngine::~SearchEngine()
{
    m_periodicCleanupTimer.cancel();
};

void SearchEngine::onInitialize()
{
    if (settings::get<bool>("search.EXPIRE_AUCTIONS"))
    {
        ShowInfoFmt("AH task to return items older than {} days is running", settings::get<uint16>("search.EXPIRE_DAYS"));
        expireAH(settings::get<uint16>("search.EXPIRE_DAYS"));
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

void SearchEngine::expireAH(const std::optional<uint16> days) const
{
    CDataLoader data;
    data.ExpireAHItems(days.value_or(0));
}

void SearchEngine::periodicCleanup(const asio::error_code& error)
{
    if (!error)
    {
        expireAH(settings::get<uint16>("search.EXPIRE_DAYS"));

        // reset timer
        m_periodicCleanupTimer.expires_at(m_periodicCleanupTimer.expiry() + std::chrono::seconds(settings::get<uint32>("search.EXPIRE_INTERVAL")));
        m_periodicCleanupTimer.async_wait(std::bind(&SearchEngine::periodicCleanup, this, std::placeholders::_1));
    }
}
