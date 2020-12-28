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

#include "../common/cbasetypes.h"

#include <list>
#include <stdio.h>
#include <string.h>
#include <vector>

struct Sql_t;
struct search_req;

struct ahItem
{
    uint16 ItemID;
    uint32 SingleAmount;
    uint32 StackAmount;
};

struct ahHistory
{
    uint32 Price;
    uint32 Data;
    uint8  Name1[15];
    uint8  Name2[15];
};

struct SearchEntity
{
    uint8  name[16];
    uint32 id;
    uint8  mjob;
    uint8  mlvl;
    uint8  sjob;
    uint8  slvl;
    uint8  nation;
    uint8  rank;
    uint8  race;
    uint16 zone;
    uint16 prevzone;
    uint16 flags1;
    uint32 flags2;
    uint32 comment;
    uint32 linkshellid1;
    uint32 linkshellid2;
    uint8  linkshellrank1;
    uint8  linkshellrank2;
    uint16 languages;
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

    std::vector<ahHistory*>  GetAHItemHystory(uint16 ItemID, bool stack);
    std::list<SearchEntity*> GetPartyList(uint16 PartyID, uint16 AllianceID);
    std::list<SearchEntity*> GetLinkshellList(uint32 LinkshellID);
    std::list<SearchEntity*> GetPlayersList(search_req sr, int* count);
    std::vector<ahItem*>     GetAHItemsToCategory(uint8 AHCategoryID, int8* OrderByString);
    void                     ExpireAHItems();

private:
    Sql_t* SqlHandle;
};

#endif
