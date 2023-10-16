/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "common/cbasetypes.h"

#include "packets/basic.h"

#include "entities/battleentity.h"

#include <array>

class CCharEntity;

// ===
// See scripts/globals/monstrosity.lua for a general overview of how Monstrosity works and is designed.
// ===
namespace monstrosity
{
    struct MonstrosityData_t
    {
    public:
        MonstrosityData_t();

        uint8  MonstrosityId;
        uint16 Species;
        uint16 Flags;
        uint16 Look;
        uint8  Size;

        uint8 NamePrefix1;
        uint8 NamePrefix2;

        JOBTYPE MainJob;
        JOBTYPE SubJob;
        uint32  CurrentExp;

        std::array<uint16, 12> EquippedInstincts{ 0 };
        std::array<uint8, 128> levels{ 0 };
        std::array<uint8, 64>  instincts{ 0 };
        std::array<uint8, 32>  variants{ 0 };

        bool Belligerency;

        position_t EntryPos{};
        uint16     EntryZoneId;
        uint8      EntryMainJob;
        uint8      EntrySubJob;
    };

    void LoadStaticData();

    void ReadMonstrosityData(CCharEntity* PChar);
    void WriteMonstrosityData(CCharEntity* PChar);

    void   TryPopulateMonstrosityData(CCharEntity* PChar);
    void   HandleZoneIn(CCharEntity* PChar);
    uint32 GetPackedMonstrosityName(CCharEntity* PChar);
    void   SendFullMonstrosityUpdate(CCharEntity* PChar);

    void HandleMonsterSkillActionPacket(CCharEntity* PChar, CBasicPacket& data);
    void HandleEquipChangePacket(CCharEntity* PChar, CBasicPacket& data);

    void SetLevel(CCharEntity* PChar, uint8 id, uint8 level);

    void HandleDeathMenu(CCharEntity* PChar, uint8 type);

    bool IsInstinctUnlocked(CCharEntity* PChar, uint16 instinct);
    bool IsVariantUnlocked(CCharEntity* PChar, uint8 variant);

    void SetBelligerencyFlag(CCharEntity* PChar, bool flag);

    // Debug
    void MaxAllLevels(CCharEntity* PChar);
    void UnlockAllInstincts(CCharEntity* PChar);
    void UnlockAllVariants(CCharEntity* PChar);
} // namespace monstrosity
