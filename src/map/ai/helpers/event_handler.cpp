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

#include <map/ai/helpers/event_handler.h>

void CAIEventHandler::addListener(const std::string& eventName, const sol::function& luaFunc, const std::string& identifier)
{
    TracyZoneScoped;
    TracyZoneString(eventName);
    TracyZoneString(identifier);

    // Remove entries with same identifier (if they exist)
    removeFromAllListeners(identifier);

    // Add the new listener
    eventListeners_[eventName].emplace_back(identifier, luaFunc);
}

void CAIEventHandler::removeListener(const std::string& identifier)
{
    TracyZoneScoped;
    TracyZoneString(identifier);

    // If we're currently triggering listeners, it isn't safe to remove
    // the listener from the list, so we'll mark it for lazy removal later
    if (triggerDepth_ > 0)
    {
        eventsToRemove_.push_back(identifier);
        return;
    }

    // Otherwise, we can remove the listener immediately
    removeFromAllListeners(identifier);
}

bool CAIEventHandler::hasListener(const std::string& eventName) const
{
    const auto& listeners = eventListeners_.find(eventName);
    return listeners != eventListeners_.end() && !listeners->second.empty();
}

void CAIEventHandler::removeFromAllListeners(const std::string& identifier)
{
    TracyZoneScoped;
    TracyZoneString(identifier);

    const auto isSameIdentifier = [&identifier](const AIEvent& event)
    {
        return identifier == event.identifier_;
    };

    for (auto& [_, listeners] : eventListeners_)
    {
        // Partition the vector so that all elements that match the identifier are at the end
        auto it = std::remove_if(listeners.begin(), listeners.end(), isSameIdentifier);

        // Erase the partitioned elements
        listeners.erase(it, listeners.end());
    }
}
