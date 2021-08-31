-----------------------------------
-- ID: 5492
-- Blue Mage Die
-- Teaches the job ability Magus's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.MAGUSS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.MAGUSS_ROLL)
end

return item_object
