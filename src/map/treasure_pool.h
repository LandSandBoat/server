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

#ifndef _CTREASUREPOOL_H
#define _CTREASUREPOOL_H

#include "common/cbasetypes.h"

#include <vector>

enum TREASUREPOOLTYPE
{
    TREASUREPOOL_SOLO     = 1,
    TREASUREPOOL_PARTY    = 6,
    TREASUREPOOL_ALLIANCE = 18,
    TREASUREPOOL_ZONE     = 128
};

#define TREASUREPOOL_SIZE 10

// characters get a new TreasurePool when moving between zones
class CCharEntity;
class CMobEntity;

struct LotInfo
{
    uint16       lot;
    CCharEntity* member;

    LotInfo()
    : lot(0)
    , member(nullptr)
    {
    }
};

struct TreasurePoolItem
{
    uint16     ID;
    uint8      SlotID;
    time_point TimeStamp;

    std::vector<LotInfo> Lotters;

    TreasurePoolItem()
    : ID(0)
    , SlotID(0)
    {
    }
};

class CTreasurePool
{
public:
    CTreasurePool(TREASUREPOOLTYPE PoolType);

    TREASUREPOOLTYPE GetPoolType();

    uint8 AddItem(uint16 ItemID, CBaseEntity*);

    void LotItem(uint8 SlotID, uint16 Lot);
    void LotItem(CCharEntity* PChar, uint8 SlotID, uint16 Lot);
    void PassItem(CCharEntity* PChar, uint8 SlotID);
    bool HasLottedItem(CCharEntity* PChar, uint8 SlotID);
    bool HasPassedItem(CCharEntity* PChar, uint8 SlotID);
    void AddMember(CCharEntity* PChar);
    void DelMember(CCharEntity* PChar);
    void UpdatePool(CCharEntity* PChar);

    void CheckItems(time_point);

    void TreasureWon(CCharEntity* winner, uint8 SlotID);
    void TreasureError(CCharEntity* winner, uint8 SlotID);
    void TreasureLost(uint8 SlotID);

    bool CanAddSeal();

private:
    time_point m_Tick;
    uint8      m_count;

    TREASUREPOOLTYPE m_TreasurePoolType;

    void CheckTreasureItem(time_point tick, uint8 SlotID);

    TreasurePoolItem m_PoolItems[TREASUREPOOL_SIZE];

    std::vector<CCharEntity*> members;
};

#endif
