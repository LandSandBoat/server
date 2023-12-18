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

#include "common/utils.h"

#include <cstring>

#include "entities/charentity.h"
#include "map.h"
#include "message.h"
#include "unitychat.h"
#include "utils/jailutils.h"

CUnityChat::CUnityChat(uint32 leader)
: m_leader(leader)
{
}

uint32 CUnityChat::getLeader() const
{
    return m_leader;
}

void CUnityChat::AddMember(CCharEntity* PChar)
{
    _sql->Query("UPDATE accounts_sessions SET unitychat = %u WHERE charid = %u", this->getLeader(), PChar->id);
    PChar->PUnityChat = this;
    members.emplace_back(PChar);
}

bool CUnityChat::DelMember(CCharEntity* PChar)
{
    for (uint32 i = 0; i < members.size(); ++i)
    {
        if (members.at(i) == PChar)
        {
            _sql->Query("UPDATE accounts_sessions SET unitychat = 0 WHERE charid = %u", PChar->id);
            PChar->PUnityChat = nullptr;
            members.erase(members.begin() + i);
            break;
        }
    }
    return !members.empty();
}

void CUnityChat::PushPacket(uint32 senderID, CBasicPacket* packet)
{
    for (auto& member : members)
    {
        if (member->id != senderID && member->status != STATUS_TYPE::DISAPPEAR && !jailutils::InPrison(member))
        {
            CBasicPacket* newPacket = new CBasicPacket(*packet);
            member->pushPacket(newPacket);
        }
    }
    destroy(packet);
}

namespace unitychat
{
    std::map<uint32, std::unique_ptr<CUnityChat>> UnityChatList;

    CUnityChat* LoadUnityChat(uint32 leader)
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

    bool AddOnlineMember(CCharEntity* PChar, uint32 leader)
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

    bool DelOnlineMember(CCharEntity* PChar, uint32 leader)
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

    CUnityChat* GetUnityChat(uint32 leader)
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
