-----------------------------------------
-- ID: 6094
-- plate_of_indi-malaise
-- Teaches INDI-MALAISE
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.INDI_MALAISE)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.INDI_MALAISE)
end

return item_object
