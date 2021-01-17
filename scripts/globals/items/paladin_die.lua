-----------------------------------------
-- ID: 5483
-- Paladin Die
-- Teaches the job ability Gallant's Roll
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.GALLANTS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.GALLANTS_ROLL)
end

return item_object
