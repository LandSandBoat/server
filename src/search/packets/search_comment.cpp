
#include "search_comment.h"

#include "common/logging.h"
#include "common/utils.h"

SearchCommentPacket::SearchCommentPacket(uint32 playerId, std::string const& comment)
{
    ref<uint8>(buffer_.data(), 0x08) = 154;  // Search comment packet size
    ref<uint8>(buffer_.data(), 0x0A) = 0x80; // Search server packet
    ref<uint8>(buffer_.data(), 0x0B) = 0x88; // Packet type

    ref<uint8>(buffer_.data(), 0x0E) = 0x01;

    ref<uint32>(buffer_.data(), 0x18) = playerId;

    ref<uint16>(buffer_.data(), 0x1C) = 124; // Comment length

    // Add comment bytes
    std::memcpy(&buffer_.data()[0x1E], comment.c_str(), comment.length());

    // Fill rest with whitespace
    std::memset(&buffer_.data()[0x1E + comment.length()], ' ', 123 - comment.length());

    // End comment with 0 byte
    buffer_.data()[0x9A] = 0;
}
