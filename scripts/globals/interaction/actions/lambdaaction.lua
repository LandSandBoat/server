-----------------------------------
----- CustomAction class
-----------------------------------
require('scripts/globals/interaction/actions/action')

---@class TLambdaAction : TAction
---@field actionFunc function
---@field priority Action.Priority|integer
LambdaAction = Action:new(Action.Type.LambdaAction)

---@param actionFunc function
---@param prio Action.Priority|integer
function LambdaAction:new(actionFunc, prio)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = tostring(actionFunc)
    obj.actionFunc = actionFunc
    obj.priority = Action.Priority.Default or prio
    return obj
end

function LambdaAction:perform(player, targetEntity)
    return self.actionFunc(player, targetEntity)
end
