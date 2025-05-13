/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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
#include "common/ipc.h"
#include "common/party/base.h"

class IPCServer;

enum class PartyMemberType : uint8;

// Authoritative party class.
// World server makes the decisions and forwards updates to each map process.
class WorldParty : public PartyBase
{
    IPCServer* m_IpcServer;

public:
    WorldParty(const PartyFullUpdateMessage& message, IPCServer* ipcServer);
    WorldParty(uint32 _LeaderUniqueNo, IPCServer* ipcServer);

    bool setMemberZone(uint32 charId, uint16 zoneId);

    bool setLeader(const std::string& charName);
    bool setLeader(uint32_t UniqueNo);

    bool setQuartermaster(const std::string& charName);
    bool setQuartermaster(uint32_t UniqueNo);

    bool setSyncTarget(const std::string& charName);
    bool clearSyncTarget(std::optional<MsgStd> reason);
    bool setSyncTarget(uint32_t UniqueNo);

    bool addMember(uint32_t UniqueNo, PartyMemberType type);

    bool removeMember(const std::string& charName);
    bool removeMember(uint32 UniqueNo);
    void clearTrusts();
    bool disband();
};