/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include <common/types/hash_map.h>

#include "packets/c2s/0x0a0_switch_proposal.h"

#include <array>
#include <string>
#include <unordered_set>
#include <vector>

class CCharEntity;
class CZone;

struct GP_CLI_COMMAND_SWITCH_VOTE;

struct NominateProposal
{
    uint32                              proposerId{};
    std::string                         proposerName{};
    uint16                              proposerActIndex{};
    GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND kind{};
    uint16                              allNum{};
    std::string                         question{};
    std::vector<std::string>            options{};
    std::array<uint16, 9>               voteTbl{};
    std::unordered_set<uint32>          voters{};
    uint32                              partyId{};
    uint32                              allianceId{};
    uint32                              linkshellId{};

    auto inScope(const CCharEntity* PChar) const -> bool;
    void deliverProc(CCharEntity* PChar, bool isFinal) const;
};

class NominateManager
{
public:
    explicit NominateManager(CZone& zone);

    void onProposal(CCharEntity* PChar, const GP_CLI_COMMAND_SWITCH_PROPOSAL& packet);
    void onVote(CCharEntity* PChar, const GP_CLI_COMMAND_SWITCH_VOTE& packet);
    void onCharLeavingZone(CCharEntity* PChar);

private:
    void broadcastStart(const NominateProposal& proposal) const;
    void broadcastFinal(const NominateProposal& proposal) const;
    void finalize(CCharEntity* PChar, const NominateProposal& proposal) const;

    CZone&                                 zone_;
    HashMap<std::string, NominateProposal> activeProposals_;
};
