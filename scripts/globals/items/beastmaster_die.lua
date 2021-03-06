-----------------------------------
-- ID: 5485
-- Beastmaster Die
-- Teaches the job ability Beast Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.BEAST_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.BEAST_ROLL)
end

return item_object
