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

#ifndef _CTREASUREPOOL_H
#define _CTREASUREPOOL_H

#include "common/cbasetypes.h"

#include <vector>

// Update xi.treasurePool accordingly when making changes
enum class TreasurePoolType : uint8
{
    Solo     = 1,
    Party    = 6,
    Alliance = 18,
    Zone     = 128
};

#define TREASUREPOOL_SIZE 10

// characters get a new TreasurePool when moving between zones
class CCharEntity;
class CBaseEntity;
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
    uint16            ID;
    uint8             SlotID;
    timer::time_point TimeStamp;

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
    CTreasurePool(TreasurePoolType PoolType);

    auto getPoolType() const -> TreasurePoolType;

    auto addItem(uint16 ItemID, CBaseEntity*) -> uint8;
    void lotItem(CCharEntity* PChar, uint8 SlotID, uint16 Lot);
    void passItem(CCharEntity* PChar, uint8 SlotID);
    bool hasLottedItem(CCharEntity* PChar, uint8 SlotID);
    bool hasPassedItem(CCharEntity* PChar, uint8 SlotID);
    auto getItems() const -> const std::array<TreasurePoolItem, TREASUREPOOL_SIZE>&;
    auto itemCount() const -> uint8;

    void addMember(CCharEntity* PChar);
    void delMember(CCharEntity* PChar);
    auto getMembers() const -> const std::vector<CCharEntity*>&;
    bool isMember(const CCharEntity* PChar);
    auto memberCount() const -> size_t;

    void updatePool(CCharEntity* PChar);
    void flush();

    void checkItems(timer::time_point);

    void treasureWon(CCharEntity* winner, uint8 SlotID);
    void treasureError(CCharEntity* winner, uint8 SlotID);
    void treasureLost(uint8 SlotID);

private:
    timer::time_point m_Tick;
    uint8             m_count;

    TreasurePoolType m_TreasurePoolType;

    void checkTreasureItem(timer::time_point tick, uint8 SlotID);

    std::array<TreasurePoolItem, TREASUREPOOL_SIZE> m_PoolItems;
    std::vector<CCharEntity*>                       m_Members;
};

#endif
