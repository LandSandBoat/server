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

enum class GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL : uint8_t;
class CBasicPacket;
class CCharEntity;
class CItemLinkshell;

enum class LinkshellSlot : uint8
{
    LS1 = 0,
    LS2 = 1,
};

class CLinkshell
{
public:
    CLinkshell(uint32 id);

    auto getID() const -> uint32;
    auto getColor() const -> uint16;
    auto getPostRights() const -> GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL;

    void setColor(uint16 color);
    void setPostRights(GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL writeLevel);

    auto getName() -> const std::string&;
    void setName(const std::string& name);
    void setMessage(const std::string& message, const std::string& poster);

    void AddMember(CCharEntity* PChar, int8 type, uint8 lsNum);
    auto DelMember(CCharEntity* PChar) -> bool;

    void BreakLinkshell();
    void RemoveMemberByName(const std::string& MemberName, uint8 requesterRank, bool breakLinkshell = false);
    void ChangeMemberRank(const std::string& MemberName, uint8 requesterRank, uint8 newRank);

    void PushPacket(uint32 senderID, const std::unique_ptr<CBasicPacket>& packet);
    void PushLinkshellMessage(CCharEntity* PChar, LinkshellSlot slot);

    std::vector<CCharEntity*>           members;
    GP_CLI_COMMAND_SET_LSMSG_WRITELEVEL m_postRights;

private:
    uint32 m_id;
    uint16 m_color;

    std::string m_name;
};

namespace linkshell
{

auto LoadLinkshell(uint32 id) -> CLinkshell*;
void UnloadLinkshell(uint32 id);

auto AddOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell, uint8 lsNum) -> bool;
auto DelOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell) -> bool;

auto RegisterNewLinkshell(const std::string& name, uint16 color) -> uint32;
auto GetLinkshell(uint32 id) -> CLinkshell*;

}; // namespace linkshell
