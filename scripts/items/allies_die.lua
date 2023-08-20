-----------------------------------
-- ID: 5502
-- Allies' Die
-- Teaches the job ability Allies Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.ALLIES_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.ALLIES_ROLL)
end

return itemObject
