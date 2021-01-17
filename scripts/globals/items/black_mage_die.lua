-----------------------------------------
-- ID: 5480
-- Black Mage Die
-- Teaches the job ability Wizard's Roll
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnAbility(tpz.jobAbility.WIZARDS_ROLL)
end

item_object.onItemUse = function(target)
    target:addLearnedAbility(tpz.jobAbility.WIZARDS_ROLL)
end

return item_object
