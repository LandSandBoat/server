-----------------------------------
-- ID: 5493
-- Corsair Die
-- Teaches the job ability Corsair's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.CORSAIRS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.CORSAIRS_ROLL)
end

return item_object
