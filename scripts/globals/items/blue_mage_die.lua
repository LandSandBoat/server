-----------------------------------
-- ID: 5492
-- Blue Mage Die
-- Teaches the job ability Magus's Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.MAGUSS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.MAGUSS_ROLL)
end

return itemObject
