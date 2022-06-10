-----------------------------------------
-- ID: 6084
-- plate_of_indi-barrier
-- Teaches INDI-BARRIER
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_BARRIER)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_BARRIER)
end

return item_object
