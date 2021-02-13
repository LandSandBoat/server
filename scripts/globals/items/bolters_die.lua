-----------------------------------
-- ID: 5497
-- Bolter's Die
-- Teaches the job ability Bolters Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.BOLTERS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.BOLTERS_ROLL)
end

return item_object
