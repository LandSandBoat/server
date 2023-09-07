-----------------------------------
-- NoAction class
-- Sometimes we need to perform an action without
-- showing a result to the player.  Return quest/mission:noaction() to
-- ensure that we don't fall back to another function
-----------------------------------
require('scripts/globals/interaction/actions/action')

NoAction = Action:new(Action.Type.NoAction)

function NoAction:new(prio)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.priority = Action.Priority.Progress or prio -- Goal is to prevent a fall through, so default to high priority
    return obj
end

function NoAction:perform(player)
    return true
end
