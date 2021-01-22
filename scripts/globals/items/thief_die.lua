-----------------------------------
-- ID: 5482
-- Thief Die
-- Teaches the job ability Rogue's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.ROGUES_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.ROGUES_ROLL)
end

return item_object
