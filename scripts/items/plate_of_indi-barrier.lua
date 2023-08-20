-----------------------------------------
-- ID: 6084
-- plate_of_indi-barrier
-- Teaches INDI-BARRIER
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_BARRIER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_BARRIER)
end

return itemObject
