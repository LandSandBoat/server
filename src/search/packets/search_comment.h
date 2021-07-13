
#ifndef _SEARCH_COMMENT_PACKET_H_
#define _SEARCH_COMMENT_PACKET_H_

#include <string>
#include "../../common/cbasetypes.h"

class SearchCommentPacket
{
public:

    SearchCommentPacket(uint32 playerId, std::string comment);

    uint8* GetData();
    uint16 GetSize();

private:

    uint8 data[204];
};

#endif
