-----------------------------------
-- ID: 104
-- Courser's Die
-- Teaches the job ability Coursers Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.COURSERS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.COURSERS_ROLL)
end

return item_object
