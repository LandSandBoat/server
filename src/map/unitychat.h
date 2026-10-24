/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

class CBasicPacket;
class CCharEntity;

class CUnityChat
{
public:
    CUnityChat(uint32 leader);

    auto getLeader() const -> uint32;

    void AddMember(CCharEntity* PChar);
    auto DelMember(CCharEntity* PChar) -> bool;

    void PushPacket(uint32 senderID, const std::unique_ptr<CBasicPacket>& packet);

    std::vector<CCharEntity*> members;

private:
    uint32 m_leader;
};

namespace unitychat
{

auto LoadUnityChat(uint32 leader) -> CUnityChat*;
void UnloadUnityChat(uint32 leader);

auto AddOnlineMember(CCharEntity* PChar, uint32 leader) -> bool;
auto DelOnlineMember(CCharEntity* PChar, uint32 leader) -> bool;

auto GetUnityChat(uint32 leader) -> CUnityChat*;

}; // namespace unitychat
