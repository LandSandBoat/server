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

#ifndef _CDATALOADER_H_
#define _CDATALOADER_H_

#include "common/cbasetypes.h"

#include <list>
#include <stdio.h>
#include <string.h>
#include <vector>

struct search_req;

struct ahItem
{
    uint16 ItemID;
    uint32 SingleAmount;
    uint32 StackAmount;
    uint16 Category;
};

struct ahHistory
{
    uint32      Price;
    uint32      Data;
    std::string Name1;
    std::string Name2;
};

struct SearchEntity
{
    std::string name           = {};
    uint32      id             = 0;
    uint8       mjob           = 0;
    uint8       mlvl           = 0;
    uint8       sjob           = 0;
    uint8       slvl           = 0;
    uint8       nation         = 0;
    uint8       rank           = 0;
    uint8       race           = 0;
    uint16      zone           = 0;
    uint16      prevzone       = 0;
    uint16      flags1         = 0;
    uint32      flags2         = 0;
    uint32      linkshellid1   = 0;
    uint32      linkshellid2   = 0;
    uint8       linkshellrank1 = 0;
    uint8       linkshellrank2 = 0;
    bool        mentor         = false;
    uint8       seacom_type    = 0;
    uint8       languages      = 0;
    bool        gmHidden       = false;
    bool        disconnecting  = false;
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CDataLoader
{
public:
    CDataLoader();
    ~CDataLoader();

    uint32 GetPlayersCount(const search_req& sr);

    std::vector<ahHistory*>  GetAHItemHistory(uint16 ItemID, bool stack);
    std::list<SearchEntity*> GetPartyList(uint32 PartyID, uint32 AllianceID);
    std::list<SearchEntity*> GetLinkshellList(uint32 LinkshellID);
    std::list<SearchEntity*> GetPlayersList(search_req sr, int* count);
    std::string              GetSearchComment(uint32 playerId);
    std::vector<ahItem*>     GetAHItemsToCategory(uint8 ahCategoryID, const std::string& orderByString);
    ahItem                   GetAHItemFromItemID(uint16 ItemID);
    void                     ExpireAHItems(uint16 expireAgeInDays);
};

#endif
