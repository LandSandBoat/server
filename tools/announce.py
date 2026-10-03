#############################
# announce.py
# Send a server message to all characters, in all zones, across all processes.
#
# Usage
# python3 announce.py "Here is a message from python!"
#
# Requirements
# pip3 install zmq pyzmq cbor2
#
#############################

import socket
import sys
import zmq
import struct
import cbor2

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
    # Keys map onto ipc::ChatMessageServerMessage (server/src/common/ipc_structs.h) by name,
    # so field order and integer widths don't matter here.
    body = {
        "senderId": 0,
        "senderName": sender or "",
        "message": msg,
        "zoneId": zone,
        "gmLevel": gm_flag,
        # MESSAGE_SYSTEM_1, see server/src/map/enums/chat_message_type.h
        "messageType": 6,
        "skipSender": False,
    }

    # MessageType::ChatMessageServerMessage, see build/generated/ipc_stubs.h
    return bytearray([12]) + cbor2.dumps(body)


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
