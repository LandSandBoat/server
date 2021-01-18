-----------------------------------
-- ID: 5496
-- Scholar Die
-- Teaches the job ability Scholars Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.SCHOLARS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.SCHOLARS_ROLL)
end

return item_object
