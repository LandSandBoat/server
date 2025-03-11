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


def build_chat_packet(gm_flag, zone, sender, msg):
    buff_size = min(236, len(sender) + len(msg) + 10)
    buffer = bytearray(buff_size)

    if sender is None:
        sender = ""

    # alpaca encoding for:
    #
    # ChatMessageServerMessage = 11;
    #
    # struct ChatMessageServerMessage
    # {
    #     uint32      senderId{};
    #     std::string senderName{};
    #     std::string message{};
    #     uint16      zoneId{};
    #     uint8       gmLevel{};
    # };

    idx = 0

    # ChatMessageServerMessage
    buffer[idx] = 11
    idx += 1

    # senderId
    buffer[idx] = 0
    idx += 1

    # len(senderName)
    buffer[idx] = len(sender)
    idx += 1

    # senderName
    for i, c in enumerate(sender):
        buffer[idx] = ord(c)
        idx += 1

    # len(message)
    buffer[idx] = len(msg)
    idx += 1

    # message
    for i, c in enumerate(msg):
        buffer[idx] = ord(c)
        idx += 1

    # zoneId
    buffer[idx] = zone
    idx += 1

    # gmLevel
    buffer[idx] = gm_flag
    idx += 1

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
