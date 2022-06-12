-----------------------------------------
-- ID: 6098
-- plate_of_indi-languor
-- Teaches INDI-LANGUOR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_LANGUOR)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_LANGUOR)
end

return item_object
