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

#include "map_socket.h"

#include <common/logging.h>
#include <common/scheduler.h>
#include <common/tracy.h>
#include <common/types/error_or.h>

#include <map/map_constants.h>
#include <map/map_statistics.h>

#include <asio/io_context.hpp>
#include <asio/ip/udp.hpp>
#include <asio/post.hpp>
#include <asio/socket_base.hpp>
#include <asio/ts/buffer.hpp>

#include <rigtorp/SPSCQueue.h>

#include <algorithm>
#include <atomic>
#include <cstring>
#include <mutex>
#include <set>
#include <stop_token>
#include <system_error>
#include <thread>

namespace
{

constexpr auto kIngressRingCapacity = 4096uz;
constexpr auto kEgressRingCapacity  = 4096uz;

constexpr auto kSocketBufferBytes = 4 * 1024 * 1024;

// A single datagram parked in a ring. Fixed-size so slots never allocate. Constructed
// in-place in the ring slot via SPSCQueue::try_emplace, copying the payload exactly once.
// TODO: Should we bother with a no-copy design at some point? It's such a small memcpy...
struct Datagram
{
    Datagram(const IPP& ipp, ByteSpan bytes)
    : ipp(ipp)
    , length(static_cast<uint16>(std::min<std::size_t>(bytes.size(), kMaxBufferSize)))
    , data{}
    {
        std::memcpy(data.data(), bytes.data(), length);
    }

    IPP           ipp;
    uint16        length;
    NetworkBuffer data;
};

auto endpointToIPP(const asio::ip::udp::endpoint& endpoint) -> IPP
{
    // NOTE: ASIO returns the address in host byte order, but we store it in network byte
    //     : order, so we convert it back.
    const auto ip   = htonl(endpoint.address().to_v4().to_uint());
    const auto port = endpoint.port();
    return IPP(ip, port);
}

auto ippToEndpoint(const IPP& ipp) -> asio::ip::udp::endpoint
{
    // Inverse of endpointToIPP(): ASIO wants host byte order, we store network byte order.
    const auto ip = ntohl(ipp.getIP());
    return asio::ip::udp::endpoint(asio::ip::address_v4(ip), ipp.getPort());
}

} // namespace

struct MapSocket::Impl
{
    using Key = MapStatistics::Key;

    Impl(Scheduler& scheduler, MapStatistics& mapStatistics, uint16 port, Socket::ReceiveFn onReceiveFn);
    ~Impl();

    DISALLOW_COPY_AND_MOVE(Impl);

    //
    // Ingress: network thread -> main thread
    //

    void armReceive();
    void scheduleMainDrain();
    void drainIngress();

    //
    // Egress: main thread -> network thread
    //

    void send(const IPP& ipp, ByteSpan buffer);
    void drainEgress();
    auto sendOne(const Datagram& d) -> ErrorOr<std::size_t, std::error_code>;
    void recordSendError(const std::error_code& ec);

    //
    // Diagnostics
    //

    void flushDiagnostics();

    //
    // Members
    //

    Scheduler&     scheduler_;
    MapStatistics& mapStatistics_;
    ReceiveFn      onReceiveFn_;
    uint16         port_;

    // The network thread owns this context and the socket bound to it. The main thread never
    // touches the socket; it only posts onto netContext_ (thread-safe) to wake the drain.
    asio::io_context        netContext_;
    asio::ip::udp::socket   socket_;
    asio::ip::udp::endpoint remoteEndpoint_; // network thread only

    rigtorp::SPSCQueue<Datagram> ingress_; // net produces, main consumes
    rigtorp::SPSCQueue<Datagram> egress_;  // main produces, net consumes

    // Network thread only: ASIO receives into this, then the bytes are copied into an ingress slot.
    // TODO: Could we be pooling and swapping ingress slot buffers out, so that each packet owns
    //     : it's own buffer for the whole operation, then returns it to the pool?
    NetworkBuffer recvBuffer_{};

    //
    // Stats
    //

    std::atomic<bool> ingressDrainScheduled_{ false };
    std::atomic<bool> egressDrainScheduled_{ false };

    std::atomic<int64> ingressDropped_{ 0 };
    std::atomic<int64> recvErrors_{ 0 };
    std::atomic<int64> egressDropped_{ 0 };
    std::atomic<int64> egressBlocked_{ 0 };
    std::atomic<int64> egressErrors_{ 0 };
    std::atomic<int64> egressBytesSent_{ 0 };
    std::atomic<int64> maxEgressDepth_{ 0 };

    std::mutex                diagMutex_; // guards the reason sets (touched only on the error path)
    std::set<std::error_code> blockedReasons_;
    std::set<std::error_code> droppedReasons_;

    // Declared last so it is destroyed first
    std::jthread netThread_;
};

