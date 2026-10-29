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
#include "common/macros.h"
#include "recast_container.h"

class CCharEntity;

class CCharRecastContainer : public CRecastContainer
{
public:
    CCharRecastContainer(CCharEntity*);

    ~CCharRecastContainer() override = default;

    DISALLOW_COPY_AND_MOVE(CCharRecastContainer);

    void Check() override;
    void Add(xi::RecastType type, xi::Recast id, timer::duration duration, timer::duration chargeTime, uint8 maxCharges) override;
    void Del(xi::RecastType type) override;
    void Del(xi::RecastType type, xi::Recast id) override;
    void DeleteByIndex(xi::RecastType type, uint8 index) override;
    void ResetAbilities() override;
    auto GetRecastList(xi::RecastType type) -> RecastList_t* override;
    void ChangeJob() override;

protected:
    RecastList_t RecastItemList;
    RecastList_t RecastLootList;

private:
    CCharEntity* m_PChar;
};
