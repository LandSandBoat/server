-----------------------------------------
-- ID: 6074
-- plate_of_indi-poison
-- Teaches INDI-POISON
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_POISON)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_POISON)
end

return item_object