MapSocket::Impl::Impl(Scheduler& scheduler, MapStatistics& mapStatistics, const uint16 port, Socket::ReceiveFn onReceiveFn)
: scheduler_(scheduler)
, mapStatistics_(mapStatistics)
, onReceiveFn_(std::move(onReceiveFn))
, port_(port)
, netContext_()
, socket_(netContext_)
, ingress_(kIngressRingCapacity)
, egress_(kEgressRingCapacity)
{
    TracyZoneScoped;

    ShowInfoFmt("MapSocket: Starting on port {}", port_);

    asio::ip::udp::endpoint listenEndpoint(asio::ip::udp::v4(), port_);
    socket_.open(listenEndpoint.protocol());
    socket_.bind(listenEndpoint);

    std::error_code ec;

    socket_.set_option(asio::socket_base::receive_buffer_size(kSocketBufferBytes), ec);
    if (ec)
    {
        ShowWarningFmt("MapSocket: failed to set receive buffer to {} bytes: {}", kSocketBufferBytes, ec.message());
    }

    socket_.set_option(asio::socket_base::send_buffer_size(kSocketBufferBytes), ec);
    if (ec)
    {
        ShowWarningFmt("MapSocket: failed to set send buffer to {} bytes: {}", kSocketBufferBytes, ec.message());
    }

    socket_.non_blocking(true, ec);
    if (ec)
    {
        ShowErrorFmt("MapSocket: failed to set socket non-blocking, usage will BLOCK: {}", ec.message());
    }

    // Prime the receive loop before the thread starts pumping
    armReceive();

    netThread_ = std::jthread(
        [this](const std::stop_token& stopToken)
        {
            TracySetThreadName("Map Network Thread");
            const auto stopOnRequest = std::stop_callback(
                stopToken,
                [this]()
                {
                    netContext_.stop();
                });
            netContext_.run();
        });
}

MapSocket::Impl::~Impl()
{
    TracyZoneScoped;

    netThread_.request_stop();
    if (netThread_.joinable())
    {
        netThread_.join();
    }

    std::error_code ec;
    socket_.close(ec);
}

//
// Ingress: network thread -> main thread
//

void MapSocket::Impl::armReceive()
{
    socket_.async_receive_from(
        asio::buffer(recvBuffer_), remoteEndpoint_, [this](const std::error_code& ec, std::size_t bytesRecvd)
        {
            if (!ec && bytesRecvd > 0)
            {
                if (ingress_.try_emplace(endpointToIPP(remoteEndpoint_), ByteSpan(recvBuffer_.data(), bytesRecvd)))
                {
                    scheduleMainDrain();
                }
                else
                {
                    ingressDropped_.fetch_add(1, std::memory_order_relaxed);
                }
            }
            else if (ec && ec != asio::error::operation_aborted)
            {
                recvErrors_.fetch_add(1, std::memory_order_relaxed);
            }

            // operation_aborted means the socket was closed during shutdown; stop re-arming.
            if (socket_.is_open())
            {
                armReceive();
            }
        });
}

void MapSocket::Impl::scheduleMainDrain()
{
    bool expected = false;
    if (ingressDrainScheduled_.compare_exchange_strong(expected, true, std::memory_order_acq_rel))
    {
        if (!scheduler_.closeRequested())
        {
            scheduler_.postToMainThread(
                [this]()
                {
                    drainIngress();
                });
        }
    }
}

void MapSocket::Impl::drainIngress()
{
    TracyZoneScoped;

    ingressDrainScheduled_.store(false, std::memory_order_release);

    while (Datagram* d = ingress_.front())
    {
        // onReceiveFn_ copies out of the span synchronously, so pointing at the ring slot for
        // the duration of the call is safe; pop() only frees it afterwards.
        onReceiveFn_(ByteSpan(d->data.data(), d->length), d->ipp);
        ingress_.pop();
    }
}

//
// Egress: main thread -> network thread
//

void MapSocket::Impl::send(const IPP& ipp, ByteSpan buffer)
{
    TracyZoneScoped;

    // try_emplace constructs the datagram directly in the ring slot, copying the payload
    // exactly once. Fails (no overwrite) when the main thread is outrunning the network
    // thread's drain; drop (UDP) and count.
    if (!egress_.try_emplace(ipp, buffer))
    {
        egressDropped_.fetch_add(1, std::memory_order_relaxed);
        return;
    }

    // Track high-water queue depth as the egress backpressure signal.
    const auto depth = static_cast<int64>(egress_.size());
    auto       prev  = maxEgressDepth_.load(std::memory_order_relaxed);
    while (depth > prev && !maxEgressDepth_.compare_exchange_weak(prev, depth, std::memory_order_relaxed))
    {
    }

    // Coalesced wake, same shape as the ingress side.
    bool expected = false;
    if (egressDrainScheduled_.compare_exchange_strong(expected, true, std::memory_order_acq_rel))
    {
        asio::post(
            netContext_,
            [this]()
            {
                drainEgress();
            });
    }
}

void MapSocket::Impl::drainEgress()
{
    TracyZoneScoped;

    egressDrainScheduled_.store(false, std::memory_order_release);

    while (Datagram* d = egress_.front())
    {
        if (const auto result = sendOne(*d); result)
        {
            egressBytesSent_.fetch_add(static_cast<int64>(*result), std::memory_order_relaxed);
        }
        else
        {
            recordSendError(result.error());
        }
        egress_.pop();
    }
}

