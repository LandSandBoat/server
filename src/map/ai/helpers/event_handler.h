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

#ifndef _EVENT_HANDLER
#define _EVENT_HANDLER

#include <functional>
#include <unordered_map>
#include <vector>

#include "common/cbasetypes.h"
#include "lua/luautils.h"

struct ai_event_t
{
    std::string   identifier;
    sol::function lua_func;

    ai_event_t(std::string const& _ident, sol::function _lua_func)
    : identifier(_ident)
    , lua_func(_lua_func)
    {
    }
};

class CAIEventHandler
{
public:
    void addListener(std::string const& eventname, sol::function const& lua_func, std::string const& identifier);
    void removeListener(std::string const& identifier);
    bool hasListener(std::string const& eventName);

    // calls event from core
    template <class... Args>
    void triggerListener(std::string const& eventname, Args&&... args)
    {
        TracyZoneScoped;
        TracyZoneString(eventname);

        // Mark this Event Handler as currently triggering listeners,
        // this is to prevent removal of listeners during this loop.
        isTriggeringListeners = true;

        // If we have registered listeners for this event, trigger them.
        if (eventListeners.count(eventname))
        {
            for (const auto& event : eventListeners.at(eventname))
            {
                auto result = event.lua_func(std::forward<Args&&>(args)...);
                if (!result.valid())
                {
                    sol::error err = result;
                    ShowError("Error in listener event %s: %s", eventname, err.what());
                    isTriggeringListeners = false;
                }
            }
        }

        // removeListener may have been called during the lua_func inside the loop.
        // We've accumulated any possible removals in eventsToRemove, so we can now
        // safely remove them from the eventListeners map without invalidating the
        // inner iterator.
        for (const auto& identifier : eventsToRemove)
        {
            removeFromAllListeners(identifier);
        }
        eventsToRemove.clear();

        isTriggeringListeners = false;
    }

private:
    void removeFromAllListeners(const std::string& identifier);

    bool isTriggeringListeners = false;

    std::unordered_map<std::string, std::vector<ai_event_t>> eventListeners;
    std::vector<std::string>                                 eventsToRemove;
};

#endif
