-----------------------------------
-- ID: 5479
-- White Mage Die
-- Teaches the job ability Healer's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.HEALERS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.HEALERS_ROLL)
end

return itemObject
