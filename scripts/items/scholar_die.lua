-----------------------------------
-- ID: 5496
-- Scholar Die
-- Teaches the job ability Scholars Roll
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnAbility(xi.jobAbility.SCHOLARS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.SCHOLARS_ROLL)
end

return itemObject
