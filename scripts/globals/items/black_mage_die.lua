-----------------------------------
-- ID: 5480
-- Black Mage Die
-- Teaches the job ability Wizard's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.WIZARDS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.WIZARDS_ROLL)
end

return itemObject
