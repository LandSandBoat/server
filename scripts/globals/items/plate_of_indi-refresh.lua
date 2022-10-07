-----------------------------------------
-- ID: 6075
-- plate_of_indi-refresh
-- Teaches INDI-REFRESH
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_REFRESH)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_REFRESH)
end

return itemObject
