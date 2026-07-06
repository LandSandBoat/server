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

#include "nominate_manager.h"

#include "alliance.h"
#include "entities/char_entity.h"
#include "enums/msg_std.h"
#include "linkshell.h"
#include "party.h"
#include "utils/zoneutils.h"
#include "zone.h"

#include "packets/c2s/0x0a1_switch_vote.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x078_switch_start.h"
#include "packets/s2c/0x079_switch_proc.h"

#include "common/logging.h"

#include <common/types/hash_map.h>

namespace
{

constexpr uint16                                           maxOptions = 8;
constexpr timer::duration                                  cooldown{ std::chrono::seconds(60) };
const HashMap<GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND, uint16> scopeCapacity = {
    { GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Party, 18 },
    { GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell1, 64 },
    { GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell2, 64 },
    { GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Say, 512 },
    { GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Shout, 512 },
};

// Splits raw on whitespace, honoring quotes. First token is the question, rest are options. "" is a valid token.
auto parseInput(const std::string& raw) -> std::pair<std::string, std::vector<std::string>>
{
    std::vector<std::string> tokens;
    std::string              cur;
    bool                     inQuotes = false;
    bool                     hasToken = false;

    auto flush = [&]
    {
        if (hasToken)
        {
            tokens.push_back(std::move(cur));
            cur.clear();
            hasToken = false;
        }
    };

    for (const char c : raw)
    {
        if (c == '"')
        {
            inQuotes = !inQuotes;
            hasToken = true;
            continue;
        }

        if (!inQuotes && (c == ' ' || c == '\t'))
        {
            flush();
            continue;
        }

        cur.push_back(c);
        hasToken = true;
    }

    flush();

    std::string              question;
    std::vector<std::string> options;
    if (!tokens.empty())
    {
        question = std::move(tokens.front());
        for (size_t i = 1; i < tokens.size() && options.size() < maxOptions; ++i)
        {
            options.push_back(std::move(tokens[i]));
        }
    }

    return { std::move(question), std::move(options) };
}

//   withTallies=false: "[question]\n1:opt1\n2:opt2\n..."
//   withTallies=true:  "[question]\n1[N]:opt1\n2[N]:opt2\n..."
// Tally is 1-indexed
auto formatBody(const NominateProposal& proposal, const bool withTallies) -> std::string
{
    std::string out;
    out.reserve(80);
    out.append("[").append(proposal.question).append("]");
    for (size_t i = 0; i < proposal.options.size(); ++i)
    {
        const auto optionNumber = i + 1;
        out.append("\n").append(std::to_string(optionNumber));
        if (withTallies)
        {
            out.append("[").append(std::to_string(proposal.voteTbl[optionNumber])).append("]");
        }
        out.append(":").append(proposal.options[i]);
    }

    return out;
}

auto buildProposal(const CCharEntity* PChar, const GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND kind, const std::string& rawStr) -> NominateProposal
{
    auto [question, options] = parseInput(rawStr);

    NominateProposal p{
        .proposerId       = PChar->id,
        .proposerName     = PChar->getName(),
        .proposerActIndex = PChar->targid,
        .kind             = kind,
        .allNum           = scopeCapacity.at(kind),
        .question         = std::move(question),
        .options          = std::move(options),
    };

    switch (kind)
    {
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Party:
            if (PChar->PParty != nullptr)
            {
                p.partyId    = PChar->PParty->GetPartyID();
                p.allianceId = PChar->PParty->m_PAlliance != nullptr ? PChar->PParty->m_PAlliance->m_AllianceID : 0u;
            }
            break;
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell1:
            if (PChar->PLinkshell1 != nullptr)
            {
                p.linkshellId = PChar->PLinkshell1->getID();
            }
            break;
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell2:
            if (PChar->PLinkshell2 != nullptr)
            {
                p.linkshellId = PChar->PLinkshell2->getID();
            }
            break;
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Say:
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Shout:
            break;
    }

    return p;
}

// Ensure PC can actually submit a proposal of the given kind
auto validateProposerScope(CCharEntity* PChar, const GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND kind) -> bool
{
    switch (kind)
    {
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Party:
            if (PChar->PParty == nullptr)
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::NoPartyMembers);
                return false;
            }
            return true;

        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell1:
            if (PChar->PLinkshell1 == nullptr)
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::NoLinkshellEquipped);
                return false;
            }
            return true;

        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell2:
            if (PChar->PLinkshell2 == nullptr)
            {
                PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::NoLinkshellEquipped);
                return false;
            }
            return true;

        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Say:
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Shout:
            return true;
    }

    return false;
}

} // namespace

NominateManager::NominateManager(CZone& zone)
: zone_(zone)
{
}

auto NominateProposal::inScope(const CCharEntity* PChar) const -> bool
{
    switch (this->kind)
    {
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Party:
        {
            if (PChar->PParty == nullptr)
            {
                return false;
            }

            if (PChar->PParty->GetPartyID() == this->partyId)
            {
                return true;
            }

            return this->allianceId != 0 && PChar->PParty->m_PAlliance != nullptr &&
                   PChar->PParty->m_PAlliance->m_AllianceID == this->allianceId;
        }
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell1:
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell2:
            return (PChar->PLinkshell1 != nullptr && PChar->PLinkshell1->getID() == this->linkshellId) ||
                   (PChar->PLinkshell2 != nullptr && PChar->PLinkshell2->getID() == this->linkshellId);
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Say:
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Shout:
            return true;
    }

    return false;
}

