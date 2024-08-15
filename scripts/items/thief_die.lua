-----------------------------------
-- ID: 5482
-- Thief Die
-- Teaches the job ability Rogue's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnAbility(xi.jobAbility.ROGUES_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.ROGUES_ROLL)
end

return itemObject
