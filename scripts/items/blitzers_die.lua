-----------------------------------
-- ID: 5500
-- Blitzer's Die
-- Teaches the job ability Blitzers Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.BLITZERS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.BLITZERS_ROLL)
end

return itemObject
