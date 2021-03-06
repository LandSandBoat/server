-----------------------------------
-- ID: 5501
-- Tactician's Die
-- Teaches the job ability Tactician's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.TACTICIANS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.TACTICIANS_ROLL)
end

return item_object
