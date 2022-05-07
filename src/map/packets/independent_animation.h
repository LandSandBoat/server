#ifndef _CINDEPENDENTANIMATIONPACKET_H
#define _CINDEPENDENTANIMATIONPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

class CBaseEntity;

// This is sometimes sent along with an Action Message packet, to provide an animation for an action message.
class CIndependentAnimationPacket : public CBasicPacket
{
public:
    CIndependentAnimationPacket(CBaseEntity* PEntity, CBaseEntity* PTarget, uint16 animId, uint8 type);
};

#endif // _CINDEPENDENTANIMATIONPACKET_H
