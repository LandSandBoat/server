----------------------------
----- KeyItemAction class
----------------------------
require('scripts/globals/interaction/actions/action')

KeyItemAction = Action:new(Action.Type.KeyItem)

function KeyItemAction:new(keyItemId)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = keyItemId
    obj.priority = Action.Priority.Progress -- key items is generally always progress
    return obj
end

function KeyItemAction:perform(player, targetEntity)
    return npcUtil.giveKeyItem(player, self.id)
end
