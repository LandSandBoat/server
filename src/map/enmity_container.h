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

#pragma once

#include "common/cbasetypes.h"

#include "common/types/flat_hash_map.h"

class CBattleEntity;
class CMobEntity;

struct EnmityObject_t
{
    CBattleEntity* PEnmityOwner;
    int32          CE; // Cumulative Enmity
    int32          VE; // Volatile Enmity
    bool           active;
};

using EnmityList_t = FlatHashMap<uint32, EnmityObject_t>;

class CEnmityContainer
{
    int32 EnmityCap;

public:
    CEnmityContainer(CMobEntity* holder);
    ~CEnmityContainer();

    auto GetHighestEnmity() -> CBattleEntity*; // Decays VE and gets target with highest enmity

    auto CalculateEnmityBonus(CBattleEntity* PEntity) -> float;
    void Clear(uint32 EntityID = 0);   // Removes Entries from list
    void LogoutReset(uint32 EntityID); // Sets entry to inactive
    void SetActive(uint32 EntityID, bool active);
    void AddBaseEnmity(CBattleEntity* PEntity);
    void UpdateEnmity(CBattleEntity* PEntity, int32 CE, int32 VE, bool withMaster = false, bool tameable = false, bool directAction = true);
    void UpdateEnmityFromDamage(CBattleEntity* PEntity, int32 Damage);
    void UpdateEnmityFromCure(CBattleEntity* PEntity, uint8 level, int32 CureAmount, int32 fixedCE = 0, int32 fixedVE = 0);
    void UpdateEnmityFromAttack(CBattleEntity* PEntity, int32 Damage);
    auto HasID(uint32 ID) -> bool;                                                                 // true if ID is in the container with non-zero enmity level
    void LowerEnmityByPercent(CBattleEntity* PEntity, uint8 percent, CBattleEntity* HateReceiver); // lower % of hate or transfer it
    auto GetCE(CBattleEntity* PEntity) const -> int32;
    auto GetVE(CBattleEntity* PEntity) const -> int32;
    void SetCE(CBattleEntity* PEntity, int32 amount);
    void SetVE(CBattleEntity* PEntity, int32 amount);
    void DecayEnmity();
    auto IsWithinEnmityRange(CBattleEntity* PEntity) const -> bool;
    auto GetEnmityList() -> EnmityList_t*;
    auto IsTameable() const -> bool;
    void UpdateEnmityFromCover(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PCoverAbilityUser);

private:
    auto IgnorePets(CBattleEntity* PEntity) const -> bool;

    EnmityList_t m_EnmityList;
    bool         m_tameable{ true };
    CMobEntity*  m_EnmityHolder; // usually a monster
};
