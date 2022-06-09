-----------------------------------------
-- ID: 6099
-- plate_of_indi-slow
-- Teaches INDI-SLOW
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_SLOW)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_SLOW)
end

return item_object
