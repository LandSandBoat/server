-----------------------------------------
-- ID: 6089
-- plate_of_indi-focus
-- Teaches INDI-FOCUS
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FOCUS)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FOCUS)
end

return itemObject
