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

#ifndef _CCAMPAIGNPACKET_H
#define _CCAMPAIGNPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"
#include "campaign_system.h"

class CCharEntity;

class CCampaignPacket : public CBasicPacket
{
public:
    CCampaignPacket(CCharEntity* PChar, CampaignState const& state, uint8 number);

private:
    void SetRegions(std::vector<CampaignRegion> areas, int start = 0);
    void SetNations(std::vector<CampaignNation> nations);
};

#endif
