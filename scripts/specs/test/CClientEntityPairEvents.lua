---@meta

-- luacheck: ignore 241
---@class CClientEntityPairEvents
local CClientEntityPairEvents = {}

---Finish the current event
---@param eventId? integer Event ID (uses current event if not provided)
---@param option? integer Finish option value
---@return nil
function CClientEntityPairEvents:finish(eventId, option)
end

---Send an update to the current event
---@param eventId? integer Event ID (uses current event if not provided)
---@param option? integer Update option value
---@return nil
function CClientEntityPairEvents:update(eventId, option)
end

---@class EventPosition
---@field x? number
---@field y? number
---@field z? number

---Send an update that carries the position the client wants to move to
---@param eventId? integer Event ID (uses current event if not provided)
---@param option? integer Update option value
---@param position? EventPosition Requested position (defaults to the current one)
---@return integer? reply First event work parameter the server answered with, nil if none
---@return boolean moved Whether the server moved the client to the requested position
function CClientEntityPairEvents:updateWithPosition(eventId, option, position)
end

---Assert that the client is not currently in an event
---@return nil
function CClientEntityPairEvents:expectNotInEvent()
end

---@class ExpectedEvent
---@field eventId? integer Event ID to expect
---@field updates? integer[] Array of update option values
---@field finishOption? integer Option value for finishing the event

---Process an expected event with updates and finish
---@param expectedEvent ExpectedEvent Event configuration
---@return nil
function CClientEntityPairEvents:expect(expectedEvent)
end
