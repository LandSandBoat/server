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

#ifndef _RECASTCONTAINER_H
#define _RECASTCONTAINER_H

#include "common/cbasetypes.h"
#include "common/timer.h"
#include "enums/loot_recast.h"
#include "enums/recast.h"

#include <vector>

enum RECASTTYPE
{
    RECAST_ITEM    = 0,
    RECAST_MAGIC   = 1,
    RECAST_ABILITY = 2,
    RECAST_LOOT    = 3
};
#define MAX_RECASTTPE_SIZE 4

struct Recast_t
{
    Recast            ID;
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

    virtual void Del(RECASTTYPE type);
    virtual void Del(RECASTTYPE type, Recast id);
    virtual void DeleteByIndex(RECASTTYPE type, uint8 index);
    bool         Has(RECASTTYPE type, Recast id);
    bool         HasLootRecast(LootRecastID id);
    bool         HasRecast(RECASTTYPE type, Recast id, timer::duration recast);
    virtual void Add(RECASTTYPE type, Recast id, timer::duration duration, timer::duration chargeTime = 0s, uint8 maxCharges = 0);
    void         AddLootRecast(LootRecastID id, timer::duration duration);
    Recast_t*    Load(RECASTTYPE type, Recast id, timer::duration duration, timer::duration chargeTime = 0s, uint8 maxCharges = 0);
    virtual void ResetAbilities();
    virtual void ChangeJob()
    {
    }

    virtual RecastList_t* GetRecastList(RECASTTYPE type);
    Recast_t*             GetRecast(RECASTTYPE type, Recast id);
    Recast_t*             GetLootRecast(LootRecastID id);

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

#endif
