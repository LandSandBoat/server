
#ifndef _SEARCH_COMMENT_PACKET_H_
#define _SEARCH_COMMENT_PACKET_H_

#include "common/cbasetypes.h"
#include <string>

class SearchCommentPacket
{
public:
    SearchCommentPacket(uint32 playerId, std::string const& comment);

    uint8* GetData();
    uint16 GetSize();

private:
    uint8 data[204]{};
};

#endif
