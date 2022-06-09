-----------------------------------------
-- ID: 6095
-- plate_of_indi-slip
-- Teaches INDI-SLIP
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_SLIP)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_SLIP)
end

return item_object
