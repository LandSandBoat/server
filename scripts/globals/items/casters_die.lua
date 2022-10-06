-----------------------------------
-- ID: 5498
-- Casters Die
-- Teaches the job ability Casters Roll
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnAbility(xi.jobAbility.CASTERS_ROLL)
end

itemObject.onItemUse = function(target)
    target:addLearnedAbility(xi.jobAbility.CASTERS_ROLL)
end

return itemObject
