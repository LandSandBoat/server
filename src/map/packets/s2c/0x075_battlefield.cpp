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

#include "0x075_battlefield.h"

#include "entities/baseentity.h"

GP_SERV_COMMAND_BATTLEFIELD::GP_SERV_COMMAND_BATTLEFIELD(const uint32 duration, const uint32 warning)
{
    this->addCountdown(duration, warning);
}

void GP_SERV_COMMAND_BATTLEFIELD::addCountdown(const uint32 duration, const uint32 warning)
{
    auto& packet = this->data();

    packet.Flags |= OBJECTIVEUTILITY_COUNTDOWN;
    packet.Mode         = packet.Mode == 0 ? 0x01 : packet.Mode;
    packet.Timestamp    = earth_time::vanadiel_timestamp();
    packet.Duration     = duration;
    packet.DurationWarn = warning;
}

void GP_SERV_COMMAND_BATTLEFIELD::addBars(std::vector<std::pair<std::string, uint32>>&& bars)
{
    auto& packet = this->data();

    packet.Flags |= OBJECTIVEUTILITY_PROGRESS;
    packet.Mode = 0xFFFF;

    uint8_t idx = 0;
    for (auto bar = bars.begin(); bar != bars.end(); ++bar)
    {
        packet.Progress.Rows[idx].Progress = bar->second;
        std::memcpy(packet.Progress.Rows[idx].Name, bar->first.c_str(), std::min(bar->first.size(), sizeof(packet.Progress.Rows[idx].Name)));
        ++idx;
    }
}

void GP_SERV_COMMAND_BATTLEFIELD::addScoreboard(const std::pair<int32, int32>& score, const std::vector<uint32>& data)
{
    auto& packet = this->data();

    packet.Mode = 0x1000;
    packet.Flags |= OBJECTIVEUTILITY_PROGRESS;
    packet.Scoreboard = {
        .MarchlandScore         = score.first,
        .StrongholdScore        = score.second,
        .MarchlandProgress      = data[0],
        .MarchlandProgressMax   = data[1],
        .StrongholdProgress     = data[2],
        .StrongholdProgressMax  = data[3],
        .MarchlandNameOverride  = data[4],
        .StrongholdNameOverride = data[5],
    };
}

void GP_SERV_COMMAND_BATTLEFIELD::addFence(const float x, const float z, const float radius, const float render, const bool blue /* = false */)
{
    auto& packet = this->data();

    packet.Flags |= OBJECTIVEUTILITY_FENCE;
    packet.FenceX        = static_cast<int32>(x * 1000);
    packet.FenceY        = static_cast<int32>(z * 1000);
    packet.FenceRadius   = static_cast<uint32>(radius * 1000);
    packet.FenceRotation = static_cast<uint32>(render * 1000);
    packet.FenceColor    = blue;
}

void GP_SERV_COMMAND_BATTLEFIELD::addHelpText(const uint16 title, const uint16 description)
{
    auto& packet = this->data();

    packet.Flags |= OBJECTIVEUTILITY_HELP;
    // These translate to a real table index of 0x1A, which is the mini-game string DAT file.
    //  JP: 55559 - ROM\333\15.DAT
    //  NA: 55679 - ROM\333\16.DAT
    packet.MesNumTitle       = title;                                   // String index. (String table 26.)
    packet.MesNumDescription = description > 18 ? description - 19 : 0; // Same as 0xA8. Client adds 19 to this value.
}
