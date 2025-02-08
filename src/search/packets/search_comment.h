
#ifndef _SEARCH_COMMENT_PACKET_H_
#define _SEARCH_COMMENT_PACKET_H_

#include "common/cbasetypes.h"

#include <array>
#include <string>

class SearchCommentPacket
{
public:
    SearchCommentPacket(uint32 playerId, std::string const& comment);

private:
    std::array<uint8, 204> buffer_{};
};

#endif
