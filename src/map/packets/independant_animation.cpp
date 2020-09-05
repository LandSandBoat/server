#include "../../common/socket.h"

#include "../entities/baseentity.h"

#include "independant_animation.h"

CIndependantAnimationPacket::CIndependantAnimationPacket(CBaseEntity* PEntity, CBaseEntity* PTarget, uint16 animId, uint8 type)
{
	this->type = 0x3A;
	this->size = 0x14;

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
