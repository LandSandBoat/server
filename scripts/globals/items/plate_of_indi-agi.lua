-----------------------------------------
-- ID: 6079
-- plate_of_indi-agi
-- Teaches INDI-AGI
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_AGI)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_AGI)
end

return item_object
