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

#include "common/logging.h"
#include "common/lua.h"

#include "entities/char_entity.h"
#include "enums/packet_c2s.h"

PacketRateLimiter::PacketRateLimiter()
{
    const auto limits = lua["xi"]["settings"]["network"]["PACKET_RATE_LIMITS"].get_or_create<sol::table>();
    if (limits.empty())
    {
        ShowWarning("network.PACKET_RATE_LIMITS is missing or empty, no packets will be rate limited");
        return;
    }

    for (const auto& [keyObj, valueObj] : limits)
    {
        if (keyObj.get_type() != sol::type::string || valueObj.get_type() != sol::type::number)
        {
            ShowWarning("PACKET_RATE_LIMITS: expected entries of the form <packet name> = <milliseconds>, ignoring entry");
            continue;
        }

        const auto packetName    = keyObj.as<std::string>();
        const auto maybePacketId = magic_enum::enum_cast<PacketC2S>(packetName);
        if (!maybePacketId.has_value())
        {
            ShowWarningFmt("PACKET_RATE_LIMITS: unknown packet name {}, ignoring entry", packetName);
            continue;
        }

        const auto milliseconds = valueObj.as<double>();
        if (milliseconds < 0.0)
        {
            ShowWarningFmt("PACKET_RATE_LIMITS: negative duration for {}, ignoring entry", packetName);
            continue;
        }

        if (milliseconds == 0.0)
        {
            continue;
        }

        rateLimits_[static_cast<uint16>(*maybePacketId)] = std::chrono::milliseconds(static_cast<int64>(milliseconds));
    }
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
