from .util import util, PACKET_HEAD

PD_CODE = 1


def set(data, idx, val):
    data[PACKET_HEAD + idx] = val


class packets:
    # TODO:
    @staticmethod
    def generate_starting_packet(type, size):
        global PD_CODE
        PD_CODE = PD_CODE + 1

        data = bytearray(
            PACKET_HEAD + 4 + size + 16
        )  # header + (type, size, seq) + body + md5

        # Header
        util.memcpy(util.pack_16(PD_CODE), 0, data, 0, 2)

        # Body
        data[PACKET_HEAD + 0] = type
        data[PACKET_HEAD + 1] = size
        data[PACKET_HEAD + 2] = 0  # Seq

        return data

    @staticmethod
    def to_map_e7():
        global PD_CODE
        PD_CODE = PD_CODE + 1

        data = bytearray(4 + PACKET_HEAD + 16)
        util.memcpy(util.pack_16(PD_CODE), 0, data, 0, 2)
        util.memcpy(util.pack_16(0xE7), 0, data, PACKET_HEAD, 2)
        data[PACKET_HEAD + 0x01] = 0x04
        util.memcpy(util.pack_16(PD_CODE), 0, data, PACKET_HEAD + 0x02, 2)
        data[PACKET_HEAD + 0x06] = 0x03

        # TODO:
        # packet = generate_starting_packet(0xE7, 4)
        # set(packet, 0x06, 0x03)
        # util.packet_md5(packet)
        # return packet

        util.packet_md5(data)
        return data

    @staticmethod
    def to_map_0d():
        global PD_CODE
        PD_CODE = PD_CODE + 1

        data = bytearray(4 + PACKET_HEAD + 16)
        util.memcpy(util.pack_16(PD_CODE), 0, data, 0, 2)
        util.memcpy(util.pack_16(0x0D), 0, data, PACKET_HEAD, 2)
        data[PACKET_HEAD + 0x01] = 0x04
        util.memcpy(util.pack_16(PD_CODE), 0, data, PACKET_HEAD + 0x02, 2)

        util.packet_md5(data)
        return data

    @staticmethod
    def to_map_b5(message):
        data = packets.generate_starting_packet(0xB5, 130)
        data[PACKET_HEAD + 0x04] = 0
        # Say
        util.memcpy(util.to_bytes(message), 0, data, PACKET_HEAD + 0x06, len(message))
        util.packet_md5(data)
        return data

    @staticmethod
    def to_map_0a(char_id):
        global PD_CODE
        PD_CODE = PD_CODE + 1

        data = bytearray(136)
        util.memcpy(util.pack_16(PD_CODE), 0, data, 0, 2)
        util.memcpy(util.pack_16(0x00A), 0, data, PACKET_HEAD, 2)
        data[PACKET_HEAD + 0x01] = 0x2E
        util.memcpy(util.pack_16(PD_CODE), 0, data, PACKET_HEAD + 0x02, 2)
        util.memcpy(util.pack_32(char_id), 0, data, PACKET_HEAD + 0x0C, 4)

        util.packet_md5(data)
        return data

    @staticmethod
    def to_map_11():
        data = packets.generate_starting_packet(0x11, 0x04)
        util.packet_md5(data)
        return data
