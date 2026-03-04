/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include <functional>
#include <unordered_map>
#include <vector>

#include <common/cbasetypes.h>

#include <map/lua/luautils.h>

class CAIEventHandler
{
    struct AIEvent
    {
        std::string   identifier_;
        sol::function luaFunc_;

        AIEvent(const std::string& identifier, sol::function luaFunc)
        : identifier_(identifier)
        , luaFunc_(luaFunc)
        {
        }
    };

public:
    void addListener(const std::string& eventName, const sol::function& luaFunc, const std::string& identifier);
    void removeListener(const std::string& identifier);
    bool hasListener(const std::string& eventName) const;

    template <class... Args>
    void triggerListener(const std::string& eventName, Args&&... args) noexcept
    {
        // No events or events with this name? Bail out
        auto it = eventListeners_.find(eventName);
        if (it == eventListeners_.end())
        {
            return;
        }

        // Only report triggers we're actually going to fire
        TracyZoneScoped;
        TracyZoneString(eventName);

        // Prevent modification while iterating
        ++triggerDepth_;
        {
            auto& listeners = it->second;
            for (auto& event : listeners)
            {
                auto result = event.luaFunc_(std::forward<Args>(args)...);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowErrorFmt("Error in listener event {}: {}", eventName, err.what());
                }
            }
        }
        --triggerDepth_;

        // Process deferred removals
        if (!eventsToRemove_.empty())
        {
            for (const auto& identifier : eventsToRemove_)
            {
                removeFromAllListeners(identifier);
            }
            eventsToRemove_.clear();
        }
    }

private:
    void removeFromAllListeners(const std::string& identifier);

    uint32 triggerDepth_ = 0;

    // TODO: Use string_view and is_transparent unordered_map + string_hash, etc.
    std::unordered_map<std::string, std::vector<AIEvent>> eventListeners_;
    std::vector<std::string>                              eventsToRemove_;
};
