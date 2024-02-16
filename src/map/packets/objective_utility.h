#ifndef _COBJECTIVEUTILITYPACKET_H
#define _COBJECTIVEUTILITYPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

#include <string>

enum OBJECTIVEUTILITY_TYPE : uint8
{
    OBJECTIVEUTILITY_COUNTDOWN = 0x01,
    OBJECTIVEUTILITY_PROGRESS  = 0x02,
    OBJECTIVEUTILITY_HELP      = 0x04,
    OBJECTIVEUTILITY_FENCE     = 0x08
};

class CObjectiveUtilityPacket : public CBasicPacket
{
public:
    CObjectiveUtilityPacket();

    void addCountdown(uint32 duration, uint32 warning = 0);
    void addBars(std::vector<std::pair<std::string, uint32>>&& bars);
    void addFence(float x, float y, float radius, float render, bool blue = false);
    void addHelpText(uint16 title, uint16 description);
};

#endif
