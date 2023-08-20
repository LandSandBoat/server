-----------------------------------
-- ID: 5495
-- Dancer Die
-- Teaches the job ability Dancer's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.DANCERS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.DANCERS_ROLL)
end

return itemObject
