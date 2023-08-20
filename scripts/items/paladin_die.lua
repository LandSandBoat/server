-----------------------------------
-- ID: 5483
-- Paladin Die
-- Teaches the job ability Gallant's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.GALLANTS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.GALLANTS_ROLL)
end

return itemObject
