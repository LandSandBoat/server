-----------------------------------
-- ID: 5488
-- Samurai Die
-- Teaches the job ability Samurai Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.SAMURAI_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.SAMURAI_ROLL)
end

return item_object
