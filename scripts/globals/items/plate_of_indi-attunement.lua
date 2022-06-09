-----------------------------------------
-- ID: 6090
-- plate_of_indi-attunement
-- Teaches INDI-ATTUNEMENT
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_ATTUNEMENT)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_ATTUNEMENT)
end

return item_object
