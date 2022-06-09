-----------------------------------------
-- ID: 6086
-- plate_of_indi-fend
-- Teaches INDI-FEND
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FEND)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FEND)
end

return item_object
