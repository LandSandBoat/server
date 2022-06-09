-----------------------------------------
-- ID: 6101
-- plate_of_indi-gravity
-- Teaches INDI-GRAVITY
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_GRAVITY)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_GRAVITY)
end

return item_object
