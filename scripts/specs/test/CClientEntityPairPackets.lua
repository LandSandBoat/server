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

---@class ActionPacket
---@field m_uID integer Actor ID
---@field trg_sum integer Target count
---@field res_sum integer Reserved (always 0)
---@field cmd_no integer Command type (action type)
---@field cmd_arg integer Command argument
---@field info integer Action info
---@field target ActionTarget[] Array of action targets

---@class ActionTarget
---@field m_uID integer Target ID
---@field result_sum integer Result count
---@field result ActionResult[] Array of action results

---@class ActionResult
---@field miss integer Miss/evade flags (0-7)
---@field kind integer Animation kind (0-3)
---@field sub_kind integer Animation sub-kind (0-4095)
---@field info integer Additional info flags (0-31)
---@field scale integer Scale/hit distortion (0-31)
---@field value integer Damage/heal value (0-131071)
---@field message integer Message ID (0-1023)
---@field bit integer Modifier bits (0-2147483647)
---@field has_proc boolean Has additional effect
---@field proc_kind integer? Additional effect type (0-63)
---@field proc_info integer? Additional effect info (0-15)
---@field proc_value integer? Additional effect value (0-131071)
---@field proc_message integer? Additional effect message (0-1023)
---@field has_react boolean Has reaction effect (spikes)
---@field react_kind integer? Reaction effect type (0-63)
---@field react_info integer? Reaction effect info (0-15)
---@field react_value integer? Reaction effect value (0-16383)
---@field react_message integer? Reaction effect message (0-1023)

---Get all BATTLE2 (0x028) action packets unpacked into Lua tables
---@nodiscard
---@return ActionPacket[] actions Array of unpacked action packets
function CClientEntityPairPackets:actionPackets()
end

---Send zone-in packet sequence
---@return nil
function CClientEntityPairPackets:sendZonePackets()
end

---Process incoming packets from the server
---@return nil
function CClientEntityPairPackets:parseIncoming()
end

---Clear all packets from the player's packet list
---@return nil
function CClientEntityPairPackets:clear()
end
