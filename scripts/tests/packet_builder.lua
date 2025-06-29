-----------------------------------
-- Test: Packet building
-----------------------------------
---@class PacketBuilder
---@field data table<integer>
PacketBuilder = {}

---@private
PacketBuilder.__index = PacketBuilder

---@param packetType integer
---@return PacketBuilder
function PacketBuilder:new(packetType)
    local obj = {}
    setmetatable(obj, self)
    obj.data = { packetType, 0, 0 }
    return obj
end

function PacketBuilder:setU8(pos, byte)
    self.data[pos] = byte
end

function PacketBuilder:setU16(pos, data)
    self:set(pos, 2, data)
end

---@param pos integer
---@param data integer
function PacketBuilder:setU32(pos, data)
    self:set(pos, 4, data)
end

function PacketBuilder:set(pos, byteSize, data)
    for i = 0, byteSize - 1 do
        self.data[pos + i] = bit.band(bit.rshift(data, i * 8), 0xFF)
    end
end

function PacketBuilder:appendByte(byte)
    self.data[#self.data + 1] = byte
end

---@nodiscard
---@return integer
function PacketBuilder:getType()
    return self.data[1]
end

return PacketBuilder
