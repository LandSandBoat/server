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

#include "irc/irc_session.h"

#include "data/accounts.h"
#include "irc/presence_manager.h"
#include "protocol/codec.h"
#include "protocol/irc/notices.h"

#include "common/logging.h"

#include <asio/read_until.hpp>
#include <asio/write.hpp>

#include <algorithm>
#include <array>
#include <bit>
#include <chrono>
#include <ranges>
#include <vector>

namespace profile
{

namespace
{

using namespace std::chrono_literals;

// polcore times out after 400s of silence
constexpr auto kKeepaliveInterval = 60s;
constexpr auto kLoginDeadline     = 30s;
constexpr auto kLineLimit         = 0x1000;
constexpr auto kOutboxLimit       = 1024; // lines

// splits a line into words, skipping the :prefix
auto tokens(std::string_view line) -> std::vector<std::string_view>
{
    if (line.starts_with(':'))
    {
        line.remove_prefix(std::min(line.size(), line.find(' ')));
    }

    auto result = std::vector<std::string_view>{};
    for (const auto token : line | std::views::split(' '))
    {
        if (!token.empty())
        {
            result.emplace_back(token.begin(), token.end());
        }
    }

    return result;
}

// login time, client IP and port, base32 encoded
auto challenge(const Stream& stream) -> std::string
{
    auto blob = std::array<uint8, 25>{};

    const auto now     = static_cast<uint32>(std::chrono::system_clock::to_time_t(std::chrono::system_clock::now()));
    const auto address = stream.lowest_layer().remote_endpoint().address().to_v4().to_bytes();
    const auto port    = stream.lowest_layer().local_endpoint().port();
    std::ranges::copy(std::bit_cast<std::array<uint8, 4>>(std::byteswap(now)), blob.begin());
    std::ranges::copy(address, blob.begin() + 4);
    std::ranges::copy(std::bit_cast<std::array<uint8, 2>>(std::byteswap(port)), blob.begin() + 0x14);
    return base32Encode(blob);
}

} // namespace

IrcSession::IrcSession(Stream stream, std::string peer, const accounts::Credential& credential, PresenceManager& presence)
: stream_(std::move(stream))
, peer_(std::move(peer))
, credential_(credential)
, presence_(presence)
, wake_(stream_.get_executor())
{
}

void IrcSession::signOff()
{
    if (signOnId_ == 0)
    {
        return;
    }

    try
    {
        presence_.signOff(credential_.accountId, signOnId_);

        // gives the client two hours to reconnect
        accounts::refresh(credential_.accountId, credential_.sessionHash);
        ShowInfoFmt("{} account {} signed off", peer_, credential_.accountId);
    }
    catch (const std::exception& e)
    {
        ShowErrorFmt("account {} sign off failed: {}", credential_.accountId, e.what());
    }
}

auto IrcSession::run() -> Task<void>
{
    using namespace asio::experimental::awaitable_operators;

    send(":srv NOTICE AUTH " + challenge(stream_));

    co_await (readLoop() || writeLoop());
    close();
}

auto IrcSession::readLoop() -> Task<void>
{
    const auto loginBy = std::chrono::steady_clock::now() + kLoginDeadline;

    auto idle = false;
    while (stream_.lowest_layer().is_open())
    {
        auto deadline = std::chrono::steady_clock::duration(kKeepaliveInterval);
        if (signOnId_ == 0)
        {
            deadline = loginBy - std::chrono::steady_clock::now();
        }

        const auto line = co_await Scheduler::withTimeout(readLine(), deadline);
        if (!line.has_value())
        {
            // never signed in, or didn't answer the last PING
            if (signOnId_ == 0 || idle)
            {
                break;
            }

            idle = true;
            send("PING :x");
            continue;
        }

        idle = false;
        if (!line->has_value() || !handle(**line))
        {
            break;
        }
    }
}

auto IrcSession::writeLoop() -> Task<void>
{
    while (true)
    {
        if (outbox_.empty())
        {
            wake_.expires_at(asio::steady_timer::time_point::max());
            co_await wake_.async_wait(asio::as_tuple(asio::use_awaitable));
            continue;
        }

        const auto line = std::move(outbox_.front());
        outbox_.pop_front();

        const auto result = co_await Scheduler::withTimeout(asio::async_write(stream_, asio::buffer(line), asio::as_tuple(asio::use_awaitable)), kKeepaliveInterval);
        if (!result || std::get<0>(*result))
        {
            co_return;
        }
    }
}

void IrcSession::send(const std::string_view message)
{
    DebugIRCFmt("{} account {} -> {}", peer_, credential_.accountId, message);

    auto line = std::string(message) + lineChecksum(message) + "\r\n";
    if (outbox_.size() >= kOutboxLimit)
    {
        ShowWarningFmt("{} stopped reading, closing", peer_);
        close();
        return;
    }

    outbox_.push_back(std::move(line));
    wake_.cancel();
}

void IrcSession::close()
{
    auto ignored = asio::error_code{};
    stream_.lowest_layer().close(ignored);
    outbox_.clear();
    wake_.cancel();
}

auto IrcSession::handle(const std::string_view line) -> bool
{
    DebugIRCFmt("{} account {} <- {}", peer_, credential_.accountId, line);

    const auto command = tokens(line);
    if (command.empty())
    {
        return true;
    }

    if (command[0] == "USER")
    {
        // the key in 300 is unused since xiloader disables the cipher
        if (!keyed_)
        {
            send(":srv 300 * " + base64Encode(std::array<uint8, 32>{}));
            keyed_ = true;
        }

        return true;
    }

    if (command[0] == "NICK")
    {
        // only once, after USER
        if (!keyed_ || signOnId_ != 0 || command.size() < 2)
        {
            return true;
        }

        login(command[1]);
        return true;
    }

    // polcore ignores the PONG argument
    if (command[0] == "PING")
    {
        send("PONG a");
        return true;
    }

    if (command[0] == "QUIT")
    {
        return false;
    }

    return true;
}

// NICK U<scrambled pol id>:<digest>:<client info>; the relay already vouched for the account
void IrcSession::login(const std::string_view argument)
{
    const auto nick = argument.substr(0, argument.find(':'));

    accounts::refresh(credential_.accountId, credential_.sessionHash);

    const auto udpPortSlot = accounts::udpPortSlot(credential_);
    ShowInfoFmt("{} account {} signed on, udp port slot {}", peer_, credential_.accountId, udpPortSlot);

    send(fmt::format(":srv 422 {} :no motd", nick));
    send(fmt::format(":{}!p@pol NOTICE {} :{}", scrambleNick(1), nick, profileAvailableNotice(udpPortSlot)));
    signOnId_ = presence_.signOn(credential_.accountId, credential_.sessionHash, this);
}

// returns a line without its checksum, dropping lines that fail it
auto IrcSession::readLine() -> Task<Maybe<std::string>>
{
    while (true)
    {
        const auto [ec, length] = co_await asio::async_read_until(stream_, asio::dynamic_buffer(input_, kLineLimit), '\n', asio::as_tuple(asio::use_awaitable));
        if (ec)
        {
            co_return std::nullopt;
        }

        auto line = input_.substr(0, length);
        input_.erase(0, length);
        while (!line.empty() && (line.back() == '\n' || line.back() == '\r'))
        {
            line.pop_back();
        }

        if (line.size() < 4)
        {
            continue;
        }

        auto message = line.substr(0, line.size() - 4);
        if (keyed_ && lineChecksum(message) != line.substr(line.size() - 4))
        {
            DebugIRCFmt("{} dropped a line with a bad checksum: {}", peer_, line);
            continue;
        }

        co_return message;
    }
}

auto runIrcSession(Stream stream, std::string peer, const accounts::Credential credential, PresenceManager& presence) -> Task<void>
{
    auto session = IrcSession(std::move(stream), peer, credential, presence);
    try
    {
        co_await session.run();
    }
    catch (const std::exception& e)
    {
        ShowWarningFmt("{} session error: {}", peer, e.what());
    }

    // not in the destructor, presence may already be gone at shutdown
    session.signOff();
}

} // namespace profile
