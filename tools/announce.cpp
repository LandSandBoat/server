#include <cstring>
#include <iostream>
#include <string>

#include <zmq.hpp>
#include <arpa/inet.h>

#include "common/ipc.h"
#include "common/ipp.h"
#include "map/enums/chat_message_type.h"

int main(int argc, char** argv)
{
    if (argc < 2)
    {
        std::cerr << "Usage: announce \"message...\"\n";
        return 2;
    }

    std::string msg;
    for (int i = 1; i < argc; ++i)
    {
        if (i > 1) msg += " ";
        msg += argv[i];
    }

    // Build the IPC message as expected by ipc::fromBytesWithHeader
    ipc::ChatMessageServerMessage m{};
    m.senderId    = 0;
    m.senderName  = "";
    m.message     = msg;
    m.zoneId      = 0;
    m.gmLevel     = 1;
    m.messageType = CHAT_MESSAGE_TYPE::MESSAGE_SYSTEM_1; // = 6 for system message

    const auto payload = ipc::toBytesWithHeader(m);

    // xi_world listens on 127.0.0.1:54003
    const std::string endpoint = "tcp://127.0.0.1:54003";

    // Match the routing format that the server expects
    in_addr addr{};
    inet_aton("127.0.0.1", &addr);
    const uint32 ip = ntohl(addr.s_addr); // host-order uint32
    IPP ipp(ip, 54003);

    zmq::context_t ctx(1);
    zmq::socket_t sock(ctx, zmq::socket_type::dealer);

    auto rid_msg = ipp.toZMQMessage();
    sock.set(zmq::sockopt::routing_id, rid_msg.to_string());
    sock.connect(endpoint);

    zmq::message_t out(payload.size());
    std::memcpy(out.data(), payload.data(), payload.size());
    sock.send(out, zmq::send_flags::none);

    std::cout << "OK\n";
    return 0;
}
