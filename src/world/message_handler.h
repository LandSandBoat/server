#ifndef SERVER_MESSAGE_HANDLER_H
#define SERVER_MESSAGE_HANDLER_H

#include "common/mmo.h"
#include <zmq.hpp>

class IMessageHandler
{
public:
    virtual ~IMessageHandler()
    {
    }
    virtual bool handleMessage(std::vector<uint8> payload,
                               in_addr            from_addr,
                               uint16             from_port) = 0;
};

#endif // SERVER_MESSAGE_HANDLER_H
