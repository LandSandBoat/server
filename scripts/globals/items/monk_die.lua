-----------------------------------
-- ID: 5478
-- Monk Die
-- Teaches the job ability Monk's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.MONKS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.MONKS_ROLL)
end

return itemObject
