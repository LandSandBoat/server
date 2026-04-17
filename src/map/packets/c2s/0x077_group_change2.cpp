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

#include "0x077_group_change2.h"

#include "ipc_client.h"
#include "linkshell.h"

#include "common/ipc_structs.h"
#include "entities/charentity.h"
#include "items/item_linkshell.h"

namespace
{

const std::set validLinkshellOperations = {
    GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Linkshell1,
    GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Linkshell2,
};

} // namespace

auto GP_CLI_COMMAND_GROUP_CHANGE2::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    auto pv = PacketValidator(PChar)
                  .blockedBy({ BlockedState::InEvent })
                  .oneOf<GP_CLI_COMMAND_GROUP_CHANGE2_KIND>(this->Kind)
                  .oneOf<GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND>(this->ChangeKind);

    switch (static_cast<GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND>(this->ChangeKind))
    {
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetPartyLeader:
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetQuartermaster:
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetLottery:
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetLevelSync:
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::DisableLevelSync:
        {
            pv
                .mustEqual(this->Kind, GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Party, "Invalid operation")
                .isPartyLeader();
        }
        break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::PearlToSack:
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SackToPearl:
        {
            pv
                .oneOf("Kind", static_cast<GP_CLI_COMMAND_GROUP_CHANGE2_KIND>(this->Kind), validLinkshellOperations)
                .hasLinkshellRank(this->Kind, LSTYPE_LINKSHELL);
        }
        break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND::SetAllianceLeader:
        {
            pv
                .mustEqual(this->Kind, GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Alliance, "Invalid operation")
                .isAllianceLeader();
        }
        break;
    }

    return pv;
}

void GP_CLI_COMMAND_GROUP_CHANGE2::process(MapSession* PSession, CCharEntity* PChar) const
{
    const auto memberName = db::escapeString(asStringFromUntrustedSource(this->sName, sizeof(this->sName)));
    switch (static_cast<GP_CLI_COMMAND_GROUP_CHANGE2_KIND>(this->Kind))
    {
        case GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Party:
        {
            ShowDebug(fmt::format("(Party) Altering permissions of {} to {}", memberName, this->ChangeKind));
            PChar->PParty->AssignPartyRole(memberName, static_cast<GP_CLI_COMMAND_GROUP_CHANGE2_CHANGEKIND>(this->ChangeKind));
        }
        break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Linkshell1:
        case GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Linkshell2:
        {
            CItemLinkshell*   PItemLinkshell = nullptr;
            const CLinkshell* PLinkshell     = nullptr;
            switch (this->Kind)
            {
                case 1:
                {
                    PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));
                    PLinkshell     = PChar->PLinkshell1;
                }
                break;
                case 2:
                {
                    PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK2));
                    PLinkshell     = PChar->PLinkshell2;
                }
                break;
                default:
                    // Conditions leading here are checked beforehand
                    break;
            }

            if (PLinkshell && PItemLinkshell)
            {
                message::send(ipc::LinkshellRankChange{
                    .requesterId   = PChar->id,
                    .requesterRank = PItemLinkshell->GetLSType(),
                    .memberName    = memberName,
                    .linkshellId   = PLinkshell->getID(),
                    .newRank       = this->ChangeKind,
                });
            }
        }
        break;
        case GP_CLI_COMMAND_GROUP_CHANGE2_KIND::Alliance:
        {
            ShowDebug(fmt::format("(Alliance) Changing leader to {}", memberName));
            PChar->PParty->m_PAlliance->assignAllianceLeader(memberName);

            message::send(ipc::AllianceReload{
                .allianceId = PChar->PParty->m_PAlliance->m_AllianceID,
            });
        }
        break;
    }
}
