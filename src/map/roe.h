/*
 * roe.h
 *      Author: Kreidos | github.com/kreidos
 *
===========================================================================

  Copyright (c) 2020 Topaz Dev Teams

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

#ifndef SRC_MAP_ROE_H_
#define SRC_MAP_ROE_H_

#include <array>
#include <bitset>
#include <vector>

#include "../common/cbasetypes.h"
#include "ai/helpers/event_handler.h"
#include "packets/weather.h"

struct lua_State;

class CItemContainer;

class CBaseEntity;

enum ROE_EVENT
{
    ROE_MOBKILL = 1,
    ROE_WSKILL_USE = 2,
    ROE_LOOTITEM = 3,
    ROE_SYNTHSUCCESS = 4,
    ROE_DMGTAKEN = 5,
    ROE_DMGDEALT = 6,
    ROE_NONE // End of enum marker and OOB checkpost. Do not move or remove, place any new types above.
};

struct RoeSystemData
{
    std::bitset<4096> ImplementedRecords;
    std::bitset<4096> RepeatableRecords;
    std::array<uint32, 4096> NotifyThresholds;
};

struct RoeCheckHandler
{
    std::bitset<4096> bitmap;
};

extern std::array<RoeCheckHandler, ROE_NONE> RoeHandlers;

enum class RoeDatagramPayload
{
    mob,
    uinteger,
};

struct RoeDatagram
{
    RoeDatagramPayload type;
    std::string param;
    union data {
        uint32 uinteger;
        CMobEntity* mobEntity;
        CItem* item;
    } data;

    RoeDatagram(std::string param, uint32 id) : param{param}
    {
        this->type = RoeDatagramPayload::uinteger;
        this->data.uinteger = id;
    }
    RoeDatagram(std::string param, CMobEntity* PMob) : param{param}
    {
        this->type = RoeDatagramPayload::mob;
        this->data.mobEntity = PMob;
    }
};

typedef std::vector<RoeDatagram> RoeDatagramList;

namespace roeutils
{
extern RoeSystemData RoeCache;

void init();
int32 RegisterHandler(lua_State* L);
int32 ParseRecords(lua_State* L);

bool event(ROE_EVENT eventID, CCharEntity* PChar, RoeDatagramList payload);
bool event(ROE_EVENT eventID, CCharEntity* PChar, RoeDatagram payload);
bool event(ROE_EVENT eventID, CCharEntity* PChar);

void SetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID, bool newStatus);
bool GetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID);
bool AddEminenceRecord(CCharEntity* PChar, uint16 recordID);
bool DelEminenceRecord(CCharEntity* PChar, uint16 recordID);
bool HasEminenceRecord(CCharEntity* PChar, uint16 recordID);
bool SetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID, uint32 progress);
uint32 GetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID);

} /* namespace roe */

#endif /* SRC_MAP_ROE_H_ */
