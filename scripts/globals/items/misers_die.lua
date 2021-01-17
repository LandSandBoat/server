-----------------------------------------
-- ID: 5503
-- Miser's Die
-- Teaches the job ability Miser's Roll
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.MISERS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.MISERS_ROLL)
end

return item_object
