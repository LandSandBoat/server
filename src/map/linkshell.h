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

#ifndef _CLINKSHELL_H
#define _CLINKSHELL_H

#include "common/cbasetypes.h"
#include "common/mmo.h"

#include <vector>

class CBasicPacket;
class CCharEntity;
class CItemLinkshell;

class CLinkshell
{
public:
    CLinkshell(uint32 id);

    uint32 getID() const;
    uint16 getColor() const;
    uint8  getPostRights();

    void setColor(uint16 color);
    void setPostRights(uint8 postrights);

    const std::string& getName();
    void               setName(const std::string& name);
    void               setMessage(const std::string& message, const std::string& poster);

    void AddMember(CCharEntity* PChar, int8 type, uint8 lsNum);
    bool DelMember(CCharEntity* PChar);

    void BreakLinkshell();
    void RemoveMemberByName(const std::string& MemberName, uint8 kickerRank, bool breakLinkshell = false);
    void ChangeMemberRank(const std::string& MemberName, uint8 toSack);

    void PushPacket(uint32 senderID, const std::unique_ptr<CBasicPacket>& packet);
    void PushLinkshellMessage(CCharEntity* PChar, bool ls1);

    std::vector<CCharEntity*> members;
    uint8                     m_postRights;

private:
    uint32 m_id;
    uint16 m_color;

    std::string m_name;
};

namespace linkshell
{
    CLinkshell* LoadLinkshell(uint32 id);
    void        UnloadLinkshell(uint32 id);

    bool AddOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell, uint8 lsNum);
    bool DelOnlineMember(CCharEntity* PChar, CItemLinkshell* PItemLinkshell);

    uint32      RegisterNewLinkshell(const std::string& name, uint16 color);
    CLinkshell* GetLinkshell(uint32 id);
}; // namespace linkshell

#endif
