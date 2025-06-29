---@meta

-- luacheck: ignore 241
---@class CSimClient
local CSimClient = {}

---@param packetData table
---@return nil
function CSimClient:sendPacket(packetData)
end

---@return nil
function CSimClient:parseIncomingPackets()
end

---@nodiscard
---@return CBaseEntity
function CSimClient:getPlayer()
end

---@nodiscard
---@return number
function CSimClient:getCurrentEventId()
end

---@nodiscard
---@param itemId integer
---@param quantity integer
---@return integer?
function CSimClient:getItemInvSlot(itemId, quantity)
end

---@param zoneId integer?
---@return nil
function CSimClient:gotoZone(zoneId)
end

---@nodiscard
---@return boolean
function CSimClient:isPendingZone()
end

---@nodiscard
---@return table
function CSimClient:getIncomingPackets()
end
