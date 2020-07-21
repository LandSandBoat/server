import re

hex2bin = {
    "0" : "0000",
    "1" : "0001",
    "2" : "0010",
    "3" : "0011",
    "4" : "0100",
    "5" : "0101",
    "6" : "0110",
    "7" : "0111",
    "8" : "1000",
    "9" : "1001",
    "A" : "1010",
    "B" : "1011",
    "C" : "1100",
    "D" : "1101",
    "E" : "1110",
    "F" : "1111"
}

def blob_to_binary(blob):
    # Split hex string into pairs of two
    split_spells = re.findall('..', blob)

    for index, item in enumerate(split_spells):
        # reverse each pair of hexes
        reversed_hex = item[::-1]

        # replace hex val with binary value
        split_spells[index] = ""
        for hex in reversed_hex:
            # Reverse binary val
            split_spells[index] += hex2bin[hex][::-1]

    # print(split_spells)

    # Join everything together in one big 1/0 string
    return "".join(split_spells)
