#ifndef _CENTITYENABLELISTPACKET_H
#define _CENTITYENABLELISTPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

#include <vector>

class CEntityEnableList : public CBasicPacket
{
public:
    CEntityEnableList(const std::vector<uint32>& list);
};

#endif // _CENTITYENABLELISTPACKET_H
