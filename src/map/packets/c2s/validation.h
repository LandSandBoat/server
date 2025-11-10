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

#include "magic_enum/magic_enum.hpp"
#include "zone.h"
#include <format>
#include <set>

enum LSTYPE : std::uint8_t;
class CCharEntity;
class PacketValidationResult
{
public:
    PacketValidationResult()
    : m_Valid(true)
    {
    }

    auto addError(const std::string& error) -> PacketValidationResult&
    {
        m_Errors.push_back(error);
        setValid(false);

        return *this;
    }

    auto valid() const -> bool
    {
        return m_Valid;
    }

    void setValid(const bool valid)
    {
        m_Valid = valid;
    }

    auto errorString() const -> std::string
    {
        std::string errorMessages;
        for (const auto& error : m_Errors)
        {
            if (!errorMessages.empty())
            {
                errorMessages += ", ";
            }

            errorMessages += error;
        }

        return errorMessages;
    }

private:
    bool                     m_Valid;
    std::vector<std::string> m_Errors;
};

class PacketValidator
{
public:
    PacketValidator() = default;

    // Left value must equal right value
    template <typename T1, typename T2>
    auto mustEqual(T1 left, T2 right, const std::string& errMsg) -> PacketValidator&
    {
        const auto rightVal = static_cast<T1>(right);
        if (left != rightVal)
        {
            result_.addError(errMsg);
        }

        return *this;
    }

    // Left value must not equal right value
    template <typename T1, typename T2>
    auto mustNotEqual(T1 left, T2 right, const std::string& errMsg) -> PacketValidator&
    {
        const auto rightVal = static_cast<T1>(right);
        if (left == rightVal)
        {
            result_.addError(errMsg);
        }

        return *this;
    }

    // Inclusive range check
    template <typename T, typename MinT, typename MaxT>
    auto range(const std::string& fieldName, T value, MinT min, MaxT max) -> PacketValidator&
    {
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
        static_assert(std::is_enum_v<E>, "Template parameter E must be an enum");

        if (!magic_enum::enum_contains<E>(value))
        {
            constexpr std::string_view enumTypeName    = magic_enum::enum_type_name<E>();
            auto                       underlyingValue = static_cast<std::underlying_type_t<E>>(value);
            result_.addError(std::format("{} not a valid {} value.", underlyingValue, enumTypeName));
        }

        return *this;
    }

    // Character must not be crafting
    auto isNotCrafting(const CCharEntity* PChar) -> PacketValidator&;
    // Character current status must be NORMAL
    auto isNormalStatus(const CCharEntity* PChar) -> PacketValidator&;
    // Character must not have any status effect preventing action (Sleep, Stun, Terror etc..)
    auto isNotPreventedAction(const CCharEntity* PChar) -> PacketValidator&;
    // Character is not assuming a Monstrosity form
    auto isNotMonstrosity(const CCharEntity* PChar) -> PacketValidator&;
    // Character must be in a valid event state, with optional eventId check.
    auto isInEvent(const CCharEntity* PChar, std::optional<uint16_t> eventId = std::nullopt) -> PacketValidator&;
    // Character must have necessary rank in the linkshell in the given slot
    auto hasLinkshellRank(const CCharEntity* PChar, uint8_t slot, LSTYPE rank) -> PacketValidator&;
    // Character zone must allow specified flag. GMs can bypass this check.
    auto hasZoneMiscFlag(const CCharEntity* PChar, ZONEMISC flag) -> PacketValidator&;
    // Character must be the party leader
    auto isPartyLeader(const CCharEntity* PChar) -> PacketValidator&;
    // Character must be the alliance leader
    auto isAllianceLeader(const CCharEntity* PChar) -> PacketValidator&;
    // Character must not be fishing
    auto isNotFishing(const CCharEntity* PChar) -> PacketValidator&;

    // Custom validation function
    template <typename Func>
    auto custom(Func customValidation) -> PacketValidator&
    {
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
    PacketValidationResult result_;
};
