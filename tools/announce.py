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


def encode_varint(value):
    # Implements Alpaca's Base-128 variable-length encoding (Varint)
    # used for serializing integers and container lengths.
    bytes_list = bytearray()
    while value > 127:
        bytes_list.append((value & 127) | 128)
        value >>= 7
    bytes_list.append(value & 127)
    return bytes_list


def build_chat_packet(gm_flag, zone, sender, msg):
    if sender is None:
        sender = ""

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
    buffer.extend(encode_varint(0))

    # senderName length
    buffer.extend(encode_varint(len(sender)))

    # senderName string
    buffer.extend(sender.encode("utf-8"))

    # message length
    buffer.extend(encode_varint(len(msg)))

    # message string
    buffer.extend(msg.encode("utf-8"))

    # zoneId (uint16 native endianness, assuming little-endian x86/x64)
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
