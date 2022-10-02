-----------------------------------------
-- ID: 6075
-- plate_of_indi-refresh
-- Teaches INDI-REFRESH
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_REFRESH)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_REFRESH)
end

return item_object
