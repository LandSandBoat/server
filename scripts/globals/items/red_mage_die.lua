-----------------------------------------
-- ID: 5481
-- Red Mage Die
-- Teaches the job ability Warlock's Roll
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.WARLOCKS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.WARLOCKS_ROLL)
end

return item_object
