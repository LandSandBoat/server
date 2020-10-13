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

#ifndef _CENMITYCONTAINER_H
#define _CENMITYCONTAINER_H

#include "../common/cbasetypes.h"
#include <unordered_map>

class CBattleEntity;
class CMobEntity;
class CCharEntity;

struct EnmityObject_t
{
    CBattleEntity* PEnmityOwner;
    int32 CE;                       // Cumulative Enmity
    int32 VE;                       // Volatile Enmity
    bool active;
    int16 maxTH;                    // Maximum Treasure Hunter level of this Enmity Owner
};

typedef std::unordered_map<uint16,EnmityObject_t> EnmityList_t;

constexpr int32 EnmityCap = 30000;

class CEnmityContainer
{
public:
    CEnmityContainer(CMobEntity* holder);
   ~CEnmityContainer();

    CBattleEntity* GetHighestEnmity();          // Decays VE and gets target with highest enmity

    float   CalculateEnmityBonus(CBattleEntity* PEntity);
    void    Clear(uint32 EntityID = 0);         // Removes Entries from list
    void    LogoutReset(uint32 EntityID);       // Sets entry to inactive
    void    AddBaseEnmity(CBattleEntity* PEntity);
    void    UpdateEnmity(CBattleEntity* PEntity, int32 CE, int32 VE, bool withMaster = false, bool tameable = false);
    void    UpdateEnmityFromDamage(CBattleEntity* PEntity, int32 Damage);
    void    UpdateEnmityFromCure(CBattleEntity* PEntity, uint8 level, int32 CureAmount, bool isCureV);
    void    UpdateEnmityFromAttack(CBattleEntity* PEntity, int32 Damage);
    bool    HasID(uint32 ID); //true if ID is in the container with non-zero enmity level
    void    LowerEnmityByPercent(CBattleEntity* PEntity, uint8 percent, CBattleEntity* HateReceiver); // lower % of hate or transfer it
    int32   GetCE(CBattleEntity* PEntity) const;
    int32   GetVE(CBattleEntity* PEntity) const;
    void    SetCE(CBattleEntity* PEntity, const int32 amount);
    void    SetVE(CBattleEntity* PEntity, const int32 amount);
    void    DecayEnmity();
    bool    IsWithinEnmityRange(CBattleEntity* PEntity) const;
    int16   GetHighestTH() const;
    EnmityList_t* GetEnmityList();
    bool    IsTameable();
    void    UpdateEnmityFromCover(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PCoverAbilityUser);

private:
    EnmityList_t    m_EnmityList;
    bool m_tameable{true};
    CMobEntity*  m_EnmityHolder; //usually a monster
};

#endif
