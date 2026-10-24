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

#include "unitychat.h"
#include "entities/char_entity.h"
#include "utils/jailutils.h"

CUnityChat::CUnityChat(uint32 leader)
: m_leader(leader)
{
}

auto CUnityChat::getLeader() const -> uint32
{
    return m_leader;
}

void CUnityChat::AddMember(CCharEntity* PChar)
{
    db::preparedStmt("UPDATE accounts_sessions SET unitychat = ? WHERE charid = ? LIMIT 1", this->getLeader(), PChar->id);
    PChar->PUnityChat = this;
    members.emplace_back(PChar);
}

auto CUnityChat::DelMember(CCharEntity* PChar) -> bool
{
    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (members.at(i) == PChar)
        {
            db::preparedStmt("UPDATE accounts_sessions SET unitychat = 0 WHERE charid = ? LIMIT 1", PChar->id);
            PChar->PUnityChat = nullptr;
            members.erase(members.begin() + i);
            break;
        }
    }
    return !members.empty();
}

void CUnityChat::PushPacket(uint32 senderID, const std::unique_ptr<CBasicPacket>& packet)
{
    for (auto& member : members)
    {
        if (member->id != senderID && member->status != xi::Status::Disappear && !jailutils::InPrison(member))
        {
            member->pushPacket(packet->copy());
        }
    }
}

namespace unitychat
{

std::map<uint32, std::unique_ptr<CUnityChat>> UnityChatList;

auto LoadUnityChat(uint32 leader) -> CUnityChat*
{
    auto PUnity           = std::make_unique<CUnityChat>(leader);
    UnityChatList[leader] = std::move(PUnity);
    return UnityChatList[leader].get();
}

void UnloadUnityChat(uint32 leader)
{
    if (auto PUnity = UnityChatList.find(leader); PUnity != UnityChatList.end())
    {
        UnityChatList.erase(leader);
    }
}

auto AddOnlineMember(CCharEntity* PChar, uint32 leader) -> bool
{
    if (PChar == nullptr)
    {
        ShowWarning("PChar is null.");
        return false;
    }

    CUnityChat* PUnity = nullptr;
    if (auto UnityChatListUnity = UnityChatList.find(leader); UnityChatListUnity != UnityChatList.end())
    {
        PUnity = UnityChatListUnity->second.get();
    }
    else if (leader != 0)
    {
        PUnity = LoadUnityChat(leader);
    }
    if (PUnity)
    {
        PUnity->AddMember(PChar);
    }
    return false;
}

auto DelOnlineMember(CCharEntity* PChar, uint32 leader) -> bool
{
    if (PChar == nullptr)
    {
        ShowWarning("PChar is null.");
        return false;
    }

    try
    {
        CUnityChat* PUnityChat = UnityChatList.at(leader).get();
        if (!PUnityChat->DelMember(PChar))
        {
            UnityChatList.erase(leader);
        }
    }
    catch (std::out_of_range& exception)
    {
        ShowError("unitychat::DelOnlineMember caught exception: %s", exception.what());
    }
    return false;
}

auto GetUnityChat(uint32 leader) -> CUnityChat*
{
    if (auto PUnityChat = UnityChatList.find(leader); PUnityChat != UnityChatList.end())
    {
        return PUnityChat->second.get();
    }
    else
    {
        return nullptr;
    }
}

}; // namespace unitychat
