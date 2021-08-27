-----------------------------------
-- ID: 5479
-- White Mage Die
-- Teaches the job ability Healer's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.HEALERS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.HEALERS_ROLL)
end

return item_object
