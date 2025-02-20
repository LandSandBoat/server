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
#include "common/timer.h"
#include "common/utils.h"
#include "common/vana_time.h"

#include <cstring>

#include "entity_update.h"

#include "entities/baseentity.h"
#include "entities/mobentity.h"
#include "entities/npcentity.h"
#include "entities/petentity.h"
#include "entities/trustentity.h"
#include "status_effect_container.h"

std::string getTransportNPCName(CBaseEntity* PEntity)
{
    bool isElevator = PEntity->look.size == MODEL_ELEVATOR;
    auto strSize    = isElevator ? 10 : 8;

    std::string str(strSize, '\0');
    std::memcpy(str.data() + 0, PEntity->name.data(), PEntity->name.size());

    auto timestamp = PEntity->GetLocalVar("TransportTimestamp");
    std::memcpy(str.data() + 4, &timestamp, 4);

    if (isElevator)
    {
        std::memset(str.data() + 8, 8, 1);
    }

    return str;
}

CEntityUpdatePacket::CEntityUpdatePacket(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask)
{
    this->setType(0x0E);
    this->setSize(0x58);

    ref<uint32>(0x04) = PEntity->id;
    updateWith(PEntity, type, updatemask);
}

void CEntityUpdatePacket::updateWith(CBaseEntity* PEntity, ENTITYUPDATE type, uint8 updatemask)
{
    uint32 currentId = ref<uint32>(0x04);
    if (currentId != PEntity->id)
    {
        // Should only be able to update packets about the same character.
        ShowError("Unable to update entity update packet for %d with data from %d", currentId, PEntity->id);
        return;
    }

    ref<uint16>(0x08) = PEntity->targid; // 0x0E entity updates are valid for 0 to 1023 and 1792 to 2303
    ref<uint8>(0x0A) |= updatemask;

    switch (type)
    {
        case ENTITY_DESPAWN:
        {
            ref<uint8>(0x1F) = 0x02; // despawn animation
            ref<uint8>(0x0A) = 0x30;
            updatemask       = UPDATE_ALL_MOB;
        }
        break;
        case ENTITY_SPAWN:
        {
            updatemask = UPDATE_ALL_MOB;

            if (PEntity->look.size == MODEL_EQUIPPED || PEntity->look.size == MODEL_CHOCOBO)
            {
                updatemask = 0x57;
            }
            if (PEntity->animationsub != 0)
            {
                ref<uint8>(0x2A) = 4;
            }
            if (PEntity->spawnAnimation == SPAWN_ANIMATION::SPECIAL)
            {
                ref<uint8>(0x28) |= 0x04;
            }
            ref<uint8>(0x0A) = updatemask;
        }
        break;
        default:
        {
            break;
        }
    }

    if (updatemask & UPDATE_POS)
    {
        ref<uint8>(0x0B)  = PEntity->loc.p.rotation;
        ref<float>(0x0C)  = PEntity->loc.p.x;
        ref<float>(0x10)  = PEntity->loc.p.y;
        ref<float>(0x14)  = PEntity->loc.p.z;
        ref<uint16>(0x18) = PEntity->loc.p.moving;
        ref<uint16>(0x1A) = PEntity->m_TargID << 1;
        ref<uint8>(0x1C)  = PEntity->GetSpeed();
        ref<uint8>(0x1D)  = PEntity->animationSpeed;
    }

    if (PEntity->allegiance == ALLEGIANCE_TYPE::PLAYER && PEntity->status == STATUS_TYPE::UPDATE)
    {
        ref<uint8>(0x20) = static_cast<uint8>(STATUS_TYPE::NORMAL);
    }
    else
    {
        ref<uint8>(0x20) = static_cast<uint8>(PEntity->status);
    }

    // General flags and data
    switch (PEntity->objtype)
    {
        case TYPE_NPC:
        {
            auto* PNpc = static_cast<CNpcEntity*>(PEntity);

            if (updatemask & UPDATE_HP)
            {
                ref<uint8>(0x1E) = 0x64; // HPP: 100
                ref<uint8>(0x1F) = PEntity->animation;
                ref<uint8>(0x2A) |= PEntity->animationsub;

                ref<uint32>(0x21) = PNpc->m_flags;
                ref<uint8>(0x27)  = PNpc->name_prefix; // gender and something else

                if (PNpc->IsTriggerable())
                {
                    ref<uint8>(0x28) |= 0x40;
                }

                ref<uint8>(0x29) = static_cast<uint8>(PEntity->allegiance);
                ref<uint8>(0x2B) = PEntity->namevis;
            }

            // TODO: Unify name logic
            if (updatemask & UPDATE_NAME)
            {
                auto name = PNpc->getName();
                if (PNpc->look.size == MODEL_ELEVATOR || PNpc->look.size == MODEL_SHIP)
                {
                    name = getTransportNPCName(PNpc);
                }

                // depending on size of name, this can be 0x20, 0x22, or 0x24
                this->setSize(0x48);
                std::memcpy(buffer_.data() + 0x34, name.c_str(), std::min<size_t>(name.size(), PacketNameLength));
            }
        }
        break;
        case TYPE_MOB:
        case TYPE_PET:
        case TYPE_TRUST:
        {
            CMobEntity* PMob = static_cast<CMobEntity*>(PEntity);

            if (updatemask & UPDATE_HP)
            {
                ref<uint8>(0x1E) = PMob->GetHPP();
                ref<uint8>(0x1F) = PEntity->animation;
                ref<uint8>(0x2A) |= PEntity->animationsub;

                ref<uint32>(0x21) = PMob->m_flags;
                ref<uint8>(0x25)  = PMob->health.hp > 0 ? 0x08 : 0;
                ref<uint8>(0x27)  = PMob->m_name_prefix;
                if (PMob->PMaster != nullptr && PMob->PMaster->objtype == TYPE_PC)
                {
                    ref<uint8>(0x27) |= 0x08;
                }
                ref<uint8>(0x28) |= PMob->StatusEffectContainer->HasStatusEffect(EFFECT_TERROR) ? 0x10 : 0x00;

                // Giga hack -- mobs in Pso'Xja for some reason are less "visible"
                // Set CliPriorityFlag to force them to render on the client if they receive 0x00Es
                // TODO: make this a MOBMOD or some other way to set this flag without hardcoding.
                if (PMob->getZone() == ZONEID::ZONE_PSOXJA)
                {
                    // Enable CliPriorityFlag, see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037 (documentation for 0x00E is not on the repo yet)
                    ref<uint8>(0x28) |= 0x20;
                }

                ref<uint8>(0x28) |= PMob->health.hp > 0 && PMob->animation == ANIMATION_DEATH ? 0x08 : 0;
                ref<uint8>(0x28) |= PMob->status == STATUS_TYPE::NORMAL && PMob->objtype == TYPE_MOB ? 0x40 : 0; // Make the entity triggerable if a mob and normal status
                ref<uint8>(0x29) = static_cast<uint8>(PEntity->allegiance);
                ref<uint8>(0x2B) = PEntity->namevis;
            }

            // TODO: make flags struct for 0x00E when it's decompped
            if (PEntity->priorityRender)
            {
                // Enable CliPriorityFlag, see https://github.com/atom0s/XiPackets/tree/main/world/server/0x0037 (documentation for 0x00E is not on the repo yet)
                ref<uint8>(0x28) |= 0x20;
            }

            if (updatemask & UPDATE_STATUS)
            {
                ref<uint32>(0x2C) = PMob->m_OwnerID.id;
            }

            if (updatemask & UPDATE_NAME)
            {
                // depending on size of name, this can be 0x20, 0x22, or 0x24
                this->setSize(0x48);
                if (PMob->packetName.empty())
                {
                    std::memcpy(buffer_.data() + 0x34, PEntity->getName().c_str(), std::min<size_t>(PEntity->getName().size(), PacketNameLength));
                }
                else
                {
                    std::memcpy(buffer_.data() + 0x34, PMob->packetName.c_str(), std::min<size_t>(PMob->packetName.size(), PacketNameLength));
                }
            }
        }
        break;
        default:
        {
            break;
        }
    }

    if (PEntity->objtype == TYPE_TRUST)
    {
        // Special spawn animation
        // This also allows trusts to be despawned
        ref<uint8>(0x28) |= 0x45;
    }

    // Set look data
    switch (PEntity->look.size)
    {
        case MODEL_STANDARD:
        case MODEL_UNK_5:
        case MODEL_AUTOMATON:
        {
            ref<uint32>(0x30) = ::ref<uint32>(&PEntity->look, 0);
        }
        break;
        case MODEL_EQUIPPED:
        case MODEL_CHOCOBO:
        {
            this->setSize(0x48);
            std::memcpy(buffer_.data() + 0x30, &PEntity->look, sizeof(look_t));
        }
        break;
        case MODEL_DOOR:
        {
            this->setSize(0x48);
            ref<uint16>(0x30) = PEntity->look.size;
            std::memcpy(buffer_.data() + 0x34, PEntity->getName().c_str(), (PEntity->getName().size() > 12 ? 12 : PEntity->getName().size()));
        }
        break;
        case MODEL_SHIP:
        case MODEL_ELEVATOR:
        {
            this->setSize(0x48);
            ref<uint16>(0x30) = PEntity->look.size;
            auto name         = getTransportNPCName(PEntity);
            std::memcpy(buffer_.data() + 0x34, name.data(), name.size());
        }
        break;
    }

    // Slightly bigger packet to encompass both name and model on first spawn, and only for dynamic entities.
    if (type == ENTITY_SPAWN && PEntity->isRenamed && PEntity->look.size == MODEL_EQUIPPED && PEntity->targid >= 0x700)
    {
        this->setSize(0x56);

        // Temporarily override UpdateFlags (0x0A) to perform black magic:
        ref<uint8>(0x0A) = 0x57; // Carefully chosen bits to make FUNC_Packet_Incoming_0x000E behave (Same type as first 0x00E Fellow packet)
        ref<uint8>(0x18) = 0x01; // Copy longer name in FUNC_Packet_Incoming_0x000E

        std::memcpy(buffer_.data() + 0x30, &PEntity->look, sizeof(look_t));

        auto name       = PEntity->packetName;
        auto nameOffset = 0x44;
        auto maxLength  = std::min<size_t>(name.size(), PacketNameLength);

        // Make sure to zero-out the existing name area of the packet
        auto start = buffer_.data() + nameOffset;
        auto size  = this->getSize();
        std::memset(start, 0U, size);

        // Copy in name
        std::memcpy(start, name.c_str(), maxLength);
    }
    // If the entity has been renamed, we have to re-send the name during every update.
    // Otherwise it will revert to it's default name (if applicable).
    else if (PEntity->isRenamed)
    {
        updatemask |= UPDATE_NAME;
        ref<uint8>(0x0A) |= updatemask;

        this->setSize(0x48);

        auto name       = PEntity->packetName;
        auto nameOffset = 0x34;
        auto maxLength  = std::min<size_t>(name.size(), PacketNameLength);

        // Mobs and NPC's targid's live in the range 0-1023
        if (PEntity->targid < 1024)
        {
            ref<uint16>(0x34) = 0x01;
            nameOffset        = 0x35;
        }

        // Make sure to zero-out the existing name area of the packet
        auto start = buffer_.data() + nameOffset;
        auto size  = this->getSize();
        std::memset(start, 0U, size);

        // Copy in name
        std::memcpy(start, name.c_str(), maxLength);
    }
}
