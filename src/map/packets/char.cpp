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

#include "common/socket.h"

#include <cstring>

#include "char.h"

#include "entities/charentity.h"
#include "status_effect_container.h"
#include "utils/itemutils.h"

CCharPacket::CCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    this->setType(0x0D);
    this->setSize(0x74);

    ref<uint32>(0x04) = PChar->id;
    updateWith(PChar, type, updatemask);
}

void CCharPacket::updateWith(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    uint32 currentId = ref<uint32>(0x04);
    if (currentId != PChar->id)
    {
        // Should only be able to update packets about the same character.
        ShowError("Unable to update char packet for %d with data from %d", currentId, PChar->id);
        return;
    }

    ref<uint16>(0x08) = PChar->targid; // 0x0D entity updates are valid for 1024 to 1791

    if (type == ENTITY_SPAWN)
    {
        updatemask = 0x1F; // override mask to spawn mask
    }

    switch (type)
    {
        case ENTITY_DESPAWN:
        {
            ref<uint8>(0x0A) = UPDATE_DESPAWN;
        }
        break;
        // clang-format off
        case ENTITY_SPAWN:
        {
            updatemask = UPDATE_ALL_CHAR;
        }
        [[fallthrough]];
        // clang-format on
        case ENTITY_UPDATE:
        {
            ref<uint8>(0x0A) |= updatemask;

            if (updatemask & UPDATE_POS)
            {
                ref<uint8>(0x0B)  = PChar->loc.p.rotation;
                ref<float>(0x0C)  = PChar->loc.p.x;
                ref<float>(0x10)  = PChar->loc.p.y;
                ref<float>(0x14)  = PChar->loc.p.z;
                ref<uint16>(0x18) = PChar->loc.p.moving;
                ref<uint16>(0x1A) = PChar->m_TargID << 1;
                ref<uint8>(0x1C)  = PChar->GetSpeed();
                ref<uint8>(0x1D)  = PChar->speedsub;
            }

            if (updatemask & UPDATE_HP)
            {
                ref<uint8>(0x1E)  = PChar->GetHPP();
                ref<uint8>(0x1F)  = PChar->animation;
                ref<uint32>(0x20) = PChar->nameflags.flags;
                ref<uint8>(0x21) |= PChar->GetGender() * 128 + (1 << PChar->look.size);

                if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK))
                {
                    ref<uint8>(0x2A) |= 0x20;
                }

                if (PChar->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_INVISIBLE))
                {
                    ref<uint8>(0x23) = 0x20;
                }

                if (PChar->equip[SLOT_LINK1] != 0)
                {
                    CItemLinkshell* linkshell = (CItemLinkshell*)PChar->getEquip(SLOT_LINK1);

                    if ((linkshell != nullptr) && linkshell->isType(ITEM_LINKSHELL))
                    {
                        lscolor_t LSColor = linkshell->GetLSColor();

                        ref<uint8>(0x24) = (LSColor.R << 4) + 15;
                        ref<uint8>(0x25) = (LSColor.G << 4) + 15;
                        ref<uint8>(0x26) = (LSColor.B << 4) + 15;
                    }
                }

                ref<uint8>(0x27) = (PChar->isCharmed ? 0x08 : 0x00);

                ref<uint8>(0x29) = static_cast<uint8>(PChar->allegiance);

                // Mentor flag..
                if (PChar->menuConfigFlags.flags & NFLAG_MENTOR)
                {
                    ref<uint8>(0x2B) = 0x01;
                }
                else
                {
                    ref<uint8>(0x2B) = 0x00;
                }

                // New Player Flag..
                if (PChar->isNewPlayer())
                {
                    ref<uint8>(0x2A) |= 0x80;
                }

                if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_MOUNTED))
                {
                    ref<uint8>(0x20) |= static_cast<uint8>(PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetSubPower());
                    ref<uint32>(0x34) = PChar->m_FieldChocobo;
                    ref<uint16>(0x44) = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetPower() << 4;
                }
            }

            if (PChar->PPet != nullptr)
            {
                ref<uint16>(0x3C) = PChar->PPet->targid;
            }

            ref<uint16>(0x30) = PChar->m_Costume;

            if (PChar->getMod(Mod::SUPERIOR_LEVEL) == 5 && PChar->m_jobMasterDisplay)
            {
                // TODO: This bitfield may be used more, update to shift
                ref<uint8>(0x33) = 0x40;
            }

            // Geomancer (GEO) Indi spell effect on the char.
            if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_COLURE_ACTIVE))
            {
                ref<uint8>(0x42) = 0x50 + PChar->StatusEffectContainer->GetStatusEffect(EFFECT_COLURE_ACTIVE)->GetPower();
            }

            ref<uint8>(0x43) = 0x04; // Seen as 0x0C and 0x06 in Monstrosity?

            if (updatemask & UPDATE_LOOK)
            {
                look_t* look      = (PChar->getStyleLocked() ? &PChar->mainlook : &PChar->look);
                ref<uint8>(0x48)  = look->face;
                ref<uint8>(0x49)  = look->race;
                ref<uint16>(0x4A) = PChar->menuConfigFlags.flags & NFLAG_DISPLAY_HEAD ? 0 : look->head + 0x1000;
                ref<uint16>(0x4C) = look->body + 0x2000;
                ref<uint16>(0x4E) = look->hands + 0x3000;
                ref<uint16>(0x50) = look->legs + 0x4000;
                ref<uint16>(0x52) = look->feet + 0x5000;
                ref<uint16>(0x54) = look->main + 0x6000;
                ref<uint16>(0x56) = look->sub + 0x7000;
                ref<uint16>(0x58) = look->ranged + 0x8000;

                if (PChar->m_Costume2 != 0)
                {
                    ref<uint16>(0x48) = PChar->m_Costume2;
                    ref<uint16>(0x58) = 0xFFFF;
                }
            }

            if (updatemask & UPDATE_NAME)
            {
                memcpy(data + (0x5A), PChar->getName().c_str(), PChar->getName().size());
            }

            if (PChar->m_PMonstrosity != nullptr && (updatemask & UPDATE_HP || updatemask & UPDATE_LOOK))
            {
                ref<uint32>(0x3E) = monstrosity::GetPackedMonstrosityName(PChar);
                ref<uint16>(0x48) = PChar->m_PMonstrosity->Look;
                ref<uint16>(0x58) = 0xFFFF;

                if (PChar->m_PMonstrosity->Belligerency)
                {
                    ref<uint8>(0x29) |= 0x08;
                }
            }
        }
        break;
        default:
        {
            break;
        }
    }
}

// Some manipulations with a package lead to an interesting result (the number of goals in some game)
