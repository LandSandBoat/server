-----------------------------------
----- Event class
-----------------------------------
require('scripts/globals/interaction/actions/action')

---@class TEvent : TAction
---@field id integer
---@field options integer[]|table[]
Event = Action:new(Action.Type.Event)

---@param eventId integer
---@param ... integer|table
function Event:new(eventId, ...)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = eventId
    obj.options = { ... }
    obj.priority = Action.Priority.Event -- default priority to 10
    obj.isCutscene = false
    return obj
end

---@param player CBaseEntity
---@param targetEntity CBaseEntity
function Event:perform(player, targetEntity)
    if self.isCutscene and player.startCutscene then
        player:startCutscene(self.id, unpack(self.options))
    else
        player:startEvent(self.id, unpack(self.options))
    end

    return self.returnValue
end

---@return TEvent
function Event:cutscene()
    self.isCutscene = true
    return self
end
