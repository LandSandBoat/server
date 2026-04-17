/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "common/cbasetypes.h"
#include "enums/blocked_state.h"
#include "enums/packet_c2s.h"
#include "magic_enum/magic_enum.hpp"
#include "zone.h"
#include <fmt/ranges.h>
#include <format>
#include <set>

enum LSTYPE : std::uint8_t;
enum class KeyItem : uint16_t;
class CCharEntity;

class PacketValidationResult
{
public:
    PacketValidationResult()
    : valid_(true)
    {
    }

    auto addError(std::string error) -> PacketValidationResult&
    {
        errors_.push_back(std::move(error));
        valid_ = false;

        return *this;
    }

    auto valid() const -> bool
    {
        return valid_;
    }

    auto errorString() const -> std::string
    {
        return fmt::format("{}", fmt::join(errors_, ", "));
    }

private:
    bool                     valid_;
    std::vector<std::string> errors_;
};

class PacketValidator
{
public:
    explicit PacketValidator(const CCharEntity* PChar)
    : PChar_(PChar)
    {
    }

    // Left value must equal right value
    template <typename T1, typename T2>
    auto mustEqual(T1 left, T2 right, const std::string& errMsg) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }

        if (left != static_cast<T1>(right))
        {
            result_.addError(errMsg);
        }

        return *this;
    }

    // Left value must not equal right value
    template <typename T1, typename T2>
    auto mustNotEqual(T1 left, T2 right, const std::string& errMsg) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }

        if (left == static_cast<T1>(right))
        {
            result_.addError(errMsg);
        }

        return *this;
    }

    // Inclusive range check
    template <typename T, typename MinT, typename MaxT>
    auto range(const std::string& fieldName, T value, MinT min, MaxT max) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }
        const auto val    = value;
        const auto minVal = static_cast<T>(min);
        const auto maxVal = static_cast<T>(max);

        if (val < minVal || val > maxVal)
        {
            result_.addError(std::format("{} out of range: {} not in [{}, {}]",
                                         fieldName,
                                         val,
                                         minVal,
                                         maxVal));
        }

        return *this;
    }

    // Value must be a multiple of divisor
    template <typename T, typename DivT>
    auto multipleOf(const std::string& fieldName, T value, DivT divisor) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }
        const auto divVal = static_cast<T>(divisor);
        if (value % divVal != 0)
        {
            result_.addError(std::format("{} is not a multiple of {}.", fieldName, divVal));
        }

        return *this;
    }

    // Value must be in the set of allowed values
    template <typename T>
    auto oneOf(const std::string& fieldName, T value, const std::set<T>& container) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }

        if (!container.contains(value))
        {
            if constexpr (std::is_enum_v<T>)
            {
                result_.addError(std::format("{} value {} is not allowed.", fieldName, static_cast<std::underlying_type_t<T>>(value)));
            }
            else
            {
                result_.addError(std::format("{} value {} is not allowed.", fieldName, value));
            }
        }

        return *this;
    }

    // Value must be contained in the enum class
    // This handles comparing base types to enum values
    template <typename E>
    auto oneOf(const std::underlying_type_t<E> value) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }
        static_assert(std::is_enum_v<E>, "Template parameter E must be an enum");

        if (!magic_enum::enum_contains<E>(value))
        {
            constexpr std::string_view enumTypeName = magic_enum::enum_type_name<E>();
            result_.addError(std::format("{} not a valid {} value.", value, enumTypeName));
        }

        return *this;
    }

    // Value must be contained in the enum class
    // This handles comparing enum values to enum values
    template <typename E>
    auto oneOf(const E value) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }
        static_assert(std::is_enum_v<E>, "Template parameter E must be an enum");

        if (!magic_enum::enum_contains<E>(value))
        {
            constexpr std::string_view enumTypeName    = magic_enum::enum_type_name<E>();
            auto                       underlyingValue = static_cast<std::underlying_type_t<E>>(value);
            result_.addError(std::format("{} not a valid {} value.", underlyingValue, enumTypeName));
        }

        return *this;
    }

    // Reject if the player is in any of the specified states
    auto blockedBy(magic_enum::containers::bitset<BlockedState> states) -> PacketValidator&;
    // Character must be in a valid event state, with optional eventId check.
    auto isInEvent(Maybe<uint16_t> eventId = std::nullopt) -> PacketValidator&;
    // Character must have necessary rank in the linkshell in the given slot
    auto hasLinkshellRank(uint8_t slot, LSTYPE rank) -> PacketValidator&;
    // Character zone must allow specified flag. GMs can bypass this check.
    auto hasZoneMiscFlag(ZONEMISC flag) -> PacketValidator&;
    // Character must be the party leader
    auto isPartyLeader() -> PacketValidator&;
    // Character must be the alliance leader
    auto isAllianceLeader() -> PacketValidator&;
    // Character must be engaged in combat
    auto isEngaged() -> PacketValidator&;
    // Character must be in Mog House
    auto isInMogHouse() -> PacketValidator&;
    // Character must have a specific key item
    auto hasKeyItem(KeyItem keyItemId) -> PacketValidator&;
    // The previous packet received from this character must match the expected packet ID
    auto requiresPriorPacket(PacketC2S expectedPacketId) -> PacketValidator&;

    // Custom validation function
    template <typename Func>
    auto custom(Func customValidation) -> PacketValidator&
    {
        if (!result_.valid())
        {
            return *this;
        }

        customValidation(*this);
        return *this;
    }

    operator PacketValidationResult() &&
    {
        return std::move(result_);
    }

    operator PacketValidationResult() const&
    {
        return result_;
    }

private:
    const CCharEntity*     PChar_;
    PacketValidationResult result_;
};

#define CHECK_BLOCKED(flag, condition)                                                   \
    if (states.test(flag) && (condition))                                                \
    {                                                                                    \
        result_.addError(std::format("Invalid state: {}", magic_enum::enum_name(flag))); \
        return *this;                                                                    \
    }
