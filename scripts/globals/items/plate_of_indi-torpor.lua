-----------------------------------------
-- ID: 6096
-- plate_of_indi-torpor
-- Teaches INDI-TORPOR
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_TORPOR)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_TORPOR)
end

return item_object
