/*
===========================================================================

  Copyright (c) 2023 LandSandBoat Dev Teams

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

#include "connect_engine.h"

#include "common/timer.h"

namespace
{

auto getZMQEndpointString() -> std::string
{
    return fmt::format("tcp://{}:{}", settings::get<std::string>("network.ZMQ_IP"), settings::get<uint16>("network.ZMQ_PORT"));
}

auto getZMQRoutingId() -> uint64
{
    // We will only ever have a single login server, so we can use different logic for the routing id

    const auto ip   = str2ip(settings::get<std::string>("network.LOGIN_AUTH_IP"));
    const auto port = settings::get<uint16>("network.LOGIN_AUTH_PORT");

    return IPP(ip, port).getRawIPP();
}
constexpr auto kSessionCleanTime = 15min;

} // namespace

ConnectEngine::ConnectEngine(asio::io_context& io_context)
: zmqDealerWrapper_(getZMQEndpointString(), getZMQRoutingId())
, m_authHandler(io_context, settings::get<uint32>("network.LOGIN_AUTH_PORT"), zmqDealerWrapper_)
, m_dataHandler(io_context, settings::get<uint32>("network.LOGIN_DATA_PORT"), zmqDealerWrapper_)
, m_viewHandler(io_context, settings::get<uint32>("network.LOGIN_VIEW_PORT"), zmqDealerWrapper_)
, m_sessionCleanupTimer(io_context, kSessionCleanTime)
{
    m_sessionCleanupTimer.async_wait(std::bind(&ConnectEngine::periodicCleanup, this, std::placeholders::_1));
}

ConnectEngine::~ConnectEngine()
{
    m_sessionCleanupTimer.cancel();
};

void ConnectEngine::periodicCleanup(const asio::error_code& error)
{
    if (!error)
    {
        auto& sessions       = loginHelpers::getAuthenticatedSessions();
        auto  ipAddrIterator = sessions.begin();
        while (ipAddrIterator != sessions.end())
        {
            auto sessionIterator = ipAddrIterator->second.begin();
            while (sessionIterator != ipAddrIterator->second.end())
            {
                session_t& session = sessionIterator->second;

                // If it's been 15 minutes, erase it from the session list
                if (!session.data_session &&
                    !session.view_session &&
                    timer::now() > session.authorizedTime + kSessionCleanTime)
                {
                    sessionIterator = ipAddrIterator->second.erase(sessionIterator);
                }
                else
                {
                    ++sessionIterator;
                }
            }

            // If this map entry is empty, clean it up
            if (ipAddrIterator->second.size() == 0)
            {
                ipAddrIterator = sessions.erase(ipAddrIterator);
            }
            else
            {
                ++ipAddrIterator;
            }
        }

        m_sessionCleanupTimer.expires_at(m_sessionCleanupTimer.expiry() + kSessionCleanTime);
        m_sessionCleanupTimer.async_wait(std::bind(&ConnectEngine::periodicCleanup, this, std::placeholders::_1));
    }
}
