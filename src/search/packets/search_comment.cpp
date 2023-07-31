
#include "search_comment.h"

#include "common/logging.h"
#include "common/socket.h"
#include "common/utils.h"

SearchCommentPacket::SearchCommentPacket(uint32 playerId, std::string const& comment)
{
    ref<uint8>(data, 0x08) = 154;  // Search comment packet size
    ref<uint8>(data, 0x0A) = 0x80; // Search server packet
    ref<uint8>(data, 0x0B) = 0x88; // Packet type

    ref<uint8>(data, 0x0E) = 0x01;

    ref<uint32>(data, 0x18) = playerId;

    ref<uint16>(data, 0x1C) = 124; // Comment length

    // Add comment bytes
    memcpy(&data[0x1E], comment.c_str(), comment.length());

    // Fill rest with whitespace
    memset(&data[0x1E + comment.length()], ' ', 123 - comment.length());

    // End comment with 0 byte
    data[0x9A] = 0;
}

uint8* SearchCommentPacket::GetData()
{
    return data;
}

uint16 SearchCommentPacket::GetSize()
{
    return 204;
}
