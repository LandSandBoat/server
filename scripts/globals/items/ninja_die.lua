-----------------------------------------
-- ID: 5489
-- Ninja Die
-- Teaches the job ability Ninja Roll
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.NINJA_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.NINJA_ROLL)
end

return item_object
