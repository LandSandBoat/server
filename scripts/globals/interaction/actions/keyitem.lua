-----------------------------------
----- KeyItemAction class
-----------------------------------
require('scripts/globals/interaction/actions/action')

---@class TKeyItem : TAction
---@field id integer
KeyItemAction = Action:new(Action.Type.KeyItem)

---@param keyItemId xi.keyItem
---@return TKeyItem
function KeyItemAction:new(keyItemId)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.id = keyItemId
    obj.priority = Action.Priority.Progress -- key items is generally always progress
    return obj
end

---@param player CBaseEntity
---@param targetEntity CBaseEntity
function KeyItemAction:perform(player, targetEntity)
    return npcUtil.giveKeyItem(player, self.id)
end
