#include "common/socket.h"

#include "entities/baseentity.h"

#include "independent_animation.h"

CIndependentAnimationPacket::CIndependentAnimationPacket(CBaseEntity* PEntity, CBaseEntity* PTarget, uint16 animId, uint8 type)
{
    this->setType(0x3A);
    this->setSize(0x28);

    if (PEntity)
    {
        ref<uint32>(0x04) = PEntity->id;
        ref<uint32>(0x08) = PTarget->id;

        ref<uint16>(0x0C) = PEntity->targid;
        ref<uint16>(0x0E) = PTarget->targid;

        ref<uint16>(0x10) = animId;

        ref<uint8>(0x12) = type;
    }
}
