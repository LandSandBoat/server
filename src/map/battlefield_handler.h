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

#ifndef _CBATTLEFIELDHANDLER_H
#define _CBATTLEFIELDHANDLER_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include <map>
#include <memory>
#include <vector>

class CBattlefield;
class CCharEntity;
class CBaseEntity;
class CMobEntity;
class CZone;

class CBattlefieldHandler
{
public:
    CBattlefieldHandler(CZone* PZone);
    void          HandleBattlefields(time_point tick); // called every tick to handle win/lose conditions, locking the bcnm, etc
    uint8         LoadBattlefield(CCharEntity* PChar, uint16 battlefieldID, uint8 area); // attempts to load battlefield, returns BATTLEFIELD_RETURN_CODE
    CBattlefield* GetBattlefield(CBaseEntity* PEntity, bool checkRegistered = false);    // return pointer to battlefield if exists
    CBattlefield* GetBattlefieldByArea(uint8 area) const;
    CBattlefield* GetBattlefieldByInitiator(uint32 charID);
    uint8         RegisterBattlefield(CCharEntity* PChar, uint16 battlefieldID, uint8 area,
                                      uint32 initiator); // attempts to register or load battlefield, returns BATTLEFIELD_RETURN_CODE
    bool          RemoveFromBattlefield(CBaseEntity* PEntity, CBattlefield* PBattlefield = nullptr, uint8 leavecode = 3);
    bool          IsRegistered(CCharEntity* PChar);
    bool          IsEntered(CCharEntity* PChar);
    bool          ReachedMaxCapacity(int battlefieldId = -1) const;

private:
    CZone*                       m_PZone;
    uint8                        m_MaxBattlefields; // usually 3 except dynamis, einherjar, besieged, ...
    std::map<int, CBattlefield*> m_Battlefields;    // area
    std::map<uint32, uint8>      m_ReservedAreas;   // <charid, area>
};

#endif
