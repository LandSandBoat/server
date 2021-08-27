-----------------------------------
-- ID: 5484
-- Dark Knight Die
-- Teaches the job ability Chaos Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.CHAOS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.CHAOS_ROLL)
end

return item_object
