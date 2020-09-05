#ifndef _CINDEPENDANTANIMATIONPACKET_H
#define _CINDEPENDANTANIMATIONPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CBaseEntity;

// This is sometimes sent along with an Action Message packet, to provide an animation for an action message.
class CIndependantAnimationPacket : public CBasicPacket
{
public:
    CIndependantAnimationPacket(CBaseEntity* PEntity, CBaseEntity* PTarget, uint16 animId, uint8 type);
};

#endif // _CINDEPENDANTANIMATIONPACKET_H
