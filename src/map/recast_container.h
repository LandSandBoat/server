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
#include "common/timer.h"
#include "data/enums/recast.h"
#include "data/enums/recast_type.h"
#include "enums/loot_recast.h"

#include <vector>

struct Recast_t
{
    xi::Recast        ID;
    timer::time_point TimeStamp;
    timer::duration   RecastTime;
    timer::duration   chargeTime;
    uint8             maxCharges;
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CBattleEntity;

typedef std::vector<Recast_t> RecastList_t;

class CRecastContainer
{
public:
    virtual void Check();

    virtual void Del(xi::RecastType type);
    virtual void Del(xi::RecastType type, xi::Recast id);
    virtual void DeleteByIndex(xi::RecastType type, uint8 index);
    auto         Has(xi::RecastType type, xi::Recast id) -> bool;
    auto         HasLootRecast(LootRecastID id) -> bool;
    auto         HasRecast(xi::RecastType type, xi::Recast id, timer::duration recast) -> bool;
    virtual void Add(xi::RecastType type, xi::Recast id, timer::duration duration, timer::duration chargeTime = 0s, uint8 maxCharges = 0);
    void         AddLootRecast(LootRecastID id, timer::duration duration);
    auto         Load(xi::RecastType type, xi::Recast id, timer::duration duration, timer::duration chargeTime = 0s, uint8 maxCharges = 0) -> Recast_t*;
    virtual void ResetAbilities();

    virtual void ChangeJob()
    {
    }

    virtual auto GetRecastList(xi::RecastType type) -> RecastList_t*;
    auto         GetRecast(xi::RecastType type, xi::Recast id) -> Recast_t*;
    auto         GetLootRecast(LootRecastID id) -> Recast_t*;

    CRecastContainer(CBattleEntity* PChar);

    virtual ~CRecastContainer()
    {
    }

protected:
    RecastList_t RecastMagicList;
    RecastList_t RecastAbilityList;

private:
    CBattleEntity* m_PEntity;
};
