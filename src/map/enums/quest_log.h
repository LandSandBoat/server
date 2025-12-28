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

// Indices as used in CCharEntity::m_questLog
enum class QuestLog : uint8_t
{
    Sandoria   = 0,
    Bastok     = 1,
    Windurst   = 2,
    Jeuno      = 3,
    OtherAreas = 4,
    Outlands   = 5,
    AhtUrghan  = 6,
    CrystalWar = 7,
    Abyssea    = 8,
    Adoulin    = 9,
    Coalition  = 10,
};

// Client-side MISSION packet 'Port' values for completed quests.
enum class QuestComplete : uint16_t
{
    Sandoria   = 0x0090,
    Bastok     = 0x0098,
    Windurst   = 0x00A0,
    Jeuno      = 0x00A8,
    OtherAreas = 0x00B0,
    Outlands   = 0x00B8,
    AhtUrghan  = 0x00C0,
    CrystalWar = 0x00C8,
    Abyssea    = 0x00E8,
    Adoulin    = 0x00F8,
    Coalition  = 0x0108,
};

// Client-side MISSION packet 'Port' values for quests in progress.
enum class QuestOffer : uint16_t
{
    Sandoria   = 0x0050,
    Bastok     = 0x0058,
    Windurst   = 0x0060,
    Jeuno      = 0x0068,
    OtherAreas = 0x0070,
    Outlands   = 0x0078,
    AhtUrghan  = 0x0080,
    CrystalWar = 0x0088,
    Abyssea    = 0x00E0,
    Adoulin    = 0x00F0,
    Coalition  = 0x0100,
};
