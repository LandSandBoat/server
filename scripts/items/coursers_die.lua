-----------------------------------
-- ID: 104
-- Courser's Die
-- Teaches the job ability Coursers Roll
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnAbility(xi.jobAbility.COURSERS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.COURSERS_ROLL)
end

return itemObject
