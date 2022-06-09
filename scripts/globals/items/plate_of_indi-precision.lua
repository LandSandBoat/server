-----------------------------------------
-- ID: 6087
-- plate_of_indi-precision
-- Teaches INDI-PRECISION
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_PRECISION)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_PRECISION)
end

return item_object
