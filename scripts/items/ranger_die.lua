-----------------------------------
-- ID: 5487
-- Ranger Die
-- Teaches the job ability Hunter's Roll
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnAbility(xi.jobAbility.HUNTERS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.HUNTERS_ROLL)
end

return itemObject
