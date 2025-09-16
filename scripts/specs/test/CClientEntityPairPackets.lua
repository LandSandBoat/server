---@meta

-- luacheck: ignore 241
---@class CClientEntityPairPackets
local CClientEntityPairPackets = {}

---Send a packet from FFI cdata
---@param packetId integer Packet ID (e.g. 0x1A)
---@param ffiData ffi.cdata* FFI struct containing packet data
---@param ffiSize integer Size of the FFI struct from ffi.sizeof()
---@return nil
function CClientEntityPairPackets:send(packetId, ffiData, ffiSize)
end

---@class IncomingPacket
---@field type integer Packet type
---@field size integer Packet size
---@field sequence integer Packet sequence number
---@field data integer[] Array of bytes

---Get all incoming packets as a Lua table
---@nodiscard
---@return IncomingPacket[] packets Array of incoming packets
function CClientEntityPairPackets:getIncoming()
end

---Send zone-in packet sequence
---@return nil
function CClientEntityPairPackets:sendZonePackets()
end

---Process incoming packets from the server
---@return nil
function CClientEntityPairPackets:parseIncoming()
end
