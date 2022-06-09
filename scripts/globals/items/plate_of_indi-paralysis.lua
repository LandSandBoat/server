-----------------------------------------
-- ID: 6100
-- plate_of_indi-paralysis
-- Teaches INDI-PARALYSIS
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_PARALYSIS)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_PARALYSIS)
end

return item_object
