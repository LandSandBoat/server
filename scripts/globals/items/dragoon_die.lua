-----------------------------------
-- ID: 5490
-- Dragoon Die
-- Teaches the job ability Drachen Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.DRACHEN_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.DRACHEN_ROLL)
end

return item_object
