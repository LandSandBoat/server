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

struct BattlefieldRegistration
{
    uint16               id         = -1;
    uint8                area       = 1;
    uint32               initiator  = 0;
    uint32               maxPlayers = 0;
    uint32               levelCap   = 0;
    uint32               rules      = 0;
    std::chrono::seconds timeLimit  = std::chrono::seconds(0);
    bool                 isMission  = false;
    bool                 showTimer  = true;
};

class CBattlefieldHandler
{
public:
    CBattlefieldHandler(CZone* PZone);
    void          HandleBattlefields(time_point tick);                                              // called every tick to handle win/lose conditions, locking the bcnm, etc
    uint8         LoadBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration); // attempts to load battlefield, returns BATTLEFIELD_RETURN_CODE
    CBattlefield* GetBattlefield(CBaseEntity* PEntity, bool checkRegistered = false);               // return pointer to battlefield if exists
    CBattlefield* GetBattlefieldByArea(uint8 area) const;
    CBattlefield* GetBattlefieldByInitiator(uint32 charID);
    uint8         RegisterBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration); // attempts to register or load battlefield, returns BATTLEFIELD_RETURN_CODE
    bool          RemoveFromBattlefield(CBaseEntity* PEntity, CBattlefield* PBattlefield = nullptr, uint8 leavecode = 3);
    bool          IsRegistered(CCharEntity* PChar);
    bool          IsEntered(CCharEntity* PChar);
    bool          ReachedMaxCapacity(int battlefieldId = -1) const;
    uint8         MaxBattlefieldAreas() const;
    void          addOrphanedPlayer(CCharEntity* PChar);

private:
    CZone*                       m_PZone;
    uint8                        m_MaxBattlefields; // usually 3 except dynamis, einherjar, besieged, ...
    std::map<int, CBattlefield*> m_Battlefields;    // area
    std::map<uint32, uint8>      m_ReservedAreas;   // <charid, area>

    // Players that need to be kicked from whatever battlefield they were in
    std::vector<std::pair<uint32, time_point>> m_orphanedPlayers;
};

#endif
