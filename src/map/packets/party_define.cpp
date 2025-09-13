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

#include "party_define.h"

#include "common/database.h"
#include "common/logging.h"
#include "map_engine.h"

#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "utils/zoneutils.h"

CPartyDefinePacket::CPartyDefinePacket(CParty* PParty, bool loadTrust)
{
    this->setType(0xC8);
    this->setSize(0xF8);

    if (PParty)
    {
        uint32 allianceid = 0;
        if (PParty->m_PAlliance)
        {
            allianceid = PParty->m_PAlliance->m_AllianceID;
        }

        uint8      i    = 0;
        const auto rset = db::preparedStmt("SELECT chars.charid, partyflag, pos_zone, pos_prevzone "
                                           "FROM accounts_parties "
                                           "LEFT JOIN chars ON accounts_parties.charid = chars.charid WHERE "
                                           "IF (allianceid <> 0, allianceid = ?, partyid = ?) "
                                           "ORDER BY partyflag & ?, timestamp",
                                           allianceid, PParty->GetPartyID(), PARTY_SECOND | PARTY_THIRD);
        FOR_DB_MULTIPLE_RESULTS(rset)
        {
            uint16 targid = 0;
            if (const auto* PChar = zoneutils::GetChar(rset->get<uint32>("charid")))
            {
                targid = PChar->targid;
            }

            const auto pos_zone        = rset->getOrDefault<uint16>("pos_zone", 0);
            ref<uint32>(12 * i + 0x08) = rset->get<uint32>("charid");
            ref<uint16>(12 * i + 0x0C) = targid;
            ref<uint16>(12 * i + 0x0E) = rset->get<uint32>("partyflag");
            ref<uint16>(12 * i + 0x10) = pos_zone ? pos_zone : rset->get<uint16>("pos_prevzone");
            i++;
        }

        if (loadTrust)
        {
            const auto* PLeader = static_cast<CCharEntity*>(PParty->GetLeader());
            if (PLeader != nullptr)
            {
                for (const auto* PTrust : PLeader->PTrusts)
                {
                    ref<uint32>(12 * i + (0x08)) = PTrust->id;
                    ref<uint16>(12 * i + (0x0C)) = PTrust->targid;
                    ref<uint16>(12 * i + (0x0E)) = 0;
                    ref<uint16>(12 * i + (0x10)) = PTrust->getZone();
                    i++;
                }
            }
        }
    }
}
