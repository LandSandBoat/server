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

#include "enums/prof_error.h"
#include "protocol/bytes.h"
#include "protocol/codec.h"
#include "protocol/profile/s2c/prof_recv_ans.h"

#include "common/cbasetypes.h"
#include "common/types/maybe.h"

#include <span>
#include <vector>

namespace profile
{

constexpr uint8 openAnswerCode = 0x81;
constexpr uint8 answerCode     = 0x83;

template <typename T>
concept Sealed = requires(T object) { object.checksum; };

// a request's last u32 is the checksum of the bytes before it
inline auto hasTrailingChecksum(const std::span<const uint8> bytes) -> bool
{
    return bytes.size() >= sizeof(uint32) && fromBytes<uint32>(bytes.last(sizeof(uint32))) == checksum(bytes.first(bytes.size() - sizeof(uint32)));
}

// exact size, checksum verified if it has one
template <typename T>
auto parse(const std::span<const uint8> body) -> Maybe<T>
{
    if constexpr (Sealed<T>)
    {
        if (!hasTrailingChecksum(body))
        {
            return std::nullopt;
        }
    }

    return fromBytes<T>(body);
}

// size and inline checksums are filled in as objects are added
class ProfileAnswer
{
public:
    explicit ProfileAnswer(const ProfError error = ProfError::None)
    : error_(error)
    {
    }

    // running sum of everything before it
    template <typename T>
    auto add(T object) -> ProfileAnswer&
    {
        if constexpr (Sealed<T>)
        {
            object.checksum = sum_ + checksum(asBytes(object).first(sizeof(T) - sizeof(uint32)));
        }

        return addBytes(asBytes(object));
    }

    auto addAll(const auto& objects) -> ProfileAnswer&
    {
        for (const auto& object : objects)
        {
            add(object);
        }

        return *this;
    }

    auto addBytes(const std::span<const uint8> bytes) -> ProfileAnswer&
    {
        body_.insert(body_.end(), bytes.begin(), bytes.end());
        sum_ += checksum(bytes);
        return *this;
    }

    auto addChecksum() -> ProfileAnswer&
    {
        const auto sum = sum_;
        return addBytes(asBytes(sum));
    }

    auto head() const -> ProfRecvAns
    {
        return {
            .code  = answerCode,
            .error = error_,
            .size  = static_cast<uint32>(body_.size()),
        };
    }

    auto body() const -> const std::vector<uint8>&
    {
        return body_;
    }

private:
    ProfError          error_;
    std::vector<uint8> body_;
    uint32             sum_{};
};

} // namespace profile
