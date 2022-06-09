-----------------------------------------
-- ID: 6088
-- plate_of_indi-voidance
-- Teaches INDI-VOIDANCE
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_VOIDANCE)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_VOIDANCE)
end

return item_object
