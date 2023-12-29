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

#include "char_update.h"

#include "common/logging.h"
#include "common/socket.h"
#include "common/vana_time.h"

#include <cstring>

#include "ai/ai_container.h"
#include "ai/states/death_state.h"
#include "entities/charentity.h"
#include "status_effect_container.h"
#include "utils/itemutils.h"

CCharUpdatePacket::CCharUpdatePacket(CCharEntity* PChar)
{
    this->setType(0x37);
    this->setSize(0x60);

    memcpy(data + (0x04), PChar->StatusEffectContainer->m_StatusIcons, 32);

    ref<uint32>(0x24) = PChar->id;
    ref<uint8>(0x2A)  = PChar->GetHPP();

    ref<uint8>(0x28) = (PChar->nameflags.byte2 << 1);
    ref<uint8>(0x2B) = (PChar->nameflags.byte4 << 5) + PChar->nameflags.byte3;
    ref<uint8>(0x2F) = ((PChar->nameflags.byte4 >> 2) & 0xFE);
    ref<uint8>(0x2F) |= PChar->isCharmed ? 0x40 : 0x00;

    if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE))
    {
        ref<uint8>(0x2D) = 0x80;
    }

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK))
    {
        ref<uint8>(0x38) = 0x04;
    }

    if (PChar->menuConfigFlags.flags & NFLAG_MENTOR)
    {
        ref<uint8>(0x38) |= 0x10; // Mentor flag.
    }

    if (PChar->isNewPlayer())
    {
        ref<uint8>(0x38) |= 0x08; // New player ?
    }

    ref<uint8>(0x29) = PChar->GetGender() + (PChar->look.size << 3);
    // ref<uint8>(0x29) |= 0x02; // this will display the old-style zone-wide treasure pool. All claimed mobs will show red name regardless of which party has claim.
    ref<uint8>(0x2C) = PChar->GetSpeed();
    ref<uint16>(0x2E) |= PChar->speedsub << 1; // Not sure about this, it was a work around when we set speedsub incorrectly..
    ref<uint8>(0x30) = PChar->isInEvent() ? (uint8)ANIMATION_EVENT : PChar->animation;

    CItemLinkshell* linkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);

    if ((linkshell != nullptr) && linkshell->isType(ITEM_LINKSHELL))
    {
        lscolor_t LSColor = linkshell->GetLSColor();

        ref<uint8>(0x31) = (LSColor.R << 4) + 15;
        ref<uint8>(0x32) = (LSColor.G << 4) + 15;
        ref<uint8>(0x33) = (LSColor.B << 4) + 15;
    }

    if (PChar->PPet != nullptr)
    {
        ref<uint16>(0x34) = PChar->PPet->targid << 3;
    }

    // Status flag: bit 4: frozen anim (terror),
    //  bit 6/7/8 related to Ballista (6 set - normal, 7 set san d'oria, 6+7 set bastok, 8 set windurst)
    uint8 flag = (static_cast<uint8>(PChar->allegiance) << 5);

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR))
    {
        flag |= 0x08;
    }

    ref<uint8>(0x36) = flag;

    // Sword & Shield Icon (Campaign battles, etc?)
    // ref<uint8>(0x37) = 0x01;

    uint32 timeRemainingToForcedHomepoint = PChar->GetTimeRemainingUntilDeathHomepoint();
    ref<uint32>(0x3C)                     = timeRemainingToForcedHomepoint;

    // Vanatime at which the player should be forced back to homepoint while dead. Vanatime is in seconds so we must convert the time remaining to seconds.
    ref<uint32>(0x40) = CVanaTime::getInstance()->getVanaTime() + timeRemainingToForcedHomepoint / 60;
    ref<uint16>(0x44) = PChar->m_Costume;

    if (PChar->animation == ANIMATION_FISHING_START)
    {
        ref<uint16>(0x4A) = PChar->hookDelay;
    }

    ref<uint64>(0x4C) = PChar->StatusEffectContainer->m_Flags;

    // GEO bubble effects, changes bubble effect depending on what effect is activated.
    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_COLURE_ACTIVE))
    {
        ref<uint8>(0x58) = 0x50 + PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COLURE_ACTIVE)->GetPower();
    }

    if (PChar->getMod(Mod::SUPERIOR_LEVEL) == 5 && PChar->m_jobMasterDisplay)
    {
        ref<uint8>(0x58) += 0x80;
    }

    if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
    {
        ref<uint8>(0x29) |= static_cast<uint8>(PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower());
        ref<uint16>(0x5B) = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetPower();
    }

    if (PChar->m_PMonstrosity != nullptr)
    {
        ref<uint32>(0x54) = monstrosity::GetPackedMonstrosityName(PChar);

        // Sword & Shield icon only shows outside of the Feretory
        if (PChar->m_PMonstrosity->Belligerency && PChar->loc.zone->GetID() != ZONE_FERETORY)
        {
            ref<uint8>(0x37) |= 0x01;
        }
    }
}
