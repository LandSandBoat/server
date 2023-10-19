#ifndef _PACKETGUARD_H
#define _PACKETGUARD_H

#include "common/cbasetypes.h"
#include "packet_system.h"
#include "packets/basic.h"

class CCharEntity;

namespace PacketGuard
{
    void Init();
    bool PacketIsValidForPlayerState(CCharEntity* PChar, uint16 SmallPD_Type);
    bool IsRateLimitedPacket(CCharEntity* PChar, uint16 SmallPD_Type);
    void PrintPacketList(CCharEntity* PChar);

    auto GetPacketAllowList() -> std::unordered_map<CHAR_SUBSTATE, std::unordered_map<uint16, bool>>&;
} // namespace PacketGuard

#endif // _PACKETGUARD_H
