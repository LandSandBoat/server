/*
===========================================================================

Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "zmq_service.h"

#include "cbasetypes.h"
#include "logging.h"
#include "settings_manager.h"
#include "socket.h"

ZMQService::ZMQService(zmq::socket_type type)
{
    zmqSql = std::make_unique<SqlConnection>(SettingsManager::Get<std::string>(SqlSettings::LOGIN).c_str(),
                                             SettingsManager::Get<std::string>(SqlSettings::PASSWORD).c_str(),
                                             SettingsManager::Get<std::string>(SqlSettings::HOST).c_str(),
                                             SettingsManager::Get<unsigned int>(SqlSettings::PORT),
                                             SettingsManager::Get<std::string>(SqlSettings::DATABASE).c_str());

    pContext = std::make_unique<zmq::context_t>(1);
    pSocket  = std::make_unique<zmq::socket_t>(*pContext, type);

    pSocket->set(zmq::sockopt::rcvtimeo, 500);

    // TODO: Make this configurable, we don't _have_ to be using tcp here
    address.append("tcp://");
    address.append(SettingsManager::Get<std::string>(ZmqSettings::IP));
    address.append(":");
    address.append(std::to_string(SettingsManager::Get<unsigned int>(ZmqSettings::PORT)));

    try
    {
        pSocket->bind(address);
    }
    catch (zmq::error_t& err)
    {
        ShowFatalError("Unable to bind/connect zmq socket (%s): %s", address.c_str(), err.what());
        std::exit(-1);
    }

    listen();
}

ZMQService::~ZMQService()
{
    if (pSocket)
    {
        pSocket->disconnect(address.c_str());
        pSocket->close();
        pSocket = nullptr;
    }

    if (pContext)
    {
        pContext->shutdown();
        pContext->close();
        pContext = nullptr;
    }
}

void ZMQService::queue(uint64 ipp, MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet)
{
    chat_message_t msg;
    msg.dest = ipp;
    msg.type = type;
    msg.data.copy(*extra);
    msg.packet.copy(*packet);
    outgoing_queue.enqueue(std::move(msg));
}

void ZMQService::send(uint64 ipp, MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet)
{
    try
    {
        std::array<zmq::message_t, 4> msgs;
        msgs[0] = zmq::message_t(&ipp, sizeof(ipp));
        msgs[1] = zmq::message_t(&type, sizeof(type));
        msgs[2].copy(*extra);
        msgs[3].copy(*packet);
        zmq::send_multipart(*pSocket, msgs);
    }
    catch (zmq::error_t& e)
    {
        ShowError("Message: %s", e.what());
    }
}

void ZMQService::parse(MSGSERVTYPE type, zmq::message_t* extra, zmq::message_t* packet, zmq::message_t* from)
{
    int     ret = SQL_ERROR;
    in_addr from_ip;
    uint16  from_port = 0;
    bool    ipstring  = false;
    char    from_address[INET_ADDRSTRLEN];

    if (from)
    {
        from_ip.s_addr = ref<uint32>((uint8*)from->data(), 0);
        from_port      = ref<uint16>((uint8*)from->data(), 4);
        inet_ntop(AF_INET, &from_ip, from_address, INET_ADDRSTRLEN);
    }

    switch (type)
    {
        case MSG_CHAT_TELL:
        case MSG_LINKSHELL_RANK_CHANGE:
        case MSG_LINKSHELL_REMOVE:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions LEFT JOIN chars ON "
                                "accounts_sessions.charid = chars.charid WHERE charname = '%s' LIMIT 1;";
            ret               = zmqSql->Query(query, (int8*)extra->data() + 4);
            if (zmqSql->NumRows() == 0)
            {
                query = "SELECT server_addr, server_port FROM accounts_sessions WHERE charid = %d LIMIT 1;";
                ret   = zmqSql->Query(query, ref<uint32>((uint8*)extra->data(), 0));
            }
            break;
        }
        case MSG_CHAT_PARTY:
        case MSG_PT_RELOAD:
        case MSG_PT_DISBAND:
        {
            const char* query   = "SELECT server_addr, server_port, MIN(charid) FROM accounts_sessions JOIN accounts_parties USING (charid) "
                                  "WHERE IF (allianceid <> 0, allianceid = (SELECT MAX(allianceid) FROM accounts_parties WHERE partyid = %d), "
                                  "partyid = %d) GROUP BY server_addr, server_port;";
            uint32      partyid = ref<uint32>((uint8*)extra->data(), 0);
            ret                 = zmqSql->Query(query, partyid, partyid);
            break;
        }
        case MSG_CHAT_LINKSHELL:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions "
                                "WHERE linkshellid1 = %d OR linkshellid2 = %d GROUP BY server_addr, server_port;";
            ret               = zmqSql->Query(query, ref<uint32>((uint8*)extra->data(), 0), ref<uint32>((uint8*)extra->data(), 0));
            break;
        }
        case MSG_CHAT_UNITY:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions "
                                "WHERE unitychat = %d GROUP BY server_addr, server_port;";
            ret               = zmqSql->Query(query, ref<uint32>((uint8*)extra->data(), 0), ref<uint32>((uint8*)extra->data(), 0));
            break;
        }
        case MSG_CHAT_YELL:
        {
            const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE misc & 1024 GROUP BY zoneip, zoneport;";
            ret               = zmqSql->Query(query);
            ipstring          = true;
            break;
        }
        case MSG_CHAT_SERVMES:
        {
            const char* query = "SELECT zoneip, zoneport FROM zone_settings GROUP BY zoneip, zoneport;";
            ret               = zmqSql->Query(query);
            ipstring          = true;
            break;
        }
        case MSG_PT_INVITE:
        case MSG_PT_INV_RES:
        case MSG_DIRECT:
        case MSG_SEND_TO_ZONE:
        {
            const char* query = "SELECT server_addr, server_port FROM accounts_sessions WHERE charid = %d;";
            ret               = zmqSql->Query(query, ref<uint32>((uint8*)extra->data(), 0));
            break;
        }
        case MSG_SEND_TO_ENTITY:
        {
            const char* query = "SELECT zoneip, zoneport FROM zone_settings WHERE zoneid = %d;";
            ret               = zmqSql->Query(query, ref<uint16>((uint8*)extra->data(), 2));
            ipstring          = true;
            break;
        }
        case MSG_LOGIN:
        {
            // no op
            break;
        }
        default:
        {
            ShowDebug("Message: unknown type received: %d from %s:%hu", static_cast<uint8>(type), from_address, from_port);
            break;
        }
    }

    if (ret != SQL_ERROR)
    {
        ShowDebug("Message: Received message %d from %s:%hu", static_cast<uint8>(type), from_address, from_port);

        while (zmqSql->NextRow() == SQL_SUCCESS)
        {
            uint64 ip = 0;

            if (ipstring)
            {
                inet_pton(AF_INET, (const char*)zmqSql->GetData(0), &ip);
            }
            else
            {
                ip = zmqSql->GetUIntData(0);
            }

            uint64  port = zmqSql->GetUIntData(1);
            in_addr target;
            target.s_addr = (unsigned long)ip;

            char target_address[INET_ADDRSTRLEN];
            inet_ntop(AF_INET, &target, target_address, INET_ADDRSTRLEN);
            ShowDebug("Message:  -> rerouting to %s:%lu", target_address, port);
            ip |= (port << 32);

            if (type == MSG_CHAT_PARTY || type == MSG_PT_RELOAD || type == MSG_PT_DISBAND)
            {
                ref<uint32>((uint8*)extra->data(), 0) = zmqSql->GetUIntData(2);
            }

            send(ip, type, extra, packet);
        }
    }
}

void ZMQService::listen()
{
    while (true)
    {
        std::array<zmq::message_t, 4> msgs;
        try
        {
            const auto ret = zmq::recv_multipart_n(*pSocket, msgs.data(), msgs.size());
            if (!ret)
            {
                chat_message_t msg;
                while (outgoing_queue.try_dequeue(msg))
                {
                    send(msg.dest, msg.type, &msg.data, &msg.packet);
                }
                continue;
            }
        }
        catch (zmq::error_t& e)
        {
            // Context was terminated
            // Exit loop
            if (!pSocket || e.num() == 156384765) // ETERM
            {
                return;
            }

            ShowError("Message: %s", e.what());
            continue;
        }

        // 0: zmq::message_t from;
        // 1: zmq::message_t type;
        // 2: zmq::message_t extra;
        // 3: zmq::message_t packet;
        parse((MSGSERVTYPE)ref<uint8>((uint8*)msgs[1].data(), 0), &msgs[2], &msgs[3], &msgs[0]);

        zmqSql->TryPing();
    }
}