auto MapSocket::Impl::sendOne(const Datagram& d) -> ErrorOr<std::size_t, std::error_code>
{
    const auto endpoint = ippToEndpoint(d.ipp);

    std::error_code ec;
    const auto      bytesSent = socket_.send_to(asio::buffer(d.data.data(), d.length), endpoint, 0, ec);

    if (ec)
    {
        return Error(ec);
    }
    return bytesSent;
}

void MapSocket::Impl::recordSendError(const std::error_code& ec)
{
    // ENOBUFS/EWOULDBLOCK (WSAENOBUFS/WSAEWOULDBLOCK on Windows): the OS couldn't accept the
    // datagram right now, i.e. the send path is backing up. Everything else is a real error.
    // Either way the datagram is dropped (UDP).
    if (ec == asio::error::no_buffer_space ||
        ec == asio::error::would_block ||
        ec == asio::error::try_again)
    {
        egressBlocked_.fetch_add(1, std::memory_order_relaxed);
        const std::lock_guard<std::mutex> lock(diagMutex_);
        blockedReasons_.insert(ec);
    }
    else
    {
        egressErrors_.fetch_add(1, std::memory_order_relaxed);
        const std::lock_guard<std::mutex> lock(diagMutex_);
        droppedReasons_.insert(ec);
    }
}

void MapSocket::Impl::flushDiagnostics()
{
    TracyZoneScoped;

    const auto ingressDropped = ingressDropped_.exchange(0, std::memory_order_relaxed);
    const auto recvErrors     = recvErrors_.exchange(0, std::memory_order_relaxed);
    const auto egressDropped  = egressDropped_.exchange(0, std::memory_order_relaxed);
    const auto egressBlocked  = egressBlocked_.exchange(0, std::memory_order_relaxed);
    const auto egressErrors   = egressErrors_.exchange(0, std::memory_order_relaxed);
    const auto egressBytes    = egressBytesSent_.exchange(0, std::memory_order_relaxed);
    const auto maxDepth       = maxEgressDepth_.exchange(0, std::memory_order_relaxed);

    std::set<std::error_code> blocked;
    std::set<std::error_code> dropped;
    {
        const std::lock_guard<std::mutex> lock(diagMutex_);
        blocked.swap(blockedReasons_);
        dropped.swap(droppedReasons_);
    }

    if (egressBytes > 0)
    {
        mapStatistics_.increment(Key::TotalBytesSentPerTick, egressBytes);
    }

    if (egressBlocked > 0)
    {
        mapStatistics_.increment(Key::TotalSendsBlockedPerTick, egressBlocked);
    }

    if (egressErrors > 0)
    {
        mapStatistics_.increment(Key::TotalSendErrorsPerTick, egressErrors);
    }

    if (ingressDropped > 0)
    {
        mapStatistics_.increment(Key::IngressPacketsDroppedPerTick, ingressDropped);
    }

    if (egressDropped > 0)
    {
        mapStatistics_.increment(Key::EgressPacketsDroppedPerTick, egressDropped);
    }

    mapStatistics_.set(Key::MaxInFlightSendsPerTick,
                       std::max(mapStatistics_.get(Key::MaxInFlightSendsPerTick), maxDepth));

    const auto reasonsToString = [](const std::set<std::error_code>& reasons)
    {
        std::string out;
        for (const auto& reason : reasons)
        {
            out += (out.empty() ? "" : ", ") + reason.message();
        }
        return out;
    };

    if (egressBlocked > 0)
    {
        ShowWarningFmt("{} sends pushed back by the OS this tick (send path backing up, datagrams dropped). Reasons: {}",
                       egressBlocked,
                       reasonsToString(blocked));
    }

    if (egressErrors > 0)
    {
        ShowErrorFmt("{} sends failed this tick (datagrams dropped). Reasons: {}",
                     egressErrors,
                     reasonsToString(dropped));
    }

    if (egressDropped > 0)
    {
        ShowWarningFmt("{} outgoing datagrams dropped this tick (egress queue full, main thread outrunning the network thread)", egressDropped);
    }

    if (ingressDropped > 0)
    {
        ShowWarningFmt("{} incoming datagrams dropped this tick (ingress queue full, main thread not draining fast enough)", ingressDropped);
    }

    if (recvErrors > 0)
    {
        ShowErrorFmt("{} receive errors this tick", recvErrors);
    }
}

MapSocket::MapSocket(Scheduler& scheduler, MapStatistics& mapStatistics, const uint16 port, ReceiveFn onReceiveFn)
: impl_(makeBox<Impl>(scheduler, mapStatistics, port, std::move(onReceiveFn)))
{
}

MapSocket::~MapSocket() = default;

void MapSocket::send(const IPP& ipp, ByteSpan buffer)
{
    impl_->send(ipp, buffer);
}

void MapSocket::flushDiagnostics()
{
    impl_->flushDiagnostics();
}
