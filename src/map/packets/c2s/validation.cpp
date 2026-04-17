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

#include "ai/ai_container.h"
#include "entities/charentity.h"
#include "items/item_linkshell.h"
#include "status_effect_container.h"
#include "utils/charutils.h"
#include "utils/jailutils.h"

auto PacketValidator::blockedBy(const magic_enum::containers::bitset<BlockedState> states) -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    // Checks do short-circuit, keep more expensive ones at the tail end
    // clang-format off
    CHECK_BLOCKED(BlockedState::Jailed,         jailutils::InPrison(PChar_))
    CHECK_BLOCKED(BlockedState::Dead,           PChar_->isDead())
    CHECK_BLOCKED(BlockedState::Crafting,       PChar_->isCrafting())
    CHECK_BLOCKED(BlockedState::Fishing,        PChar_->isFishing())
    CHECK_BLOCKED(BlockedState::Sitting,        PChar_->animation == ANIMATION_SIT || (PChar_->animation >= ANIMATION_SITCHAIR_0 && PChar_->animation <= ANIMATION_SITCHAIR_10))
    CHECK_BLOCKED(BlockedState::Mounted,        PChar_->isMounted())
    CHECK_BLOCKED(BlockedState::InEvent,        PChar_->isInEvent())
    CHECK_BLOCKED(BlockedState::Engaged,        PChar_->PAI->IsEngaged())
    CHECK_BLOCKED(BlockedState::AbnormalStatus, PChar_->status != STATUS_TYPE::NORMAL)
    CHECK_BLOCKED(BlockedState::Monstrosity,    PChar_->m_PMonstrosity != nullptr)
    CHECK_BLOCKED(BlockedState::Healing,        PChar_->StatusEffectContainer->HasStatusEffect(EFFECT_HEALING) || PChar_->animation == ANIMATION_HEALING)
    CHECK_BLOCKED(BlockedState::Charmed,        PChar_->StatusEffectContainer->HasStatusEffect({ EFFECT_CHARM, EFFECT_CHARM_II }))
    CHECK_BLOCKED(BlockedState::PreventAction,  PChar_->StatusEffectContainer->HasPreventActionEffect())
    // clang-format on

    return *this;
}

auto PacketValidator::isInEvent(Maybe<uint16_t> eventId) -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (!PChar_->isInEvent())
    {
        result_.addError("Not in an event.");
    }
    else
    {
        if (eventId.has_value())
        {
            if (PChar_->currentEvent->eventId != eventId.value())
            {
                result_.addError(std::format("Event ID mismatch {} != {}.", PChar_->currentEvent->eventId, eventId.value()));
            }
        }
    }

    return *this;
}

auto PacketValidator::hasLinkshellRank(const uint8_t slot, const LSTYPE rank) -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    CItemLinkshell* PItemLinkshell = nullptr;

    switch (slot)
    {
        case 1:
            PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar_->getEquip(SLOT_LINK1));
            break;
        case 2:
            PItemLinkshell = reinterpret_cast<CItemLinkshell*>(PChar_->getEquip(SLOT_LINK2));
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

auto PacketValidator::hasZoneMiscFlag(const ZONEMISC flag) -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (PChar_->m_GMlevel == 0 && !PChar_->loc.zone->CanUseMisc(flag))
    {
        result_.addError(std::format("Zone {} does not allow misc flag {}.", PChar_->loc.zone->getName(), static_cast<uint16_t>(flag)));
    }

    return *this;
}

auto PacketValidator::isPartyLeader() -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (!PChar_->PParty)
    {
        result_.addError("Not in a party.");
    }
    else if (PChar_->PParty->GetLeader() != PChar_)
    {
        result_.addError("Not the party leader.");
    }

    return *this;
}

auto PacketValidator::isAllianceLeader() -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (!PChar_->PParty)
    {
        result_.addError("Not in a party.");
    }
    else if (!PChar_->PParty->m_PAlliance)
    {
        result_.addError("Not in an alliance.");
    }
    else if (PChar_->PParty->m_PAlliance->getMainParty() == nullptr)
    {
        result_.addError("No alliance main party.");
    }
    else if (PChar_->PParty->m_PAlliance->getMainParty()->GetLeader() != PChar_)
    {
        result_.addError("Not the alliance leader.");
    }

    return *this;
}

auto PacketValidator::isEngaged() -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (!PChar_->PAI->IsEngaged())
    {
        result_.addError("Character is not engaged.");
    }

    return *this;
}

auto PacketValidator::isInMogHouse() -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (!PChar_->inMogHouse())
    {
        result_.addError("Character is not in Mog House.");
    }

    return *this;
}

auto PacketValidator::hasKeyItem(const KeyItem keyItemId) -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (!charutils::hasKeyItem(PChar_, keyItemId))
    {
        result_.addError(std::format("Missing Key Item {}.", static_cast<uint16_t>(keyItemId)));
    }

    return *this;
}

auto PacketValidator::requiresPriorPacket(PacketC2S expectedPacketId) -> PacketValidator&
{
    if (!result_.valid())
    {
        return *this;
    }

    if (PChar_->m_LastPacketType != static_cast<uint16>(expectedPacketId))
    {
        result_.addError(std::format("Expected prior packet {:#05x}, got {:#05x}.", static_cast<uint16>(expectedPacketId), PChar_->m_LastPacketType));
    }

    return *this;
}
