#include "../../common/socket.h"

#include "timer_bar_util.h"

#include "../entities/charentity.h"

CTimerBarUtilPacket::CTimerBarUtilPacket(CCharEntity* PChar)
{
    this->type = 0x75;
    this->size = 0x56;
}

void CTimerBarUtilPacket::addCountdown(uint32 seconds)
{
    // Non-zero shows timer, zero hides it
    ref<uint16>(0x04) = 0xFFFF;

    ref<uint32>(0x08) = CVanaTime::getInstance()->getVanaTime();
    ref<uint32>(0x0C) = seconds;

    // Static data ("_unknown1" in Windower fields)
    ref<uint8>(0x10) = 0x3C;
    ref<uint8>(0x24) = 0x03;
}

void CTimerBarUtilPacket::addBar1(std::string name, uint8 value)
{
    ref<uint8>(0x28) = value;

    for (size_t i = 0; i < name.size(); ++i)
    {
        ref<char>(0x2C + i) = name.at(i);
    }
}

void CTimerBarUtilPacket::addBar2(std::string name, uint8 value)
{
    ref<uint8>(0x3C) = value;

    for (size_t i = 0; i < name.size(); ++i)
    {
        ref<char>(0x40 + i) = name.at(i);
    }
}

void CTimerBarUtilPacket::addBattlefieldRadius(uint32 distance)
{
    ref<uint8>(0x1C) = distance;
}

void CTimerBarUtilPacket::addRenderRadius(uint32 distance)
{
    ref<uint8>(0x20) = distance;
}
