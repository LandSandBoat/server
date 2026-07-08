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
