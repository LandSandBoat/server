import hashlib
import struct

from .blowfish import Blowfish

# Globals
PACKET_HEAD = 28


class util:
    @staticmethod
    def to_bytes(val):
        return bytes(val, encoding="utf-8")

    @staticmethod
    def memcpy(src, src_offset, dst, dst_offset, count):
        try:
            src_bytes = util.to_bytes(src[src_offset:])
        except:
            src_bytes = src

        try:
            dst_bytes = util.to_bytes(dst[dst_offset:])
        except:
            dst_bytes = dst

        for idx in range(count):
            dst_bytes[dst_offset + idx] = src_bytes[src_offset + idx]

    @staticmethod
    def unpack_uint16(data, offset):
        return struct.unpack_from("<H", data, offset)[0]

    @staticmethod
    def unpack_uint32(data, offset):
        return struct.unpack_from("<I", data, offset)[0]

    @staticmethod
    def pack_16(data):
        return struct.pack("<H", data)

    @staticmethod
    def pack_32(data):
        return struct.pack("<I", data)

    @staticmethod
    def int_to_ip(ip):
        return ".".join([str((ip >> 8 * i) % 256) for i in [3, 2, 1, 0]])

    @staticmethod
    def packet_md5(data):
        to_md5 = bytearray(len(data) - (PACKET_HEAD + 16))
        util.memcpy(data, PACKET_HEAD, to_md5, 0, len(to_md5))
        to_md5 = hashlib.md5(to_md5)
        util.memcpy(to_md5.digest(), 0, data, len(data) - 16, 16)

    @staticmethod
    def init_blowfish():
        starting_key = [0x00000000, 0x00000000, 0x00000000, 0x00000000, 0xAD5DE056]
        starting_key[4] = starting_key[4] + 2
        byte_array = bytearray(len(starting_key) * 4)

        util.memcpy(util.pack_32(starting_key[0]), 0, byte_array, 0, 4)
        util.memcpy(util.pack_32(starting_key[1]), 0, byte_array, 4, 4)
        util.memcpy(util.pack_32(starting_key[2]), 0, byte_array, 8, 4)
        util.memcpy(util.pack_32(starting_key[3]), 0, byte_array, 12, 4)
        util.memcpy(util.pack_32(starting_key[4]), 0, byte_array, 16, 4)

        # print('Blowfish Key: ' + byte_array.hex().strip('0'))

        hash_key = hashlib.md5(byte_array).digest()

        for i in range(16):
            if hash_key[i] == 0:
                zero = bytearray([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
                util.memcpy(zero, i, hash_key, i, 16 - i)

        return Blowfish(hash_key)
