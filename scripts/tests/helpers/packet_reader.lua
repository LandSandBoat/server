-----------------------------------
-- Little-endian readers for the byte arrays packets:getIncoming() returns.
-----------------------------------
local packetReader = {}

function packetReader.readU16(data, offset)
    return data[offset] + data[offset + 1] * 0x100
end

function packetReader.readU32(data, offset)
    return packetReader.readU16(data, offset) + packetReader.readU16(data, offset + 2) * 0x10000
end

-- The eight u32 event params starting at offset, 0-indexed like the server sends them.
function packetReader.readParams(data, offset)
    local params = {}
    for i = 0, 7 do
        params[i] = packetReader.readU32(data, offset + i * 4)
    end

    return params
end

-- The actor and params of the last event start (0x032 or 0x034) since the last clear.
function packetReader.lastEventStart(player)
    local start
    for _, packet in ipairs(player.packets:getIncoming()) do
        if packet.type == 0x032 then
            start = { actor = packetReader.readU32(packet.data, 0x04), params = {} }
        elseif packet.type == 0x034 then
            start = { actor = packetReader.readU32(packet.data, 0x04), params = packetReader.readParams(packet.data, 0x08) }
        end
    end

    assert(start, 'No event start was sent')

    return start
end

return packetReader
