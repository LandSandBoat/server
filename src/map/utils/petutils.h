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

#ifndef _IPETUTILS_H
#define _IPETUTILS_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

enum PETID
{
    PETID_FIRESPIRIT         = 0,
    PETID_ICESPIRIT          = 1,
    PETID_AIRSPIRIT          = 2,
    PETID_EARTHSPIRIT        = 3,
    PETID_THUNDERSPIRIT      = 4,
    PETID_WATERSPIRIT        = 5,
    PETID_LIGHTSPIRIT        = 6,
    PETID_DARKSPIRIT         = 7,
    PETID_CARBUNCLE          = 8,
    PETID_FENRIR             = 9,
    PETID_IFRIT              = 10,
    PETID_TITAN              = 11,
    PETID_LEVIATHAN          = 12,
    PETID_GARUDA             = 13,
    PETID_SHIVA              = 14,
    PETID_RAMUH              = 15,
    PETID_DIABOLOS           = 16,
    PETID_ALEXANDER          = 17,
    PETID_ODIN               = 18,
    PETID_ATOMOS             = 19,
    PETID_CAIT_SITH          = 20,
    PETID_WYVERN             = 48,
    PETID_HARLEQUINFRAME     = 69,
    PETID_VALOREDGEFRAME     = 70,
    PETID_SHARPSHOTFRAME     = 71,
    PETID_STORMWAKERFRAME    = 72,
    PETID_ADVENTURING_FELLOW = 73,
    PETID_CHOCOBO            = 74,
    PETID_LUOPAN             = 75,
    MAX_PETID                = 76,
};

class CBattleEntity;
class CPetEntity;

namespace petutils
{
    void LoadPetList();
    void FreePetList();

    void SpawnPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);
    void SpawnMobPet(CBattleEntity* PMaster, uint32 PetID);
    void DetachPet(CBattleEntity* PMaster);
    void DespawnPet(CBattleEntity* PMaster);
    void AttackTarget(CBattleEntity* PMaster, CBattleEntity* PTarget);
    void RetreatToMaster(CBattleEntity* PMaster);
    int16 PerpetuationCost(uint32 id, uint8 level);
    void Familiar(CBattleEntity* PPet);
    void LoadPet(CBattleEntity* PMaster, uint32 PetID, bool spawningFromZone);
    void LoadWyvernStatistics(CBattleEntity* PMaster, CPetEntity* PPet, bool finalize);
    void FinalizePetStatistics(CBattleEntity* PMaster, CPetEntity* PPet);
    bool CheckPetModType(CBattleEntity* PPet, PetModType petmod);
};

#endif
