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

#pragma once

#include <cstddef>
#include <istream>
#include <memory>
#include <string>
#include <type_traits>

namespace db
{

// A wrapper to ensure the underlying data, the blobstream, and the istream are all alive
// and valid as long as they need to be.
struct BlobWrapper
{
    std::unique_ptr<char[]> data;
    std::size_t             size;

    // https://stackoverflow.com/a/1449527
    class blobstream : public std::streambuf
    {
    public:
        blobstream(char* buffer, std::size_t size);
    };

    blobstream   blobStream;
    std::istream istream;

    template <typename T>
    static auto create(T& source) -> std::shared_ptr<BlobWrapper>;

    BlobWrapper(char* data, std::size_t size);

    auto toString() const -> std::string;
};

//
// Out-of-line template definitions
//

template <typename T>
auto BlobWrapper::create(T& source) -> std::shared_ptr<BlobWrapper>
{
    static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable");
    return std::make_shared<BlobWrapper>(reinterpret_cast<char*>(&source), sizeof(T));
}

} // namespace db
