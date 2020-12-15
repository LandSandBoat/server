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

#include "../../common/socket.h"

#include <cstring>

#include "char.h"

#include "../entities/charentity.h"
#include "../status_effect_container.h"
#include "../utils/itemutils.h"

CCharPacket::CCharPacket(CCharEntity* PChar, ENTITYUPDATE type, uint8 updatemask)
{
    this->type = 0x0D;
    this->size = 0x3A;

    ref<uint32>(0x04) = PChar->id;
    ref<uint16>(0x08) = PChar->targid;

    switch (type)
    {
        case ENTITY_DESPAWN:
        {
            ref<uint8>(0x0A) = 0x20;
        }
        break;
        case ENTITY_SPAWN:
            updatemask = 0x1F;
        case ENTITY_UPDATE:
        {
            ref<uint8>(0x0A) = updatemask;

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

                // if (PChar->StatusEffectContainer->HasStatusEffect(EFFECT_SNEAK))
                //{
                //	ref<uint8>(data,(0x22)) = 0x20;
                //}

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

                ref<uint8>(0x29) = PChar->allegiance;

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

                ref<uint32>(0x34) = 0x010CA248; // black chocobo

                if (PChar->animation == ANIMATION_MOUNT)
                {
                    ref<uint16>(0x44) = PChar->StatusEffectContainer->GetStatusEffect(EFFECT_MOUNTED)->GetPower() << 4;
                }
            }
            if (PChar->PPet != nullptr)
            {
                ref<uint16>(0x3C) = PChar->PPet->targid;
            }

            ref<uint16>(0x30) = PChar->m_Costume;
            ref<uint8>(0x43)  = 0x04;

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

                if (PChar->m_Monstrosity != 0)
                {
                    ref<uint16>(0x48) = PChar->m_Monstrosity;
                    ref<uint16>(0x58) = 0xFFFF;
                }
            }

            if (updatemask & UPDATE_NAME)
            {
                memcpy(data + (0x5A), PChar->GetName(), PChar->name.size());
            }
        }
        break;
        default:
        {
            break;
        }
    }
}

// некоторые манипуляции с пакетом приводят к интересному результату (количество голов в какой-то игре)
