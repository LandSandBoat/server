-----------------------------------
-- ID: 5490
-- Dragoon Die
-- Teaches the job ability Drachen Roll
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnAbility(xi.jobAbility.DRACHEN_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.DRACHEN_ROLL)
end

return itemObject
