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

#include "0x0c8_group_tbl.h"

#include "alliance.h"
#include "common/database.h"
#include "common/logging.h"
#include "map_engine.h"
#include "party.h"

#include "entities/charentity.h"
#include "entities/trustentity.h"
#include "enums/party_kind.h"
#include "utils/zoneutils.h"

GP_SERV_COMMAND_GROUP_TBL::GP_SERV_COMMAND_GROUP_TBL(CParty* PParty, const bool loadTrust)
{
    auto& packet = this->data();

    if (PParty)
    {
        packet.Kind = PParty->m_PAlliance ? PartyKind::Alliance : PartyKind::Party;

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

            const auto pos_zone   = rset->getOrDefault<uint16>("pos_zone", 0);
            const auto partyFlags = rset->get<uint32>("partyflag");

            packet.GroupTbl[i].UniqueNo          = rset->get<uint32>("charid");
            packet.GroupTbl[i].ActIndex          = targid;
            packet.GroupTbl[i].PartyNo           = (partyFlags >> 0) & 0x03; // Bits 0-1
            packet.GroupTbl[i].PartyLeaderFlg    = (partyFlags >> 2) & 0x01; // Bit 2
            packet.GroupTbl[i].AllianceLeaderFlg = (partyFlags >> 3) & 0x01; // Bit 3
            packet.GroupTbl[i].PartyRFlg         = (partyFlags >> 4) & 0x01; // Bit 4
            packet.GroupTbl[i].AllianceRFlg      = (partyFlags >> 5) & 0x01; // Bit 5
            packet.GroupTbl[i].unknown06         = (partyFlags >> 6) & 0x01; // Bit 6
            packet.GroupTbl[i].unknown07         = (partyFlags >> 7) & 0x01; // Bit 7
            packet.GroupTbl[i].ZoneNo            = pos_zone ? pos_zone : rset->get<uint16>("pos_prevzone");
            i++;
        }

        if (loadTrust)
        {
            const auto* PLeader = static_cast<CCharEntity*>(PParty->GetLeader());
            if (PLeader != nullptr)
            {
                for (const auto* PTrust : PLeader->PTrusts)
                {
                    packet.GroupTbl[i].UniqueNo          = PTrust->id;
                    packet.GroupTbl[i].ActIndex          = PTrust->targid;
                    packet.GroupTbl[i].PartyNo           = 0; // Trusts are in main party
                    packet.GroupTbl[i].PartyLeaderFlg    = 0;
                    packet.GroupTbl[i].AllianceLeaderFlg = 0;
                    packet.GroupTbl[i].PartyRFlg         = 0;
                    packet.GroupTbl[i].AllianceRFlg      = 0;
                    packet.GroupTbl[i].unknown06         = 0;
                    packet.GroupTbl[i].unknown07         = 0;
                    packet.GroupTbl[i].ZoneNo            = PTrust->getZone();
                    i++;
                }
            }
        }
    }
}