void NominateProposal::deliverProc(CCharEntity* PChar, const bool isFinal) const
{
    const auto state = isFinal ? GP_SERV_COMMAND_SWITCH_PROC_STATE::Closed : GP_SERV_COMMAND_SWITCH_PROC_STATE::Active;
    const auto body  = isFinal ? formatBody(*this, true) : std::string{};
    PChar->pushPacket<GP_SERV_COMMAND_SWITCH_PROC>(*this, state, body);
}

void NominateManager::broadcastStart(const NominateProposal& proposal) const
{
    auto* PProposer = zoneutils::GetChar(proposal.proposerId);
    if (!PProposer)
    {
        return;
    }

    const std::unique_ptr<CBasicPacket> packet = std::make_unique<GP_SERV_COMMAND_SWITCH_START>(proposal, formatBody(proposal, false));
    const auto                          zoneId = PProposer->getZone();

    switch (proposal.kind)
    {
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Say:
        {
            this->zone_.PushPacket(PProposer, CHAR_INRANGE_SELF, packet);
            break;
        }
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Shout:
        {
            PProposer->pushPacket(packet->copy());
            this->zone_.PushPacket(PProposer, CHAR_INSHOUT, packet);
            break;
        }
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Party:
        {
            PProposer->ForAlliance([&](CBattleEntity* PMember)
                                   {
                                       if (auto* PMemberChar = dynamic_cast<CCharEntity*>(PMember))
                                       {
                                           if (PMemberChar->getZone() == zoneId)
                                           {
                                               PMemberChar->pushPacket(packet->copy());
                                           }
                                       }
                                   });
            break;
        }
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell1:
        case GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell2:
        {
            const uint8 slot = proposal.kind == GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND::Linkshell1 ? 1 : 2;
            PProposer->ForLinkshell(slot, [&](CCharEntity* PMember)
                                    {
                                        if (PMember->getZone() == zoneId)
                                        {
                                            PMember->pushPacket(packet->copy());
                                        }
                                    });
            break;
        }
    }
}

// Proposer always gets results, plus all voters. If you didn't vote, you don't get anything.
void NominateManager::broadcastFinal(const NominateProposal& proposal) const
{
    if (auto* PProposer = zoneutils::GetChar(proposal.proposerId))
    {
        proposal.deliverProc(PProposer, true);
    }

    for (const uint32 voterId : proposal.voters)
    {
        if (voterId == proposal.proposerId)
        {
            continue;
        }

        if (auto* PVoter = zoneutils::GetChar(voterId))
        {
            proposal.deliverProc(PVoter, true);
        }
    }
}

void NominateManager::finalize(CCharEntity* PChar, const NominateProposal& proposal) const
{
    this->broadcastFinal(proposal);
    PChar->setLastProposalCloseTime(timer::now());
}

// /nominate received. Create new poll or close current.
void NominateManager::onProposal(CCharEntity* PChar, const GP_CLI_COMMAND_SWITCH_PROPOSAL& packet)
{
    if (!PChar)
    {
        return;
    }

    // /nominate while a poll is active closes it and returns. Never resubmits.
    const auto activeIt = this->activeProposals_.find(PChar->getName());
    if (activeIt != this->activeProposals_.end())
    {
        this->finalize(PChar, activeIt->second);
        this->activeProposals_.erase(activeIt);
        return;
    }

    if (timer::now() - PChar->lastProposalCloseTime() < cooldown) // 60s cooldown on making a new poll
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(MsgStd::CannotUseCommandAtTheMoment);
        return;
    }

    const auto kind = static_cast<GP_CLI_COMMAND_SWITCH_PROPOSAL_KIND>(packet.Kind);
    if (!validateProposerScope(PChar, kind))
    {
        return;
    }

    const auto rawStr   = asStringFromUntrustedSource(packet.Str, sizeof(packet.Str));
    auto       proposal = buildProposal(PChar, kind, rawStr);
    this->broadcastStart(proposal);
    this->activeProposals_.emplace(PChar->getName(), std::move(proposal));
}

// /vote received, find the live poll and add to tally
void NominateManager::onVote(CCharEntity* PChar, const GP_CLI_COMMAND_SWITCH_VOTE& packet)
{
    if (!PChar)
    {
        return;
    }

    const auto proposerName = asStringFromUntrustedSource(packet.Name, sizeof(packet.Name));
    const auto it           = this->activeProposals_.find(proposerName);

    // Poll not found or not part of alliance/LS
    if (it == this->activeProposals_.end() || !it->second.inScope(PChar))
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(proposerName, MsgStd::NotProposedAnything);
        return;
    }

    auto& proposal = it->second;
    if (proposal.voters.contains(PChar->id))
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(proposerName, MsgStd::AlreadyVotedOnProposal);
        return;
    }

    const auto numChoices = static_cast<uint8>(proposal.options.size());
    if (numChoices == 0 || packet.Index < 1 || packet.Index > numChoices) // Packet injection out of bounds
    {
        PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(uint32{ numChoices }, MsgStd::OnlyChooseFromGivenChoices);
        return;
    }

    // Increment tally and track new voter
    proposal.voteTbl[packet.Index]++;
    proposal.voters.insert(PChar->id);

    // Live tally to the voter.
    proposal.deliverProc(PChar, false);

    // And to the proposer.
    if (auto* PProposer = zoneutils::GetChar(proposal.proposerId); PProposer && PProposer != PChar)
    {
        proposal.deliverProc(PProposer, false);
    }
}

// Leaving a zone force-closes your poll.
void NominateManager::onCharLeavingZone(CCharEntity* PChar)
{
    if (!PChar)
    {
        return;
    }

    const auto it = this->activeProposals_.find(PChar->getName());
    if (it == this->activeProposals_.end())
    {
        return;
    }

    this->finalize(PChar, it->second);
    this->activeProposals_.erase(it);
}
