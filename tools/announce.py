#############################
# announce.py
# Send a server message to all characters, in all zones, across all processes.
#
# Usage
# python3 announce.py "Here is a message from python!"
#
# Requirements
# pip3 install zmq pyzmq
#
#############################

import socket
import sys
import zmq
import struct

context = zmq.Context()
sock = context.socket(zmq.DEALER)

ip_str = "127.0.0.1"
port = 54003

ip_bytes = socket.inet_aton(ip_str)
(ip_int,) = struct.unpack("!I", ip_bytes)
ipp = ip_int | (port << 32)
ipp_bytes = struct.pack("!Q", ipp)

print(f"Connecting to endpoint: {ip_str}:{port}")

sock.setsockopt(zmq.ROUTING_ID, ipp_bytes)
sock.connect("tcp://127.0.0.1:54003")


def print_help():
    print("You must provide a message to send.")
    print("Example:")
    print('python3 .\\announce.py "Here is a message from python!"')


def encode_uint32(value):
    # Alpaca's fixed length encoding (kSerializeOptions in src/common/ipc.h):
    # integers are written little-endian at their own size, and container
    # lengths as uint32.
    return struct.pack("<I", value)


def build_chat_packet(gm_flag, zone, sender, msg):
    if sender is None:
        sender = ""

    sender_bytes = sender.encode("utf-8")
    msg_bytes = msg.encode("utf-8")

    # alpaca encoding for:
    #
    # server/src/common/ipc_structs.h:
    #
    # struct ChatMessageServerMessage
    # {
    #     uint32            senderId{};
    #     std::string       senderName{};
    #     std::string       message{};
    #     uint16            zoneId{};
    #     uint8             gmLevel{};
    #     CHAT_MESSAGE_TYPE messageType{ MESSAGE_SYSTEM_1 };
    #     bool              skipSender{};
    # };

    buffer = bytearray()

    # ChatMessageServerMessage (ipc message type)
    # server/tools/build/generated/ipc_stubs.h
    #     ChatMessageServerMessage  = 12,
    buffer.append(12)

    # senderId
    buffer.extend(encode_uint32(0))

    # senderName length (in bytes)
    buffer.extend(encode_uint32(len(sender_bytes)))

    # senderName string
    buffer.extend(sender_bytes)

    # message length (in bytes)
    buffer.extend(encode_uint32(len(msg_bytes)))

    # message string
    buffer.extend(msg_bytes)

    # zoneId (uint16, little-endian)
    buffer.extend(struct.pack("<H", zone))

    # gmLevel
    buffer.append(gm_flag)

    # messageType (MESSAGE_SYSTEM_1 = 6)
    # server/src/map/enums/chat_message_type.h
    buffer.append(6)

    # skipSender
    buffer.append(0)

    return buffer


def send_server_message(msg):
    print(f"Sending '{msg}'")
    buffer = build_chat_packet(1, 0, "", msg)
    sock.send(buffer)


def main():
    if len(sys.argv) < 2:
        print_help()
        return

    send_server_message(sys.argv[1])


if __name__ == "__main__":
    main()
