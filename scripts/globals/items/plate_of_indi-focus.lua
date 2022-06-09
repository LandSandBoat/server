-----------------------------------------
-- ID: 6089
-- plate_of_indi-focus
-- Teaches INDI-FOCUS
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_FOCUS)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_FOCUS)
end

return item_object
