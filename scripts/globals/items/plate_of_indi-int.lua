-----------------------------------------
-- ID: 6080
-- plate_of_indi-int
-- Teaches INDI-INT
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_INT)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_INT)
end

return item_object
