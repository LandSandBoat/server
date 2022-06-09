-----------------------------------------
-- ID: 6131
-- plate_of_indi-haste
-- Teaches INDI-HASTE
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_HASTE)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_HASTE)
end

return item_object
