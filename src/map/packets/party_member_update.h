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

#include "common/party/base.h"
#include "basic.h"

#include <common/ipc_structs.h>

class CCharEntity;
class CTrustEntity;
class CAlliance;
class CCharParty;

class CPartyMemberUpdatePacket : public CBasicPacket
{
public:
    CPartyMemberUpdatePacket(CCharEntity* PSolo);
    CPartyMemberUpdatePacket(CTrustEntity* PTrust, uint8 MemberNumber);
    CPartyMemberUpdatePacket(const CCharParty& PParty, const PartyMember& PMember, const CCharEntity* PRecipient, uint8 MemberNumber);
};
