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

#include "validation.h"

#include "entities/charentity.h"
#include "items/item_linkshell.h"
#include "status_effect_container.h"
#include "trade_container.h"

auto PacketValidator::isNotResting(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_HEALING) ||
        PChar->animation == ANIMATION_HEALING)
    {
        result_.addError("Character is resting.");
    }

    return *this;
}

auto PacketValidator::isNotCrafting(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->animation == ANIMATION_SYNTH ||
        (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
    {
        result_.addError("Character is crafting.");
    }

    return *this;
}

auto PacketValidator::isNormalStatus(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->status != STATUS_TYPE::NORMAL)
    {
        result_.addError("Character has abnormal status.");
    }

    return *this;
}

auto PacketValidator::isNotPreventedAction(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->StatusEffectContainer->HasPreventActionEffect())
    {
        result_.addError("Character has prevent action effect.");
    }

    return *this;
}

auto PacketValidator::isNotMonstrosity(const CCharEntity* PChar) -> PacketValidator&
{
    if (PChar->m_PMonstrosity)
    {
        result_.addError("Character is a Monstrosity.");
    }

    return *this;
}

auto PacketValidator::isInEvent(const CCharEntity* PChar, std::optional<uint16_t> eventId) -> PacketValidator&
{
    if (!PChar->isInEvent())
    {
        result_.addError("Not in an event.");
    }
    else
    {
        if (eventId.has_value())
        {
            if (PChar->currentEvent->eventId != eventId.value())
            {
                result_.addError(fmt::format("Event ID mismatch {} != {}.", PChar->currentEvent->eventId, eventId.value()));
            }
        }
    }

    return *this;
}

auto PacketValidator::hasLinkshellRank(const CCharEntity* PChar, const uint8_t slot, const LSTYPE rank) -> PacketValidator&
{
    CItemLinkshell* PItemLinkshell = nullptr;

    switch (slot)
    {
        case 1:
            PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK1));
            break;
        case 2:
            PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar->getEquip(SLOT_LINK2));
            break;
        default:
            result_.addError("Invalid linkshell slot.");
            return *this;
    }

    if (!PItemLinkshell || !PItemLinkshell->isType(ITEM_LINKSHELL))
    {
        result_.addError("Invalid linkshell item.");
        return *this;
    }

    const auto actualRank   = PItemLinkshell->GetLSType();
    auto       matchingRank = false;

    switch (rank)
    {
        case LSTYPE_LINKSHELL:
            matchingRank = actualRank == LSTYPE_LINKSHELL;
            break;
        case LSTYPE_PEARLSACK:
            matchingRank = (actualRank == LSTYPE_LINKSHELL ||
                            actualRank == LSTYPE_PEARLSACK);
            break;
        case LSTYPE_LINKPEARL:
            matchingRank = (actualRank == LSTYPE_LINKSHELL ||
                            actualRank == LSTYPE_LINKPEARL ||
                            actualRank == LSTYPE_PEARLSACK);
            break;
        default:
            matchingRank = false;
            break;
    }

    if (!matchingRank)
    {
        result_.addError("Invalid linkshell rank.");
    }

    return *this;
}

auto PacketValidator::hasZoneMiscFlag(const CCharEntity* PChar, const ZONEMISC flag) -> PacketValidator&
{
    if (PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(flag))
    {
        result_.addError(std::format("Zone {} does not allow misc flag {}.", PChar->loc.zone->getName(), static_cast<uint16_t>(flag)));
    }

    return *this;
}

auto PacketValidator::isPartyLeader(const CCharEntity* PChar) -> PacketValidator&
{
    if (!PChar->PParty)
    {
        result_.addError("Not in a party.");
    }
    else if (PChar->PParty->GetLeader() != PChar)
    {
        result_.addError("Not the party leader.");
    }

    return *this;
}

auto PacketValidator::isAllianceLeader(const CCharEntity* PChar) -> PacketValidator&
{
    if (!PChar->PParty)
    {
        result_.addError("Not in a party.");
    }
    else if (!PChar->PParty->m_PAlliance)
    {
        result_.addError("Not in an alliance.");
    }
    else if (PChar->PParty->m_PAlliance->getMainParty()->GetLeader() != PChar)
    {
        result_.addError("Not the alliance leader.");
    }

    return *this;
}

auto PacketValidator::isNotFishing(const CCharEntity* PChar) -> PacketValidator&
{
    if ((PChar->animation >= ANIMATION_FISHING_FISH && PChar->animation <= ANIMATION_FISHING_STOP) ||
        PChar->animation == ANIMATION_FISHING_START_OLD || PChar->animation == ANIMATION_FISHING_START)
    {
        result_.addError("Character is fishing.");
    }

    return *this;
}
