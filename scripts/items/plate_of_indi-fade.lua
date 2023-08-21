-----------------------------------------
-- ID: 6093
-- plate_of_indi-fade
-- Teaches INDI-FADE
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FADE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FADE)
end

return itemObject
