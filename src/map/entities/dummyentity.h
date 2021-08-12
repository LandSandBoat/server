#ifndef _CHARDUMMYENTITY_H
#define _CHARDUMMYENTITY_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

#include "charentity.h"

#include "../ai/helpers/pathfind.h"

#include <bitset>
#include <deque>
#include <map>
#include <mutex>
#include <unordered_map>

class CDummyEntity : public CCharEntity
{
public:
    CDummyEntity(CCharEntity* PChar);
    ~CDummyEntity();

    void Tick(time_point tick) override;
    void PostTick() override;

    position_t targetLocation;
    std::unique_ptr<CPathFind> PathFind;

    // All packet operations should be NOOP
    void clearPacketList() override{};
    void pushPacket(CBasicPacket* packet) override
    {
        delete packet;
    };
    bool isPacketListEmpty() override
    {
        return true;
    };
    auto popPacket() -> CBasicPacket* override
    {
        return nullptr;
    };
    auto getPacketList() -> PacketList_t override
    {
        return {};
    };
    auto getPacketCount() -> size_t override
    {
        return 0;
    };
    void erasePackets(uint8 num) override{};
};

#endif
