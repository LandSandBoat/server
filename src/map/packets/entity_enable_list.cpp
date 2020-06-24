#include "../../common/socket.h"

#include "../entities/baseentity.h"

#include "entity_enable_list.h"

CEntityEnableList::CEntityEnableList(std::vector<uint32> list)
{
    this->type = 0x77;
    this->size = 0x88;

    ref<uint32>(0x04) = 1;

    uint32 offset = 0;
    for (auto& value : list)
    {
        ref<uint32>(0x08 + offset) = value;
        offset += 4;
    }
}
