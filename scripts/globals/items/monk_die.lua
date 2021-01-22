-----------------------------------
-- ID: 5478
-- Monk Die
-- Teaches the job ability Monk's Roll
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.MONKS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.MONKS_ROLL)
end

return item_object
