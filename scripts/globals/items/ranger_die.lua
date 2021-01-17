-----------------------------------------
-- ID: 5487
-- Ranger Die
-- Teaches the job ability Hunter's Roll
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.HUNTERS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.HUNTERS_ROLL)
end

return item_object
