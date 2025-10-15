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

#include "0x0df_group_attr.h"

#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "monstrosity.h"

GP_SERV_COMMAND_GROUP_ATTR::GP_SERV_COMMAND_GROUP_ATTR(CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.UniqueNo = PChar->id;
    packet.Hp       = PChar->health.hp;
    packet.Mp       = PChar->health.mp;
    packet.Tp       = PChar->health.tp;
    packet.ActIndex = PChar->targid;
    packet.Hpp      = PChar->GetHPP();
    packet.Mpp      = PChar->GetMPP();

    if (PChar->m_PMonstrosity != nullptr)
    {
        packet.MonstrosityNameId = monstrosity::GetPackedMonstrosityName(PChar);
    }

    if (!PChar->isAnon())
    {
        packet.mjob_no         = PChar->GetMJob();
        packet.mjob_lv         = PChar->GetMLevel();
        packet.sjob_no         = PChar->GetSJob();
        packet.sjob_lv         = PChar->GetSLevel();
        packet.masterjob_lv    = 0;
        packet.masterjob_flags = 0;
    }
}

GP_SERV_COMMAND_GROUP_ATTR::GP_SERV_COMMAND_GROUP_ATTR(CTrustEntity* PTrust)
{
    auto& packet = this->data();

    packet.UniqueNo = PTrust->id;
    packet.Hp       = PTrust->health.hp;
    packet.Mp       = PTrust->health.mp;
    packet.Tp       = PTrust->health.tp;
    packet.ActIndex = PTrust->targid;
    packet.Hpp      = PTrust->GetHPP();
    packet.Mpp      = PTrust->GetMPP();
    packet.mjob_no  = PTrust->GetMJob();
    packet.mjob_lv  = PTrust->GetMLevel();
    packet.sjob_no  = PTrust->GetSJob();
    packet.sjob_lv  = PTrust->GetSLevel();
}
