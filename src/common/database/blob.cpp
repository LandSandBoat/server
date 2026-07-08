/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include <common/database/blob.h>

#include <cstring>
#include <string_view>

db::BlobWrapper::blobstream::blobstream(char* buffer, std::size_t size)
{
    setg(buffer, buffer, buffer + size);
}

db::BlobWrapper::BlobWrapper(char* data, std::size_t size)
: data(std::make_unique<char[]>(size))
, size(size)
, blobStream(data, size)
, istream(&blobStream)
{
    // TODO: Do we really need to guarantee that the underlying data
    //     : will outlive the original callsite? We could just get rid of
    //     : data and size and use the two streams.
    std::memcpy(this->data.get(), data, size);
}

auto db::BlobWrapper::toString() const -> std::string
{
    // Escape characters in the blob
    std::string result;
    result.reserve(size * 2); // Reserving space for maximum possible expansion

    for (const char ch : std::string_view(data.get(), size))
    {
        switch (ch)
        {
            case '\0': // Null character
                result += "\\0";
                break;
            case '\'': // Single quote
                result += "\\'";
                break;
            case '\"': // Double quote
                result += "\\\"";
                break;
            case '\b': // Backspace
                result += "\\b";
                break;
            case '\n': // Newline
                result += "\\n";
                break;
            case '\r': // Carriage return
                result += "\\r";
                break;
            case '\t': // Tab
                result += "\\t";
                break;
            case '\x1A': // Ctrl-Z
                result += "\\Z";
                break;
            case '\\': // Backslash
                result += "\\\\";
                break;
            case '%': // Percent (reserved by sprintf, etc.)
                result += "%%";
                break;
            default:
                result += ch;
                break;
        }
    }

    return result;
}
