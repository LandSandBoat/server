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

#include "base.h"

struct scoreboard_data_t
{
    int32_t  MarchlandScore;
    int32_t  StrongholdScore;
    uint32_t MarchlandProgress;
    uint32_t MarchlandProgressMax;
    uint32_t StrongholdProgress;
    uint32_t StrongholdProgressMax;
    uint32_t MarchlandNameOverride;
    uint32_t StrongholdNameOverride;
    uint8_t  padding[96];
};

struct progressbar_row_t
{
    uint32_t Progress;
    int8_t   Name[16];
};

struct progressbar_data_t
{
    progressbar_row_t Rows[6];
    uint32_t          unused;
};

enum OBJECTIVEUTILITY_TYPE : uint8
{
    OBJECTIVEUTILITY_COUNTDOWN = 0x01,
    OBJECTIVEUTILITY_PROGRESS  = 0x02,
    OBJECTIVEUTILITY_HELP      = 0x04,
    OBJECTIVEUTILITY_FENCE     = 0x08
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0075
// This packet is sent by the server to inform the client of extra data used for certain battlefield content.
class GP_SERV_COMMAND_BATTLEFIELD final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_BATTLEFIELD, GP_SERV_COMMAND_BATTLEFIELD>
{
public:
    struct PacketData
    {
        uint32_t Mode;          // PS2: (New; did not exist.)
        uint32_t Timestamp;     // PS2: (New; did not exist.)
        uint32_t Duration;      // PS2: (New; did not exist.)
        uint32_t DurationWarn;  // PS2: (New; did not exist.)
        int32_t  FenceX;        // PS2: (New; did not exist.)
        int32_t  FenceY;        // PS2: (New; did not exist.)
        uint32_t FenceRadius;   // PS2: (New; did not exist.)
        uint32_t FenceRotation; // PS2: (New; did not exist.)
        uint8_t  Flags;         // PS2: (New; did not exist.)
        uint8_t  FenceColor;    // PS2: (New; did not exist.)
        uint8_t  unknown26;     // PS2: (New; did not exist.)
        uint8_t  padding27;     // PS2: (New; did not exist.)
        union
        {
            uint8_t            Data[128];  // PS2: (New; did not exist.)
            scoreboard_data_t  Scoreboard; // PS2: (New; did not exist.)
            progressbar_data_t Progress;   // PS2: (New; did not exist.)
        };
        uint16_t MesNumTitle;       // PS2: (New; did not exist.)
        uint16_t MesNumDescription; // PS2: (New; did not exist.)
    };

    GP_SERV_COMMAND_BATTLEFIELD() = default;
    GP_SERV_COMMAND_BATTLEFIELD(uint32 duration, uint32 warning = 0);

    void addCountdown(uint32 duration, uint32 warning);
    void addBars(std::vector<std::pair<std::string, uint32>>&& bars);
    void addScoreboard(const std::pair<int32, int32>& score, const std::vector<uint32>& data);
    void addFence(float x, float z, float radius, float render, bool blue = false);
    void addHelpText(uint16 title, uint16 description);
};
