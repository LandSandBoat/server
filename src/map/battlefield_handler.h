/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTItem or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#pragma once

#include "common/cbasetypes.h"
#include "common/macros.h"
#include "common/timer.h"

#include <map>
#include <memory>

class CBattlefield;
class CCharEntity;
class CBaseEntity;
class CZone;

struct BattlefieldRegistration
{
    uint16          id         = -1;
    uint8           area       = 1;
    uint32          initiator  = 0;
    uint32          maxPlayers = 0;
    uint32          levelCap   = 0;
    uint32          rules      = 0;
    timer::duration timeLimit  = 0s;
    bool            isMission  = false;
    bool            showTimer  = true;
};

class CBattlefieldHandler
{
public:
    CBattlefieldHandler(CZone* PZone);
    ~CBattlefieldHandler();

    DISALLOW_COPY_AND_MOVE(CBattlefieldHandler);
    void HandleBattlefields(timer::time_point tick);                                                // called every tick to handle win/lose conditions, locking the bcnm, etc
    auto LoadBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration) -> uint8; // attempts to load battlefield, returns BATTLEFIELD_RETURN_CODE
    auto GetBattlefield(CBaseEntity* PEntity, bool checkRegistered = false) -> CBattlefield*;       // return pointer to battlefield if exists
    auto GetBattlefieldByArea(uint8 area) const -> CBattlefield*;
    auto GetBattlefieldByInitiator(uint32 charID) -> CBattlefield*;
    auto GetRegisteredBattlefield(CCharEntity* PChar) -> CBattlefield*;                                 // registration only, the player may have lost clearance since
    auto RegisterBattlefield(CCharEntity* PChar, const BattlefieldRegistration& registration) -> uint8; // attempts to register or load battlefield, returns BATTLEFIELD_RETURN_CODE
    auto RemoveFromBattlefield(CBaseEntity* PEntity, CBattlefield* PBattlefield = nullptr, uint8 leavecode = 3) -> bool;
    auto IsRegistered(CCharEntity* PChar) -> bool;
    auto ReachedMaxCapacity(int battlefieldId = -1) const -> bool;
    auto MaxBattlefieldAreas() const -> uint8;
    void addOrphanedPlayer(CCharEntity* PChar);
    void RestoreClearance(CCharEntity* PChar);

private:
    void RemoveOtherRegistrations(CCharEntity* PChar, const CBattlefield* PKeep);

    CZone*                                       m_PZone;
    uint8                                        m_MaxBattlefields; // usually 3 except dynamis, einherjar, besieged, ...
    std::map<int, std::unique_ptr<CBattlefield>> m_Battlefields;    // area
    std::map<uint32, uint8>                      m_ReservedAreas;   // <charid, area>

    // Players that need to be kicked from whatever battlefield they were in
    std::vector<std::pair<uint32, timer::time_point>> m_orphanedPlayers;
};
