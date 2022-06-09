-----------------------------------------
-- ID: 6093
-- plate_of_indi-fade
-- Teaches INDI-FADE
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FADE)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FADE)
end

return item_object
