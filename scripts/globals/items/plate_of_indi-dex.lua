-----------------------------------------
-- ID: 6077
-- plate_of_indi-dex
-- Teaches INDI-DEX
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_DEX)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_DEX)
end

return item_object
