---@meta

-- luacheck: ignore 241
---@class CClientEntityPairNetwork
local CClientEntityPairNetwork = {}

---@alias NetworkClientMode 'login'|'loading'|'ingame'|'loggedout'|'hung'

---@class NetworkReceived
---@field type integer S2C packet type, 0 for a dropped datagram
---@field sync integer Sub-packet sync
---@field datagramSeq integer Seq of the datagram that carried it
---@field entityId integer The u32 at offset 4, the entity in 0x00D and 0x00E
---@field updateMask integer The byte at offset 0x0A, the update mask in 0x00D and 0x00E
---@field datagram integer Count of datagrams the client has read, from 1
---@field accepted boolean False when the client dropped it
---@field reason string Why the client dropped it, empty when accepted

---Send a plaintext C2S 0x00A and read the reply
---@param params? { dropReply: boolean?, ignoreLogin: boolean? }
---@return boolean accepted True once the client accepts S2C 0x00A
function CClientEntityPairNetwork:login(params)
end

---Send a plaintext C2S 0x00A with a chosen header seq, as a late retry would arrive
---@param seq integer
---@param port? integer Send it from this port instead of the current one
---@return nil
function CClientEntityPairNetwork:sendStaleLogin(seq, port)
end

---Send the queued C2S 0x011, finish the zone load, then send C2S 0x00C
---@param params? { refuseGameOk: boolean? } refuseGameOk sends a C2S 0x00C the handler rejects
---@return nil
function CClientEntityPairNetwork:finishLoading(params)
end

---Move the client to a new source port from now on, as a NAT rebind would
---@param port integer
---@return nil
function CClientEntityPairNetwork:rebind(port)
end

---Retry C2S 0x00A until accepted, finish loading and drain the zone-in burst
---@return nil
function CClientEntityPairNetwork:zoneIn()
end

---One client send tick, then read every reply
---@param params? { dropReply: boolean? } dropReply loses the server's reply on the wire
---@return nil
function CClientEntityPairNetwork:exchange(params)
end

---Exchange until the server has nothing queued for the client
---@return nil
function CClientEntityPairNetwork:drain()
end

---@nodiscard
---@return NetworkClientMode
function CClientEntityPairNetwork:mode()
end

---True when the client got S2C 0x00B outside mode 9, which hangs a retail client
---@nodiscard
---@return boolean
function CClientEntityPairNetwork:isHung()
end

---@nodiscard
---@return string
function CClientEntityPairNetwork:hangReason()
end

---Every S2C sub-packet the client read, accepted or dropped
---@nodiscard
---@return NetworkReceived[]
function CClientEntityPairNetwork:received()
end

---@return nil
function CClientEntityPairNetwork:clearReceived()
end

---Overwrite the zone saved for the char, as a stale row would. Use between zone-out and zone-in.
---@param zoneId integer
---@return nil
function CClientEntityPairNetwork:setStoredZone(zoneId)
end

---Run the session cleanup as if nothing had arrived for that long, and say whether the char is link-dead
---@param seconds integer
---@return boolean
function CClientEntityPairNetwork:isLinkDeadAfter(seconds)
end

---True once the server has sent S2C 0x00B and released the char. The player's entity is gone until the zone-in.
---@nodiscard
---@return boolean
function CClientEntityPairNetwork:hasSentZoneOut()
end
