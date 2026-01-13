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
# Convert to host byte order (like ntohl in C++)
ip_host = socket.ntohl(ip_int)
ipp = ip_host | (port << 32)
ipp_bytes = struct.pack("<Q", ipp)  # Little-endian uint64

print(f"Connecting to endpoint: {ip_str}:{port}")

sock.setsockopt(zmq.ROUTING_ID, ipp_bytes)
sock.connect("tcp://127.0.0.1:54003")


def print_help():
    print("Usage: python3 announce.py \"Your message here\"")
    print("")
    print("Sends a server-wide announcement message to all players.")
    print("")
    print("Advanced usage:")
    print("  python3 announce.py \"message\" [messageType] [gmLevel] [skipSender]")
    print("")
    print("Examples:")
    print("  python3 announce.py \"Server restart in 10 minutes\"")
    print("  python3 announce.py \"Maintenance window\" 7 0 0")


def encode_varint(value):
    """Encode an integer as a varint (alpaca variable-length encoding)"""
    result = bytearray()
    while value >= 0x80:
        result.append((value & 0x7F) | 0x80)
        value >>= 7
    result.append(value & 0x7F)
    return result


def build_chat_packet(gm_flag, zone, sender, msg, msg_type, skip_sender=0):
    if sender is None:
        sender = ""

    # Alpaca encoding for ChatMessageServerMessage (ID=12)
    #
    # ChatMessageServerMessage = 11;
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

    # Packet ID: ChatMessageServerMessage = 12 (varint)
    buffer.extend(encode_varint(12))

    # senderId (uint32) - encoded as varint
    buffer.extend(encode_varint(0))

    # senderName (std::string) - varint length + UTF-8 data
    sender_bytes = sender.encode('utf-8')
    buffer.extend(encode_varint(len(sender_bytes)))
    buffer.extend(sender_bytes)

    # message (std::string) - varint length + UTF-8 data
    msg_bytes = msg.encode('utf-8')
    buffer.extend(encode_varint(len(msg_bytes)))
    buffer.extend(msg_bytes)

    # zoneId (uint16) - fixed 2 bytes, little-endian (NOT varint!)
    buffer.extend(struct.pack('<H', zone))

    # gmLevel (uint8) - varint
    buffer.extend(encode_varint(gm_flag))

    # messageType (CHAT_MESSAGE_TYPE) - varint
    buffer.extend(encode_varint(msg_type))

    # skipSender (bool) - varint
    buffer.extend(encode_varint(skip_sender))

    return buffer


def send_server_message(msg, msg_type=6, gm_level=1, skip_sender=0):
    """
    Send a server-wide message.
    
    Args:
        msg: The message text
        msg_type: CHAT_MESSAGE_TYPE (default 6 = MESSAGE_SYSTEM_1 for blue system messages)
        gm_level: GM level (default 1)
        skip_sender: Whether to skip showing sender name (default 0 = show [GM])
    """
    buffer = build_chat_packet(gm_level, 0, "", msg, msg_type, skip_sender)
    sock.send(buffer)


def main():
    if len(sys.argv) < 2:
        print_help()
        return

    msg = sys.argv[1]
    
    # Optional parameters for advanced usage
    msg_type = int(sys.argv[2]) if len(sys.argv) > 2 else 6  # MESSAGE_SYSTEM_1
    gm_level = int(sys.argv[3]) if len(sys.argv) > 3 else 1
    skip_sender = int(sys.argv[4]) if len(sys.argv) > 4 else 0
    
    send_server_message(msg, msg_type, gm_level, skip_sender)
    print(f"Announcement sent: {msg}")


if __name__ == "__main__":
    main()
