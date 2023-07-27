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

#ifndef _CHARRECASTCONTAINER_H
#define _CHARRECASTCONTAINER_H

#include "common/cbasetypes.h"
#include "recast_container.h"

#include <vector>

class CCharEntity;

class CCharRecastContainer : public CRecastContainer
{
public:
    CCharRecastContainer(CCharEntity*);
    virtual ~CCharRecastContainer()
    {
    }
    virtual void          Check() override;
    virtual void          Add(RECASTTYPE type, uint16 id, uint32 duration, uint32 chargeTime, uint8 maxCharges) override;
    virtual void          Del(RECASTTYPE type) override;
    virtual void          Del(RECASTTYPE type, uint16 id) override;
    virtual void          DeleteByIndex(RECASTTYPE type, uint8 index) override;
    virtual void          ResetAbilities() override;
    virtual RecastList_t* GetRecastList(RECASTTYPE type) override;
    virtual void          ChangeJob() override;

protected:
    RecastList_t RecastItemList;
    RecastList_t RecastLootList;

private:
    CCharEntity* m_PChar;
};

#endif
