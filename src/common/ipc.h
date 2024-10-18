/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include <cstdint>
#include <optional>
#include <span>
#include <string>
#include <type_traits>
#include <vector>

#include "ipc_structs.h"
#include "ipc_stubs.h"

#include <alpaca/alpaca.h>

namespace ipc
{
    // Forward declarations
    enum class MessageType : uint8_t;

    template <typename T>
    MessageType getEnumType();

    // Helpers
    template <typename T>
    auto toBytes(const T& object) -> std::vector<uint8_t>
    {
        auto bytes         = std::vector<uint8_t>();
        auto bytes_written = alpaca::serialize(object, bytes);

        const auto type = static_cast<uint8_t>(getEnumType<T>());

        std::vector<uint8_t> message(1 + bytes_written);
        message[0] = type;
        std::memcpy(message.data() + 1, bytes.data(), bytes_written);

        return message;
    }

    template <typename T>
    auto fromBytes(const std::vector<uint8_t>& message) -> std::optional<T>
    {
        if (message.empty())
        {
            return std::nullopt;
        }

        const auto type = static_cast<MessageType>(message[0]);
        if (type != getEnumType<T>())
        {
            return std::nullopt;
        }

        const auto bytes = std::span(message.data() + 1, message.size() - 1);

        auto ec     = std::error_code{};
        auto object = alpaca::deserialize<T>(bytes, ec);
        if (ec)
        {
            return std::nullopt;
        }

        return std::move(object);
    }

    // Message handler implementation
    class IPCMessageHandler : public IIPCMessageHandler
    {
    private:
        // Don't handle this message type if we get it
        void handleMessage_SomeData(const SomeData& message) override = default;
    };
} // namespace ipc
