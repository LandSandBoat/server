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

#pragma once

#include <common/cbasetypes.h>

#include <common/types/flag.h>

#include <array>
#include <string>
#include <vector>

class CCharEntity;

// Whether the character is leaving for good, as opposed to zoning or just being swept.
using IsLogout = xi::Flag<struct IsLogoutTag>;

struct CharPosition
{
    uint32 charid{};
    uint8  rotation{};
    float  x{};
    float  y{};
    float  z{};
    uint16 boundary{};
};

struct CharEquipSlot
{
    uint32 charid{};
    uint8  equipSlotId{};
    uint8  slotId{};
    uint8  containerId{};
};

struct CharAppearance
{
    uint32                charid{};
    std::array<uint16, 8> look{};       // head, body, hands, legs, feet, main, sub, ranged
    std::array<uint16, 8> styleItems{}; // same order as look
    bool                  styleLocked{};
};

struct PersistedEffect
{
    uint32 charid{};
    uint16 effectId{};
    uint16 icon{};
    uint16 power{};
    uint32 tick{};
    uint32 duration{};
    uint32 subId{};
    uint16 subPower{};
    uint16 tier{};
    uint32 flags{};
    uint32 timestamp{};
    uint16 sourceType{};
    uint32 sourceTypeParam{};
    uint32 originId{};
};

struct CharVarChange
{
    uint32      charid{};
    std::string name;
    int32       value{};
    uint32      expiry{};
};

struct PersistBatch
{
    std::vector<CharPosition> positions;

    std::vector<uint32>          replaceEffectsFor;
    std::vector<PersistedEffect> effectRows;

    std::vector<uint32>        replaceEquipFor;
    std::vector<CharEquipSlot> equipRows;

    std::vector<CharAppearance> appearances;

    std::vector<CharVarChange> charVars;

    // Add PC to current batch (main thread)
    void add(CCharEntity* PChar, IsLogout logout = IsLogout::No);

    // Write all pending changes (worker)
    void write();
};

namespace persist
{

// Write one character now, outside of the periodic sweep.
void flush(CCharEntity* PChar, IsLogout logout);

} // namespace persist
