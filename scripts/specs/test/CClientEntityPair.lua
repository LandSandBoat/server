---@meta

-- Test player that combines client and entity functionality

-- luacheck: ignore 241
---@class CClientEntityPair : CTestEntity
---@field actions CClientEntityPairActions Action helper methods
---@field bcnm CClientEntityPairBCNM BCNM helper methods
---@field events CClientEntityPairEvents Event helper methods
---@field entities CClientEntityPairEntities Entity helper methods
---@field packets CClientEntityPairPackets Packet helper methods
local CClientEntityPair = {}

---@class ZonePosition
---@field x number X coordinate
---@field y number Y coordinate
---@field z number Z coordinate
---@field rot? integer Rotation (0-255)
---@field rotation? integer Rotation (0-255) - alternative to rot

---Process incoming packets and update client state
---@return nil
function CClientEntityPair:tick()
end

---Go to a specific zone with optional position
---@param zoneId xi.zone Zone ID to go to
---@param pos? ZonePosition Optional position table
---@return nil
function CClientEntityPair:gotoZone(zoneId, pos)
end

---Check if the client is currently waiting for a zone change
---@nodiscard
---@return boolean
function CClientEntityPair:isPendingZone()
end

---Get the inventory slot of an item with the specified quantity.
---@nodiscard
---@param itemId integer Item ID to search for
---@param quantity integer Minimum quantity needed
---@return integer? slotId Slot ID if found, nil otherwise
function CClientEntityPair:getItemInvSlot(itemId, quantity)
end

---Claim and kill a mob, handling death and despawn
---@param mobQuery CBaseEntity|string|integer Mob entity, name, or ID
---@param params? {expectDeath?: boolean, waitForDespawn?: boolean} Optional parameters
---@return nil
function CClientEntityPair:claimAndKillMob(mobQuery, params)
end

---Kill multiple mobs in sequence
---@param ... CBaseEntity|string|integer Mob queries
---@return nil
function CClientEntityPair:claimAndKillMobs(...)
end
