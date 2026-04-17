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

#include "rate_limiter.h"

#include "entities/charentity.h"

using namespace std::chrono_literals;

// TODO: Move these to settings once the settings system supports nested tables.
PacketRateLimiter::PacketRateLimiter()
{
    rateLimits_[0x017] = 1s;    // Invalid NPC Information Response
    rateLimits_[0x03B] = 1s;    // Mannequin Equip
    rateLimits_[0x05D] = 2s;    // Emotes
    rateLimits_[0x083] = 250ms; // Vendor Shop Purchase
    rateLimits_[0x0AA] = 250ms; // Guild Shop Purchase
    rateLimits_[0x0B7] = 1s;    // Assist Channel
    rateLimits_[0x0F4] = 1s;    // Wide Scan
    rateLimits_[0x0F5] = 1s;    // Wide Scan Track
    rateLimits_[0x11B] = 2s;    // Set Job Master Display
    rateLimits_[0x11D] = 2s;    // Jump
}

auto PacketRateLimiter::isLimited(CCharEntity* PChar, uint16 packetId) -> bool
{
    const auto rateLimitIt = rateLimits_.find(packetId);
    if (rateLimitIt == rateLimits_.end())
    {
        return false;
    }

    auto timeNow                 = timer::now();
    const auto [it, wasInserted] = PChar->m_PacketRecievedTimestamps.emplace(packetId, timeNow);
    if (wasInserted)
    {
        return false;
    }

    const auto lastPacketReceivedTime = it->second;
    const bool limited                = timeNow < lastPacketReceivedTime + rateLimitIt->second;
    if (!limited)
    {
        it->second = timeNow;
    }

    return limited;
}
